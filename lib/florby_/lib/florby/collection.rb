module Florby
  class Collection
    def initialize(source_dir:)
      files = Dir.glob(File.join(Dir.pwd, source_dir, '*.md'))
      @hash = files.map { |file| [File.basename(file).gsub(/\.md$/, ''), Page.new(file: file)] }.to_h
      @title_index = {}
      @hash.each do |filename, page|
        @title_index[page.title] = page if page.title
      end
    end

    def titles
      @hash.keys
    end

    def all_pages
      @hash.values.sort_by(&:created).reverse
    end

    def pages
      all_pages.reject(&:exclude_from_collections?)
    end

    def find(title)
      # まずファイル名で検索
      page = @hash[title]
      # 見つからなければタイトルで検索
      page ||= @title_index[title]
      page
    end
  end
end
