module Florby
  require 'florby/builder'
  require 'florby/server'
  require 'florby/watcher' # 新しく追加するモジュール

  class CLI
    def self.run(args)
      subcommand = args.shift

      case subcommand
      when "build"
        Florby::Builder.run
      when "server"
        watch_mode = args.include?("--watch")
        Florby::Server.run(watch_mode: watch_mode)
      when "watch"
        Florby::Watcher.run
      else
        puts "unknown command"
      end
    end
  end
end
