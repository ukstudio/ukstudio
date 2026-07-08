# frozen_string_literal: true

require 'cgi'
require 'commonmarker'

module Florby
  # Converts a page's Markdown to HTML, resolving wiki links against the
  # site on the way. Results are memoized because index-style layouts
  # render the same pages repeatedly.
  class MarkdownRenderer
    COMMONMARK_OPTIONS = {
      extension: { tagfilter: false, autolink: true, table: true },
      render: { unsafe: true }
    }.freeze

    def initialize(site:)
      @site = site
      @cache = {}
    end

    def render(page)
      @cache[page] ||= Commonmarker.to_html(resolve_wiki_links(page), options: COMMONMARK_OPTIONS)
    end

    private def resolve_wiki_links(page)
      WikiLink.replace(page.body) do |link|
        destination = @site.resolve!(link, from: page)
        text = link.label || destination.title
        %(<a href="#{CGI.escapeHTML(destination.permalink)}">#{CGI.escapeHTML(text)}</a>)
      end
    end
  end
end
