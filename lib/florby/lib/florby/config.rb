# frozen_string_literal: true

module Florby
  # Reads config.rb at the site root. Each setting is written DSL-style
  # (`host 'https://example.com'`) and read back as a plain method
  # (`config.host`).
  class Config
    def self.setting(name, default: nil)
      define_method(name) do |*args|
        if args.empty?
          @settings.fetch(name, default)
        else
          @settings[name] = args.first
        end
      end
    end
    private_class_method :setting

    setting :host
    setting :title
    setting :description
    setting :author
    setting :og_image
    setting :source_dir, default: 'src'
    setting :output_dir, default: '_build'
    setting :layouts_dir, default: 'layouts'

    def self.load(root)
      config = new
      path = File.join(root, 'config.rb')
      config.instance_eval(File.read(path), path) if File.exist?(path)
      config
    end

    def initialize
      @settings = {}
      @copy_from = []
    end

    def copy_from(path = nil)
      @copy_from << path if path
      @copy_from
    end
  end
end
