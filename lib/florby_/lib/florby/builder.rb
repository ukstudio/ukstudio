require 'fileutils'
require 'sitemap_generator'

require 'florby/page'
require 'florby/plugins'
require 'florby/renderer'
require 'florby/collection'
require 'florby/config'

module Florby
  class Builder
    def self.run
      new.run
    end

    def run
      remove_old_files

      @config = Florby::Config.new
      if File.exist?(File.join(Dir.pwd, 'config.rb'))
        @config.load_file('config.rb')
      end

      @config.set_default('source_dir', 'src') unless @config.has_key?('source_dir')

      copy_files

      collection = Collection.new(source_dir: @config.fetch('source_dir'))
      Plugins::WikiLinkReplacer.new(collection: collection).replace!

      collection.all_pages.each do |page|
        html = Renderer.new(page: page, collection: collection).render
        write_html(page.permalink, html)
        page.aliases.each do |alias_path|
          write_html(alias_path, alias_html(page.permalink))
        end
      end

      SitemapGenerator::Sitemap.default_host = @config.fetch('host')
      SitemapGenerator::Sitemap.public_path = '_build'
      SitemapGenerator::Sitemap.compress = false
      SitemapGenerator::Sitemap.create do
        collection.all_pages.each do |page|
          add page.permalink, lastmod: page.updated
        end
      end
    end

    private def remove_old_files
      puts 'remove old files'
      FileUtils.rm_rf(Dir.glob(File.join(Dir.pwd, '_build', '*')))
    end

    private def copy_files
      @config.copy_files.each do |path|
        puts "copy #{path}"
        FileUtils.cp_r(File.join(Dir.pwd, @config.fetch('source_dir'), path), File.join(Dir.pwd, '_build'))
      end
    end

    private def write_html(permalink, html)
      paths = permalink.split('/')

      if paths.empty?
        File.open(File.join(Dir.pwd, '_build', 'index.html'), 'w+') do |f|
          f.write(html)
        end
      else
        full_path = File.join('_build', File.join(paths))
        FileUtils.mkdir_p(File.join(Dir.pwd, full_path))
        File.open(File.join(Dir.pwd, full_path, 'index.html'), 'w+') do |f|
          f.write(html)
        end
      end
    end

    private def alias_html(canonical)
      <<~HTML
        <html>
          <meta http-equiv="refresh" content="0; URL='#{@config.fetch('host')}#{canonical}'">
          <link rel="canonical" href="#{@config.fetch('host')}#{canonical}">
        </html>
      HTML
    end
  end
end
