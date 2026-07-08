# frozen_string_literal: true

require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'
require 'stringio'
require_relative '../lib/florby'

module FixtureHelper
  FIXTURE_SITE = File.expand_path('fixtures/site', __dir__)

  # Loads the fixture site in place (read-only usage).
  def load_fixture_site(include_drafts: false)
    config = Florby::Config.load(FIXTURE_SITE)
    Florby::Site.load(root: FIXTURE_SITE, config: config, include_drafts: include_drafts)
  end

  # Copies the fixture site into a tmpdir so builds can write output.
  def with_fixture_site_copy
    Dir.mktmpdir do |dir|
      root = File.join(dir, 'site')
      FileUtils.cp_r(FIXTURE_SITE, root)
      yield root
    end
  end
end
