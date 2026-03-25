require 'commonmarker'
require 'yaml'
require 'fileutils'

module Florby
  class Page
    attr_reader :meta

    def initialize(file:)
      @file = file
      @meta = {}
      @markdown = File.read(@file)
      frontmatter, @body = @markdown.split("---\n", 3).last(2)
      @frontmatter = YAML.unsafe_load(frontmatter)
    end

    def filename
      @filename ||= File.basename(@file)
    end

    def title
      @frontmatter['title'] ||filename.gsub(/\.md$/, '')
    end

    def permalink
      link = @frontmatter['permalink'] || title
      link = "/#{link}" unless link =~ /^\//
      link = "#{link}/" unless link =~ /\/$/
      link
    end

    def created
      if @frontmatter['created'].is_a?(String)
        Date.parse(@frontmatter['created'])
      else
        @frontmatter['created'] || File::Stat.new(@file).birthtime.to_date
      end
    end

    def updated
      if @frontmatter['updated'].is_a?(String)
        Date.parse(@frontmatter['updated'])
      else
        @frontmatter['updated'] || File::Stat.new(@file).mtime.to_date
      end
    end

    def exclude_from_collections?
      @frontmatter['exclude_from_collections'] == 'true'
    end

    def layout
      @frontmatter['layout'] || 'default'
    end

    def aliases
      @frontmatter['aliases'] || []
    end

    def content
      @content ||= Commonmarker.to_html(@body, options: { extension: { tagfilter: false, autolink: true, table: true }, render: { unsafe: true } })
    end

    def content=(html)
      @content = html
    end
  end
end
