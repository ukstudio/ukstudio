# frozen_string_literal: true

require 'erb'

module Florby
  module Artifacts
    # The listing page for one tag, rendered through layouts/tag.erb.
    class TagPage
      attr_reader :tag, :pages

      def initialize(tag:, pages:)
        @tag = tag
        @pages = pages
      end

      def permalink
        "/tags/#{tag}/"
      end

      def encoded_permalink
        "/tags/#{ERB::Util.url_encode(tag)}/"
      end

      def updated
        pages.map(&:updated).max
      end
    end
  end
end
