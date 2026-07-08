# frozen_string_literal: true

require_relative 'florby/version'
require_relative 'florby/config'
require_relative 'florby/front_matter'
require_relative 'florby/wiki_link'
require_relative 'florby/page'
require_relative 'florby/site'
require_relative 'florby/markdown_renderer'
require_relative 'florby/template'
require_relative 'florby/artifacts/sitemap'
require_relative 'florby/artifacts/atom_feed'
require_relative 'florby/artifacts/alias_page'
require_relative 'florby/artifacts/tag_page'
require_relative 'florby/builder'
require_relative 'florby/server'
require_relative 'florby/watcher'
require_relative 'florby/cli'

module Florby
  class Error < StandardError; end
end
