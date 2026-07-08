# frozen_string_literal: true

module Florby
  # The whole set of pages plus the indexes derived from them:
  # filename/title lookup, the backlink graph and the tag index.
  class Site
    attr_reader :config

    def self.load(root:, config:, include_drafts: false)
      paths = Dir.glob(File.join(root, config.source_dir, '*.md')).sort
      pages = paths.map { |path| Page.new(path: path) }
      pages = pages.reject(&:draft?) unless include_drafts
      new(pages: pages, config: config)
    end

    def initialize(pages:, config:)
      @config = config
      @pages = pages.sort_by(&:created).reverse
      @by_filename = @pages.to_h { |page| [page.filename, page] }
      @by_title = @pages.to_h { |page| [page.title, page] }
      @backlinks = build_backlinks
    end

    # Every page, newest first. Includes pages excluded from collections.
    def all_pages
      @pages
    end

    # Pages meant to appear in listings and feeds.
    def pages
      @pages.reject(&:exclude_from_collections?)
    end

    def find(name)
      @by_filename[name] || @by_title[name]
    end

    def resolve!(link, from:)
      find(link.target) || raise(Florby::Error, unresolved_message(link, from))
    end

    def backlinks(page)
      @backlinks.fetch(page, [])
    end

    # { tag => [pages] }, tags sorted by name, pages newest first.
    def tags
      @tags ||= pages
                .flat_map { |page| page.tags.map { |tag| [tag, page] } }
                .group_by(&:first)
                .transform_values { |pairs| pairs.map(&:last) }
                .sort.to_h
    end

    private def build_backlinks
      backlinks = Hash.new { |hash, key| hash[key] = [] }
      errors = []

      @pages.each do |page|
        page.wiki_links.each do |link|
          destination = find(link.target)
          if destination.nil?
            errors << unresolved_message(link, page)
          elsif !page.exclude_from_collections? && !backlinks[destination].include?(page)
            backlinks[destination] << page
          end
        end
      end

      raise Florby::Error, errors.uniq.join("\n") unless errors.empty?

      backlinks.transform_values { |pages| pages.sort_by(&:created).reverse }
    end

    private def unresolved_message(link, from)
      message = "#{from.filename}.md: リンク先のページが見つかりません: [[#{link.target}]]"
      candidates = suggest(link.target)
      message += "（もしかして: #{candidates.join(', ')}）" unless candidates.empty?
      message
    end

    private def suggest(target)
      names = (@by_filename.keys + @by_title.keys).uniq
      names.select { |name| name.include?(target) || target.include?(name) }.first(5)
    end
  end
end
