# frozen_string_literal: true

module Florby
  # Polls the source, layouts and config.rb for changes and rebuilds.
  # A failing build logs the error and keeps watching.
  class Watcher
    def initialize(root:, include_drafts: false, interval: 1, out: $stdout)
      @root = root
      @include_drafts = include_drafts
      @interval = interval
      @out = out
      @running = false
    end

    def start
      @running = true
      snapshot = nil

      while @running
        current = scan
        if current != snapshot
          rebuild(initial: snapshot.nil?)
          snapshot = current
        end
        sleep @interval
      end
    end

    def stop
      @running = false
    end

    private def scan
      config = Config.load(@root)
      paths = [File.join(@root, 'config.rb')] +
              Dir.glob(File.join(@root, config.source_dir, '**', '*')) +
              Dir.glob(File.join(@root, config.layouts_dir, '**', '*'))

      paths.select { |path| File.file?(path) }.to_h { |path| [path, File.mtime(path)] }
    end

    private def rebuild(initial:)
      @out.puts(initial ? 'building...' : 'files changed, rebuilding...')
      Builder.new(root: @root, include_drafts: @include_drafts, out: @out).build
    rescue Florby::Error => e
      warn "florby: build failed: #{e.message}"
    rescue StandardError => e
      warn "florby: build failed: #{e.class}: #{e.message}"
    end
  end
end
