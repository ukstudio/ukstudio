# frozen_string_literal: true

require_relative "lib/florby/version"

Gem::Specification.new do |spec|
  spec.name = "florby"
  spec.version = Florby::VERSION
  spec.authors = ["AKAMATSU Yuki"]
  spec.email = ["y.akamatsu@ukstudio.jp"]

  spec.summary = "a static site generator for digital garden"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = 'https://github.com/ukstudio/florby'
  spec.metadata["source_code_uri"] = 'https://github.com/ukstudio/florby'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = ["florby"]
  spec.require_paths = ["lib"]

  spec.add_dependency "commonmarker"
  spec.add_dependency "webrick"
  spec.add_dependency "bigdecimal"
  spec.add_dependency "sitemap_generator"
end
