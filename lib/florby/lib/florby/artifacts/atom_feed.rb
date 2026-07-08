# frozen_string_literal: true

require 'cgi'

module Florby
  module Artifacts
    class AtomFeed
      MAX_ENTRIES = 20

      def initialize(site:, renderer:)
        @site = site
        @renderer = renderer
        @config = site.config
      end

      def to_xml
        pages = @site.pages.first(MAX_ENTRIES)

        <<~XML
          <?xml version="1.0" encoding="utf-8"?>
          <feed xmlns="http://www.w3.org/2005/Atom">
            <title>#{h(@config.title)}</title>
            #{subtitle_tag}<link href="#{h(@config.host)}/feed.xml" rel="self"/>
            <link href="#{h(@config.host)}/"/>
            <id>#{h(@config.host)}/</id>
            <updated>#{atom_time(pages.map(&:updated).max)}</updated>
            #{author_tag}#{pages.map { |page| entry(page) }.join}
          </feed>
        XML
      end

      private def entry(page)
        url = "#{@config.host}#{page.encoded_permalink}"
        <<~XML
          <entry>
            <title>#{h(page.title)}</title>
            <link href="#{h(url)}"/>
            <id>#{h(url)}</id>
            <published>#{atom_time(page.created)}</published>
            <updated>#{atom_time(page.updated)}</updated>
            <summary>#{h(page.description)}</summary>
            <content type="html">#{h(@renderer.render(page))}</content>
          </entry>
        XML
      end

      private def subtitle_tag
        return '' unless @config.description

        "<subtitle>#{h(@config.description)}</subtitle>\n  "
      end

      private def author_tag
        return '' unless @config.author

        "<author><name>#{h(@config.author)}</name></author>\n  "
      end

      private def atom_time(date)
        (date || Date.today).to_time.utc.strftime('%Y-%m-%dT%H:%M:%SZ')
      end

      private def h(text)
        CGI.escapeHTML(text.to_s)
      end
    end
  end
end
