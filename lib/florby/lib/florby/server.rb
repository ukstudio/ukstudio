# frozen_string_literal: true

require 'webrick'

module Florby
  class Server
    def initialize(root:, port: 8081, watch: false, include_drafts: false, out: $stdout)
      @root = root
      @port = port
      @watch = watch
      @include_drafts = include_drafts
      @out = out
    end

    def start
      config = Config.load(@root)

      watcher = @watch ? Watcher.new(root: @root, include_drafts: @include_drafts, out: @out) : nil
      # The watcher builds once on startup; without it, build here so the
      # server never serves a stale or missing output directory.
      build_once unless watcher

      server = WEBrick::HTTPServer.new(
        DocumentRoot: File.join(@root, config.output_dir),
        Port: @port
      )

      watcher_thread = watcher && Thread.new { watcher.start }

      trap(:INT) do
        watcher&.stop
        server.shutdown
      end

      server.start
      watcher_thread&.join
    end

    private def build_once
      Builder.new(root: @root, include_drafts: @include_drafts, out: @out).build
    rescue Florby::Error => e
      warn "florby: build failed: #{e.message}"
    end
  end
end
