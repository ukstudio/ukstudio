# frozen_string_literal: true

require_relative 'test_helper'

class SiteTest < Minitest::Test
  include FixtureHelper

  def test_all_pages_sorted_newest_first
    site = load_fixture_site

    assert_equal ['Rubyのメモ', '2つ目のノート', 'index'], site.all_pages.map(&:title)
  end

  def test_pages_excludes_pages_out_of_collections
    site = load_fixture_site

    refute_includes site.pages.map(&:title), 'index'
  end

  def test_drafts_are_skipped_unless_included
    refute load_fixture_site.find('draft-note')
    assert load_fixture_site(include_drafts: true).find('draft-note')
  end

  def test_find_by_filename_and_title
    site = load_fixture_site

    assert_equal site.find('ruby-note'), site.find('Rubyのメモ')
    assert_nil site.find('unknown')
  end

  def test_backlinks_are_computed_from_wiki_links
    site = load_fixture_site
    second = site.find('second-note')

    assert_equal ['Rubyのメモ'], site.backlinks(second).map(&:title)
  end

  def test_pages_excluded_from_collections_do_not_create_backlinks
    site = load_fixture_site
    ruby_note = site.find('ruby-note')

    # index.md links to ruby-note but is excluded from collections
    assert_empty site.backlinks(ruby_note)
  end

  def test_tags_index
    site = load_fixture_site

    assert_equal ['Ruby', 'プログラミング'], site.tags.keys
    assert_equal ['Rubyのメモ', '2つ目のノート'], site.tags['Ruby'].map(&:title)
  end

  def test_unresolved_wiki_link_raises_with_source_and_candidates
    Dir.mktmpdir do |dir|
      FileUtils.mkdir_p(File.join(dir, 'src'))
      File.write(File.join(dir, 'src', 'a.md'), "---\ntitle: a\ncreated: 2024-01-01\n---\n[[missing-page]]")

      error = assert_raises(Florby::Error) do
        Florby::Site.load(root: dir, config: Florby::Config.new)
      end

      assert_includes error.message, 'a.md'
      assert_includes error.message, '[[missing-page]]'
    end
  end
end
