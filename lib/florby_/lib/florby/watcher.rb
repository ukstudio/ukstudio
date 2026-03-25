require 'find'

module Florby
  module Watcher
    def self.run
      files_mtime = {}
      @running = true

      while @running
        changed = false

        Find.find(File.join(Dir.pwd, 'src')) do |path|
          next unless File.file?(path)

          mtime = File.mtime(path)
          if files_mtime[path] != mtime
            files_mtime[path] = mtime
            changed = true
          end
        end

        if changed
          puts "Files changed, rebuilding..."
          Florby::Builder.run
        end

        sleep 1
      end
    end

    def self.stop
      @running = false
    end
  end
end
