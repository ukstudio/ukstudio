# frozen_string_literal: true

require_relative 'lib/florby/version'

Gem::Specification.new do |spec|
  spec.name = 'florby'
  spec.version = Florby::VERSION
  spec.authors = ['ukstudio']
  spec.email = ['ukstudio@ukstudio.jp']

  spec.summary = 'A static site generator for digital gardens'
  spec.description = 'Florby builds a digital garden from Markdown files with wiki links, backlinks, tags, drafts and an Atom feed.'
  spec.homepage = 'https://github.com/ukstudio/ukstudio'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2'

  spec.files = Dir['lib/**/*.rb', 'exe/*', 'README.md', 'LICENSE']
  spec.bindir = 'exe'
  spec.executables = ['florby']
  spec.require_paths = ['lib']

  spec.add_dependency 'commonmarker'
  spec.add_dependency 'webrick'
end
