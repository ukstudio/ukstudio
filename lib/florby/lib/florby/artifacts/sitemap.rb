# frozen_string_literal: true

require 'cgi'

module Florby
  module Artifacts
    class Sitemap
      Entry = Data.define(:loc, :lastmod)

      def initialize(entries:)
        @entries = entries
      end

      def to_xml
        urls = @entries.map do |entry|
          <<~XML.chomp
            <url>
                <loc>#{CGI.escapeHTML(entry.loc)}</loc>
                <lastmod>#{entry.lastmod.iso8601}</lastmod>
              </url>
          XML
        end

        <<~XML
          <?xml version="1.0" encoding="UTF-8"?>
          <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
            #{urls.join("\n  ")}
          </urlset>
        XML
      end
    end
  end
end
