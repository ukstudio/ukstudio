require 'webrick'
require 'thread'

module Florby
  class Server
    def self.run(watch_mode: false)
      new.run(watch_mode: watch_mode)
    end

    def run(watch_mode: false)
      server = WEBrick::HTTPServer.new(
        DocumentRoot: File.join(Dir.pwd, '_build'),
        Port: 8081,
      )

      trap(:INT) do
        Florby::Watcher.stop if watch_mode
        server.shutdown
      end

      if watch_mode
        watcher_thread = Thread.new do
          Florby::Watcher.run
        end
      end

      server.start

      watcher_thread.join if watch_mode
    end
  end
end
