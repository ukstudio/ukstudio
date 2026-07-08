# frozen_string_literal: true

require_relative 'test_helper'

class PageTest < Minitest::Test
  def build_page(content, filename: 'note.md')
    @dir = Dir.mktmpdir
    path = File.join(@dir, filename)
    File.write(path, content)
    Florby::Page.new(path: path)
  end

  def teardown
    FileUtils.remove_entry(@dir) if @dir
  end

  def test_title_falls_back_to_filename
    page = build_page("body\n", filename: 'My Note.md')

    assert_equal 'My Note', page.title
  end

  def test_permalink_is_normalized_with_slashes
    page = build_page("---\ntitle: Hello\n---\nbody")

    assert_equal '/Hello/', page.permalink
  end

  def test_permalink_from_front_matter
    page = build_page("---\npermalink: /\n---\nbody")

    assert_equal '/', page.permalink
  end

  def test_encoded_permalink_escapes_non_ascii
    page = build_page("---\ntitle: Rubyのメモ\n---\nbody")

    assert_equal '/Ruby%E3%81%AE%E3%83%A1%E3%83%A2/', page.encoded_permalink
  end

  def test_dates_accept_date_and_string
    page = build_page("---\ncreated: 2024-01-02\nupdated: '2024-03-04'\n---\nbody")

    assert_equal Date.new(2024, 1, 2), page.created
    assert_equal Date.new(2024, 3, 4), page.updated
  end

  def test_dates_fall_back_to_file_stat
    page = build_page("body\n")

    assert_equal File.mtime(page.path).to_date, page.updated
  end

  def test_invalid_date_raises_with_filename
    page = build_page("---\ncreated: not-a-date\n---\nbody")

    error = assert_raises(Florby::Error) { page.created }
    assert_includes error.message, 'note.md'
  end

  def test_draft_and_exclude_accept_boolean_and_string
    assert build_page("---\ndraft: true\n---\nbody").draft?
    assert build_page("---\ndraft: 'true'\n---\nbody").draft?
    refute build_page("body\n").draft?

    assert build_page("---\nexclude_from_collections: \"true\"\n---\nbody").exclude_from_collections?
    assert build_page("---\nexclude_from_collections: true\n---\nbody").exclude_from_collections?
  end

  def test_tags_default_to_empty
    assert_empty build_page("body\n").tags
    assert_equal %w[Ruby 音楽], build_page("---\ntags: [Ruby, 音楽]\n---\nbody").tags
  end

  def test_description_prefers_front_matter
    page = build_page("---\ndescription: 手書き\n---\n本文")

    assert_equal '手書き', page.description
  end

  def test_description_is_excerpted_from_body
    page = build_page(<<~MD)
      ## 見出し

      これは [[リンク先|ラベル]] と `code` を含む **本文** です。
    MD

    assert_equal '見出し これは ラベル と code を含む 本文 です。', page.description
  end

  def test_description_drops_list_and_quote_markers
    page = build_page(<<~MD)
      本文です。

      - 一つ目
      - 二つ目

      > 引用
    MD

    assert_equal '本文です。 一つ目 二つ目 引用', page.description
  end

  def test_description_is_truncated
    page = build_page("あ" * 200)

    assert_equal 120, page.description.length
  end

  def test_wiki_links_are_extracted_from_body
    page = build_page("---\ntitle: t\n---\n[[a]] [[b|c]]")

    assert_equal %w[a b], page.wiki_links.map(&:target)
  end
end
