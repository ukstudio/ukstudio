# frozen_string_literal: true

require 'optparse'

module Florby
  class CLI
    USAGE = <<~TEXT
      Usage: florby <command> [options]

      Commands:
        build    Build the site into the output directory
        server   Serve the built site (use --watch to rebuild on change)
        watch    Rebuild the site whenever source files change
        version  Print the version

      Options:
        --drafts       Include pages marked as draft: true
        --port PORT    Port for the dev server (default: 8081)
    TEXT

    def self.run(argv)
      new(root: Dir.pwd).run(argv)
    end

    def initialize(root:, out: $stdout)
      @root = root
      @out = out
    end

    def run(argv)
      argv = argv.dup
      command = argv.shift
      options = parse_options(argv)

      case command
      when 'build'
        Builder.new(root: @root, include_drafts: options[:drafts]).build
        0
      when 'server'
        Server.new(root: @root, port: options[:port], watch: options[:watch], include_drafts: options[:drafts]).start
        0
      when 'watch'
        Watcher.new(root: @root, include_drafts: options[:drafts]).start
        0
      when 'version', '--version', '-v'
        @out.puts "florby #{VERSION}"
        0
      else
        @out.puts USAGE
        command.nil? ? 0 : 1
      end
    rescue Florby::Error => e
      warn "florby: #{e.message}"
      1
    end

    private def parse_options(argv)
      options = { drafts: false, watch: false, port: 8081 }
      OptionParser.new do |parser|
        parser.on('--drafts') { options[:drafts] = true }
        parser.on('--watch') { options[:watch] = true }
        parser.on('--port PORT', Integer) { |port| options[:port] = port }
      end.parse!(argv)
      options
    rescue OptionParser::ParseError => e
      raise Florby::Error, e.message
    end
  end
end
