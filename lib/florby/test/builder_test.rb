# frozen_string_literal: true

require_relative 'test_helper'

class BuilderTest < Minitest::Test
  include FixtureHelper

  def build(root, include_drafts: false)
    Florby::Builder.new(root: root, include_drafts: include_drafts, out: StringIO.new).build
  end

  def read(root, *path)
    File.read(File.join(root, '_build', *path))
  end

  def test_builds_pages_at_permalinks
    with_fixture_site_copy do |root|
      build(root)

      assert_includes read(root, 'index.html'), 'Rubyのメモ'
      assert_includes read(root, 'Rubyのメモ', 'index.html'), 'カスタムラベル'
      assert_includes read(root, '2つ目のノート', 'index.html'), '2つ目のノートの本文。'
    end
  end

  def test_renders_backlinks_through_layout
    with_fixture_site_copy do |root|
      build(root)

      assert_includes read(root, '2つ目のノート', 'index.html'), %(<a href="/Rubyのメモ/">Rubyのメモ</a>)
    end
  end

  def test_writes_alias_redirects
    with_fixture_site_copy do |root|
      build(root)
      html = read(root, 'old-note', 'index.html')

      assert_includes html, %(<link rel="canonical" href="https://example.com/2つ目のノート/">)
      assert_includes html, 'http-equiv="refresh"'
    end
  end

  def test_writes_tag_pages
    with_fixture_site_copy do |root|
      build(root)
      html = read(root, 'tags', 'Ruby', 'index.html')

      assert_includes html, %(<a href="/Rubyのメモ/">Rubyのメモ</a>)
      assert_includes html, %(<a href="/2つ目のノート/">2つ目のノート</a>)
      assert File.exist?(File.join(root, '_build', 'tags', 'プログラミング', 'index.html'))
    end
  end

  def test_skips_tag_pages_without_tag_layout
    with_fixture_site_copy do |root|
      FileUtils.rm(File.join(root, 'layouts', 'tag.erb'))
      build(root)

      refute File.exist?(File.join(root, '_build', 'tags'))
    end
  end

  def test_writes_feed_and_sitemap
    with_fixture_site_copy do |root|
      build(root)

      feed = read(root, 'feed.xml')
      assert_includes feed, '<feed xmlns="http://www.w3.org/2005/Atom">'
      refute_includes feed, '下書きノート'

      sitemap = read(root, 'sitemap.xml')
      assert_includes sitemap, '<loc>https://example.com/Ruby%E3%81%AE%E3%83%A1%E3%83%A2/</loc>'
      assert_includes sitemap, '<loc>https://example.com/tags/Ruby/</loc>'
    end
  end

  def test_copies_files_from_copy_from
    with_fixture_site_copy do |root|
      build(root)

      assert File.exist?(File.join(root, '_build', 'assets', 'style.css'))
    end
  end

  def test_drafts_are_excluded_by_default_and_included_on_demand
    with_fixture_site_copy do |root|
      build(root)
      refute File.exist?(File.join(root, '_build', '下書きノート'))

      build(root, include_drafts: true)
      assert File.exist?(File.join(root, '_build', '下書きノート', 'index.html'))
    end
  end

  def test_failed_build_keeps_previous_output
    with_fixture_site_copy do |root|
      build(root)
      File.write(File.join(root, 'src', 'broken.md'), "---\ntitle: broken\ncreated: 2024-01-01\n---\n[[no-such-page]]")

      assert_raises(Florby::Error) { build(root) }
      assert File.exist?(File.join(root, '_build', 'Rubyのメモ', 'index.html'))
    end
  end

  def test_missing_host_raises
    with_fixture_site_copy do |root|
      File.write(File.join(root, 'config.rb'), "title 'no host'\n")

      error = assert_raises(Florby::Error) { build(root) }
      assert_includes error.message, 'host'
    end
  end
end
