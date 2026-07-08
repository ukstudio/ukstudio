# frozen_string_literal: true

module Florby
  # A `[[target]]` or `[[target|label]]` link found in a Markdown body.
  class WikiLink
    PATTERN = /\[\[\s*([^\[\]|\n]+?)\s*(?:\|\s*([^\[\]|\n]+?)\s*)?\]\]/
    # Fenced code blocks and inline code spans keep their text verbatim,
    # so wiki links inside them must not be rewritten.
    CODE_PATTERN = /(^```.*?^```\s*$|`[^`\n]*`)/m

    attr_reader :target, :label

    def self.scan(markdown)
      links = []
      each_segment(markdown) do |segment, code|
        next if code

        segment.scan(PATTERN) { links << new(target: Regexp.last_match(1), label: Regexp.last_match(2)) }
      end
      links
    end

    # Rewrites every wiki link outside of code with the given block's result.
    def self.replace(markdown)
      result = +''
      each_segment(markdown) do |segment, code|
        result << if code
                    segment
                  else
                    segment.gsub(PATTERN) { yield new(target: Regexp.last_match(1), label: Regexp.last_match(2)) }
                  end
      end
      result
    end

    def self.each_segment(markdown)
      pos = 0
      markdown.scan(CODE_PATTERN) do
        match = Regexp.last_match
        yield markdown[pos...match.begin(0)], false
        yield match[0], true
        pos = match.end(0)
      end
      yield markdown[pos..] || '', false
    end
    private_class_method :each_segment

    def initialize(target:, label: nil)
      @target = target
      @label = label
    end

    def ==(other)
      other.is_a?(WikiLink) && other.target == target && other.label == label
    end
  end
end
