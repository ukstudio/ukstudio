# frozen_string_literal: true

require 'cgi'

module Florby
  module Artifacts
    # A tiny redirect page written at an alias path, pointing to the
    # canonical URL of the real page.
    class AliasPage
      def initialize(url:)
        @url = url
      end

      def to_html
        escaped = CGI.escapeHTML(@url)
        <<~HTML
          <!doctype html>
          <html>
            <head>
              <meta charset="utf-8">
              <meta http-equiv="refresh" content="0; URL='#{escaped}'">
              <link rel="canonical" href="#{escaped}">
            </head>
            <body></body>
          </html>
        HTML
      end
    end
  end
end
