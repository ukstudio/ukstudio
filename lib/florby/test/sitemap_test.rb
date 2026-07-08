# frozen_string_literal: true

require_relative 'test_helper'

class SitemapTest < Minitest::Test
  def test_renders_entries_with_escaping
    sitemap = Florby::Artifacts::Sitemap.new(entries: [
      Florby::Artifacts::Sitemap::Entry.new(loc: 'https://example.com/a&b/', lastmod: Date.new(2024, 1, 1))
    ])
    xml = sitemap.to_xml

    assert_includes xml, '<loc>https://example.com/a&amp;b/</loc>'
    assert_includes xml, '<lastmod>2024-01-01</lastmod>'
    assert_includes xml, '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">'
  end
end
