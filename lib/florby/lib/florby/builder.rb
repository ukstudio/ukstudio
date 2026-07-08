# frozen_string_literal: true

require 'fileutils'

module Florby
  # Orchestrates a build: renders every document in memory first, then
  # cleans the output directory and writes everything out. A failing
  # build therefore never destroys the previous output.
  class Builder
    def initialize(root:, include_drafts: false, out: $stdout)
      @root = root
      @include_drafts = include_drafts
      @out = out
    end

    def build
      config = Config.load(@root)
      raise Florby::Error, 'config.rb に host を設定してください' unless config.host

      site = Site.load(root: @root, config: config, include_drafts: @include_drafts)
      renderer = MarkdownRenderer.new(site: site)
      template = Template.new(root: @root, site: site, renderer: renderer)
      tag_pages = template.layout_exist?('tag') ? build_tag_pages(site) : []

      documents = render_documents(site, template, renderer, tag_pages, config)

      clean_output(config)
      copy_files(config)
      documents.each { |relative_path, content| write(config, relative_path, content) }

      @out.puts "built #{site.all_pages.size} pages into #{config.output_dir}/"
    end

    private def render_documents(site, template, renderer, tag_pages, config)
      documents = {}

      site.all_pages.each do |page|
        documents[html_path(page.permalink)] = template.render_page(page)
        page.aliases.each do |alias_path|
          alias_page = Artifacts::AliasPage.new(url: "#{config.host}#{page.permalink}")
          documents[html_path(alias_path)] = alias_page.to_html
        end
      end

      tag_pages.each do |tag_page|
        documents[html_path(tag_page.permalink)] =
          template.render('tag', assigns: { tag: tag_page.tag, pages: tag_page.pages })
      end

      documents['feed.xml'] = Artifacts::AtomFeed.new(site: site, renderer: renderer).to_xml
      documents['sitemap.xml'] = sitemap(site, tag_pages, config).to_xml
      documents
    end

    private def build_tag_pages(site)
      site.tags.map { |tag, pages| Artifacts::TagPage.new(tag: tag, pages: pages) }
    end

    private def sitemap(site, tag_pages, config)
      entries = site.all_pages.map do |page|
        Artifacts::Sitemap::Entry.new(loc: "#{config.host}#{page.encoded_permalink}", lastmod: page.updated)
      end
      entries += tag_pages.map do |tag_page|
        Artifacts::Sitemap::Entry.new(loc: "#{config.host}#{tag_page.encoded_permalink}", lastmod: tag_page.updated)
      end
      Artifacts::Sitemap.new(entries: entries)
    end

    # "/foo/bar/" => "foo/bar/index.html", "/" => "index.html"
    private def html_path(permalink)
      segments = permalink.split('/').reject(&:empty?)
      File.join(*segments, 'index.html')
    end

    private def clean_output(config)
      output = output_dir(config)
      FileUtils.rm_rf(Dir.glob(File.join(output, '*')))
      FileUtils.mkdir_p(output)
    end

    private def copy_files(config)
      config.copy_from.each do |path|
        source = File.join(@root, config.source_dir, path)
        raise Florby::Error, "copy_from の対象が見つかりません: #{source}" unless File.exist?(source)

        FileUtils.cp_r(source, output_dir(config))
      end
    end

    private def write(config, relative_path, content)
      full_path = File.join(output_dir(config), relative_path)
      FileUtils.mkdir_p(File.dirname(full_path))
      File.write(full_path, content)
    end

    private def output_dir(config)
      File.join(@root, config.output_dir)
    end
  end
end
