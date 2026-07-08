# frozen_string_literal: true

require_relative 'test_helper'

class ConfigTest < Minitest::Test
  include FixtureHelper

  def test_loads_settings_from_config_rb
    config = Florby::Config.load(FIXTURE_SITE)

    assert_equal 'https://example.com', config.host
    assert_equal 'Example Garden', config.title
    assert_equal 'A tiny fixture site', config.description
    assert_equal 'Fixture Author', config.author
    assert_equal 'https://example.com/assets/og.png', config.og_image
    assert_equal ['/assets'], config.copy_from
  end

  def test_defaults
    config = Florby::Config.new

    assert_nil config.host
    assert_equal 'src', config.source_dir
    assert_equal '_build', config.output_dir
    assert_equal 'layouts', config.layouts_dir
    assert_empty config.copy_from
  end

  def test_missing_config_file_uses_defaults
    Dir.mktmpdir do |dir|
      config = Florby::Config.load(dir)

      assert_equal 'src', config.source_dir
    end
  end
end
