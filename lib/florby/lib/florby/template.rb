# frozen_string_literal: true

require 'cgi'
require 'erb'

module Florby
  # Renders ERB layouts. Layouts see `page`, `site`, `config` and
  # `content` (the current page's HTML; `content(other_page)` renders
  # another page's body, e.g. for index previews).
  class Template
    DEFAULT_LAYOUT = <<~ERB
      <!doctype html>
      <html>
        <head>
          <meta charset="utf-8">
          <title><%= h page.title %></title>
        </head>
        <body><%= content %></body>
      </html>
    ERB

    def initialize(root:, site:, renderer:)
      @layouts_dir = File.join(root, site.config.layouts_dir)
      @site = site
      @renderer = renderer
    end

    def layout_exist?(name)
      File.exist?(layout_path(name))
    end

    def render_page(page)
      render(page.layout, page: page)
    end

    def render(layout_name, page: nil, assigns: {})
      path = layout_path(layout_name)
      source = layout_exist?(layout_name) ? File.read(path) : DEFAULT_LAYOUT
      erb = ERB.new(source, trim_mode: '-')
      erb.filename = path
      context = Context.new(site: @site, renderer: @renderer, page: page, assigns: assigns)
      erb.result(context.binding_for_erb)
    end

    private def layout_path(name)
      File.join(@layouts_dir, "#{name}.erb")
    end

    class Context
      attr_reader :site, :page

      def initialize(site:, renderer:, page:, assigns:)
        @site = site
        @renderer = renderer
        @page = page
        assigns.each do |name, value|
          define_singleton_method(name) { value }
        end
      end

      def config
        site.config
      end

      def content(target = page)
        raise Florby::Error, "layout: content を描画する page がありません" unless target

        @renderer.render(target)
      end

      def h(text)
        CGI.escapeHTML(text.to_s)
      end

      def binding_for_erb
        binding
      end
    end
  end
end
