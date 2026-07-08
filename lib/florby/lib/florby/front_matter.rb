# frozen_string_literal: true

require 'yaml'
require 'date'

module Florby
  module FrontMatter
    PATTERN = /\A---\s*\n(.*?)^---\s*\n/m

    # Returns [attributes, body]. Files without front matter get empty
    # attributes and the whole text as body.
    def self.parse(text, filename: '(front matter)')
      match = PATTERN.match(text)
      return [{}, text] unless match

      attributes = YAML.safe_load(match[1], permitted_classes: [Date], aliases: true, filename: filename) || {}
      raise Florby::Error, "#{filename}: front matter must be a mapping" unless attributes.is_a?(Hash)

      [attributes, match.post_match]
    rescue Psych::SyntaxError => e
      raise Florby::Error, "#{filename}: invalid front matter: #{e.message}"
    end

    # Front matter values written by hand end up as booleans or strings
    # depending on quoting; treat both `true` and `'true'` as true.
    def self.truthy?(value)
      value == true || value == 'true'
    end
  end
end
