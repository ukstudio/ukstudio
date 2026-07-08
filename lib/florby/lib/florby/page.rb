# frozen_string_literal: true

require 'date'
require 'erb'

module Florby
  # A single Markdown source file. Pages are read once and never mutated;
  # HTML rendering and backlink resolution live in MarkdownRenderer / Site.
  class Page
    DESCRIPTION_LENGTH = 120

    attr_reader :path, :body, :frontmatter

    def initialize(path:)
      @path = path
      @frontmatter, @body = FrontMatter.parse(File.read(path), filename: File.basename(path))
    end

    def filename
      @filename ||= File.basename(@path, '.md')
    end

    def title
      frontmatter['title'] || filename
    end

    def permalink
      @permalink ||= begin
        link = frontmatter['permalink'] || title
        link = "/#{link}" unless link.start_with?('/')
        link = "#{link}/" unless link.end_with?('/')
        link
      end
    end

    # Percent-encoded permalink for use in absolute URLs (sitemap, feed).
    def encoded_permalink
      permalink.split('/', -1).map { |segment| ERB::Util.url_encode(segment) }.join('/')
    end

    def created
      @created ||= date_from('created') { File::Stat.new(@path).birthtime.to_date }
    end

    def updated
      @updated ||= date_from('updated') { File::Stat.new(@path).mtime.to_date }
    end

    def tags
      Array(frontmatter['tags']).map(&:to_s)
    end

    def draft?
      FrontMatter.truthy?(frontmatter['draft'])
    end

    def exclude_from_collections?
      FrontMatter.truthy?(frontmatter['exclude_from_collections'])
    end

    def aliases
      Array(frontmatter['aliases'])
    end

    def layout
      frontmatter['layout'] || 'default'
    end

    def description
      frontmatter['description'] || excerpt
    end

    def wiki_links
      @wiki_links ||= WikiLink.scan(body)
    end

    private def date_from(key)
      value = frontmatter[key]
      case value
      when Date then value
      when String then Date.parse(value)
      else yield
      end
    rescue ArgumentError
      raise Florby::Error, "#{filename}.md: invalid date in '#{key}': #{value.inspect}"
    end

    private def excerpt
      text = body.dup
      text.gsub!(/^```.*?^```\s*$/m, ' ')                    # fenced code blocks
      text = WikiLink.replace(text) { |link| link.label || link.target }
      text.gsub!(/!\[[^\]]*\]\([^)]*\)/, ' ')                # images
      text.gsub!(/\[([^\]]*)\]\([^)]*\)/, '\1')              # markdown links -> text
      text.gsub!(/^#+\s*/, '')                               # heading markers
      text.gsub!(/^\s*(?:[-*+]|\d+\.|>)\s+/, '')             # list / quote markers
      text.gsub!(/[`*_~]/, '')                               # emphasis / code marks
      text.gsub!(/<[^>]+>/, ' ')                             # inline HTML tags
      text = text.gsub(/\s+/, ' ').strip
      text[0, DESCRIPTION_LENGTH]
    end
  end
end
