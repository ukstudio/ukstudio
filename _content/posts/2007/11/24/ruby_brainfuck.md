---
aliases:
- /2007/11/24/ruby_brainfuck
date: "2007-11-24"
title: RubyでBrainFuck処理系を書いてみた
---
<pre lang="ruby">
class BrainFuck
  def convert(code)
    @code = code
    @memory = Array.new
    @code_ptr = @mem_ptr = 0
    @output = ""

    while @code.size > @code_ptr
      @memory[@mem_ptr] ||= 0

      case @code[@code_ptr]
      when ?>
        @mem_ptr += 1
      when ?< raise ArgumentError if @mem_ptr.zero?
        @mem_ptr -= 1
      when ?+
        @memory[@mem_ptr] += 1
      when ?-
        @memory[@mem_ptr] -= 1
      when ?.
        @output += @memory[@mem_ptr].chr
      when ?,
        @memory[@mem_ptr] = $stdin.getc
      when ?[
        if @memory[@mem_ptr].zero?
          nest = 1
          until nest.zero?
            @code_ptr += 1
            case @code[@code_ptr]
            when ?[
              nest += 1
            when ?]
              nest -= 1
            end
          end
        end
      when ?]
        if @memory[@mem_ptr].nonzero?
          nest = 1
          until nest.zero?
            @code_ptr -= 1
            case @code[@code_ptr]
            when ?[
              nest -= 1
            when ?]
              nest += 1
            end
          end
        end
      end
      @code_ptr += 1
    end

    return @output
  end
end
</pre>
こんな感じで使う。
</pre><pre lang="ruby">
hello = "++++++++[>+++++++++< -]>." # H
hello += "< +++++[>++++++< -]>-."         # e
hello += "< ++[>+++< -]>+."                      # l
hello += "."                                                 # l
hello += "+++."                                          # o

bf = BrainFuck.new
p bf.convert(hello) #=> Hello
</pre>

[と]の処理内容が似てるのが気になる。似てるっていうかほとんど一緒なんだよね。なんかこううまく抽象化することはできないものか。あと無意味にインスタンス変数使い過ぎだな。