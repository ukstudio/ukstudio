require 'cgi'
require 'set'

module Florby
  module Plugins
    class WikiLinkReplacer
      WIKI_LINK_REGEXP = /\[\[\s?([^\[\]\|\n\r]+)(\|[^\[\]\|\n\r]+)?\s?\]\]/

      def initialize(collection:)
        @collection = collection
        @processed_links = {}
      end

      def replace!
        @collection.all_pages.each do |page|
          page.meta['backlinks'] ||= []
          @processed_links[page] = Set.new

          page.content =
            page.content.gsub(WIKI_LINK_REGEXP) do |match|

              title = CGI.unescapeHTML(Regexp.last_match(1))
              destination = @collection.find(title)

              raise "Page not found: #{title}. #{@collection.titles}" unless destination

              unless page.exclude_from_collections? || @processed_links[page].include?(title)
                destination.meta['backlinks'] ||= []
                destination.meta['backlinks'] << page unless destination.meta['backlinks'].include?(page)
                @processed_links[page].add(title)
              end

              "<a href='#{destination.permalink}'>#{destination.title}</a>"
            end
        end
      end
    end
  end
end
