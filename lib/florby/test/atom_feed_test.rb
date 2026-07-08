# frozen_string_literal: true

require_relative 'test_helper'

class AtomFeedTest < Minitest::Test
  include FixtureHelper

  def build_feed(site = load_fixture_site)
    renderer = Florby::MarkdownRenderer.new(site: site)
    Florby::Artifacts::AtomFeed.new(site: site, renderer: renderer).to_xml
  end

  def test_feed_metadata_comes_from_config
    xml = build_feed

    assert_includes xml, '<title>Example Garden</title>'
    assert_includes xml, '<subtitle>A tiny fixture site</subtitle>'
    assert_includes xml, '<author><name>Fixture Author</name></author>'
    assert_includes xml, '<link href="https://example.com/feed.xml" rel="self"/>'
  end

  def test_entries_exclude_index_and_use_encoded_urls
    xml = build_feed

    assert_includes xml, '<title>Rubyのメモ</title>'
    assert_includes xml, '<id>https://example.com/Ruby%E3%81%AE%E3%83%A1%E3%83%A2/</id>'
    refute_includes xml, '<title>index</title>' # excluded from collections
  end

  def test_entry_content_is_escaped_html
    xml = build_feed

    assert_includes xml, '&lt;a href='
  end

  def test_timestamps_are_rfc3339
    xml = build_feed

    assert_match %r{<published>2024-01-0\dT\d{2}:\d{2}:\d{2}Z</published>}, xml
  end
end
