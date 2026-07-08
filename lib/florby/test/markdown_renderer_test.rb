# frozen_string_literal: true

require_relative 'test_helper'

class MarkdownRendererTest < Minitest::Test
  include FixtureHelper

  def setup
    @site = load_fixture_site
    @renderer = Florby::MarkdownRenderer.new(site: @site)
  end

  def test_renders_wiki_links_as_anchors
    html = @renderer.render(@site.find('ruby-note'))

    assert_includes html, %(<a href="/2つ目のノート/">2つ目のノート</a>)
  end

  def test_uses_custom_label_when_given
    html = @renderer.render(@site.find('ruby-note'))

    assert_includes html, %(<a href="/2つ目のノート/">カスタムラベル</a>)
  end

  def test_keeps_wiki_links_inside_code
    html = @renderer.render(@site.find('ruby-note'))

    assert_includes html, '[[code-fence-link]]'
    assert_includes html, '[[inline-code-link]]'
  end

  def test_resolves_by_title_too
    html = @renderer.render(@site.find('index'))

    assert_includes html, %(<a href="/Rubyのメモ/">Rubyのメモ</a>)
  end
end
