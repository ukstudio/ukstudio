# frozen_string_literal: true

require_relative 'test_helper'

class FrontMatterTest < Minitest::Test
  def test_parses_attributes_and_body
    attributes, body = Florby::FrontMatter.parse(<<~MD)
      ---
      title: Hello
      created: 2024-01-01
      ---
      body text
    MD

    assert_equal 'Hello', attributes['title']
    assert_equal Date.new(2024, 1, 1), attributes['created']
    assert_equal "body text\n", body
  end

  def test_returns_whole_text_when_no_front_matter
    attributes, body = Florby::FrontMatter.parse("just a body\n")

    assert_empty attributes
    assert_equal "just a body\n", body
  end

  def test_keeps_thematic_breaks_in_body
    _, body = Florby::FrontMatter.parse(<<~MD)
      ---
      title: Hello
      ---
      before

      ---

      after
    MD

    assert_includes body, "---\n"
    assert_includes body, 'after'
  end

  def test_raises_on_invalid_yaml
    error = assert_raises(Florby::Error) do
      Florby::FrontMatter.parse("---\ntitle: [\n---\nbody", filename: 'broken.md')
    end

    assert_includes error.message, 'broken.md'
  end

  def test_raises_when_front_matter_is_not_a_mapping
    assert_raises(Florby::Error) do
      Florby::FrontMatter.parse("---\n- a\n- b\n---\nbody")
    end
  end

  def test_truthy_accepts_boolean_and_string
    assert Florby::FrontMatter.truthy?(true)
    assert Florby::FrontMatter.truthy?('true')
    refute Florby::FrontMatter.truthy?(false)
    refute Florby::FrontMatter.truthy?(nil)
    refute Florby::FrontMatter.truthy?('false')
  end
end
