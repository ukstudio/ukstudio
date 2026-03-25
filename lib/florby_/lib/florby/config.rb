module Florby
  class Config
    def initialize
      @options = {}
    end

    def load_file(path)
      instance_eval(File.read(File.join(Dir.pwd, path)))
    end

    def fetch(key)
      @options.fetch(key)
    end

    def copy_from(path)
      @options['copy_from'] ||= []
      @options['copy_from'] << path
    end

    def copy_files
      @options['copy_from'] ||= []
    end

    def host(url)
      @options['host'] = url
    end

    def source_dir(path)
      @options['source_dir'] = path
    end

    def set_default(key, value)
      @options[key] = value unless @options.has_key?(key)
    end

    def has_key?(key)
      @options.has_key?(key)
    end
  end
end
