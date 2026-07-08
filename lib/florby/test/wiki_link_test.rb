# frozen_string_literal: true

require_relative 'test_helper'

class WikiLinkTest < Minitest::Test
  def test_scans_simple_links
    links = Florby::WikiLink.scan('see [[Ruby]] and [[ RSpec ]]')

    assert_equal %w[Ruby RSpec], links.map(&:target)
    assert_equal [nil, nil], links.map(&:label)
  end

  def test_scans_labeled_links
    links = Florby::WikiLink.scan('see [[Ruby|るびー]]')

    assert_equal 'Ruby', links.first.target
    assert_equal 'るびー', links.first.label
  end

  def test_ignores_links_in_fenced_code_blocks
    markdown = <<~MD
      before [[real]]

      ```
      [[fenced]]
      ```

      after
    MD

    assert_equal ['real'], Florby::WikiLink.scan(markdown).map(&:target)
  end

  def test_ignores_links_in_inline_code
    links = Florby::WikiLink.scan('code `[[inline]]` and [[real]]')

    assert_equal ['real'], links.map(&:target)
  end

  def test_replace_rewrites_links_outside_code
    markdown = "[[Ruby|るびー]] and `[[Ruby]]`"
    result = Florby::WikiLink.replace(markdown) { |link| "<#{link.label || link.target}>" }

    assert_equal '<るびー> and `[[Ruby]]`', result
  end
end
