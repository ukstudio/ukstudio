require 'erb'

module Florby
  class Renderer
    DEFAULT_TEMPLATE = <<~ERB
      <html>
        <meta charset="utf-8">
        <body>
          <%= page.content %>
        </body>
      </html>
    ERB
    attr_reader :page, :collection

    def initialize(page:, collection:)
      @page = page
      @collection = collection

      if File.exist?(File.join(Dir.pwd, 'layouts', "#{page.layout}.erb"))
        @layout = File.read(File.join(Dir.pwd, 'layouts', "#{page.layout}.erb"))
      end
    end

    def render
      erb = ERB.new(@layout || DEFAULT_TEMPLATE)
      erb.result(binding)
    end
  end
end
