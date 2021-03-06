---
aliases:
- /2008/02/02/doukaku_lifegame
date: "2008-02-02"
title: Rubyでライフゲーム書いた
---
<a href="http://ja.doukaku.org/comment/5581/">どう書く?org #5581</a>

久々にどう書くorgに投稿してみた。1個1個セルの周り調べてくのも面白みがないなと思って、生きてるセルの周りをスコア付けしてくやり方でやってみた。

生きてるセルに+10し、生きてるセルの周りに+1していく。最終的にスコアが3(まわりに3つの生きてるセルがある)のセルは次世代で誕生するセルと判断。スコアが12もしくは13の(今の世代で生きてるセルで、まわりに2つもしくは3つの生きてるセルがある)のセルは次世代も維持するセルと判断。

テストはWikipediaの<a href="http://ja.wikipedia.org/wiki/ライフゲーム">ライフゲームのページ</a>から振動型(ブリンカー、ヒキガエルなど)を試しただけで、テストコードすら書いてない。だからもしかしたら間違ってるかもしれない。許せ。

<pre lang="ruby">
require 'curses'

module LifeGame
  class World
    def initialize(map)
      @map = map
    end

    def to_s
      str = ""
      @map.each do |line|
        line.each do |cell|
          str += "[#{cell}]"
        end
        str += "¥n"
      end

      str
    end

    def next
      ranking.each_with_index do |line, h|
        @map[h] = line.map {|cell| [3, 12, 13].include?(cell) ? '*' : ' ' }
      end
    end

    private
    def live_list
      list = []
      @map.each_with_index do |line, h|
        line.each_with_index {|cell, w| list < < [h,w] if cell == '*'}
      end

      list
    end

    def set_score(rank_map, live)
      (-1..1).each do |x|
        (-1..1).each do |y|
          score = x == y && y  == 0 ? 10 : 1
          rank_map[live[0]+x][live[1]+y] = rank_map[live[0]+x][live[1]+y] + score
        end
      end
    end

    def ranking
      rank_map = List.new
      @map.size.times { rank_map << List.new(@map[0].size, 0) }

      live_list.each do |live|
        set_score(rank_map.clone, live)
      end

      rank_map
    end
  end

  class List < Array
    alias original_get []
    alias original_set []=

      def [](index)
        original_get(index % size)
      end

    def []=(index, value)
      original_set(index % size, value)
    end
  end
end

if __FILE__ == $0
  begin
    game = LifeGame::World.new([
                                [' ', '*', ' ', ' ', ' ', ' ', '*', '*', '*', ' '],
                                [' ', ' ', ' ', ' ', '*', ' ', ' ', '*', '*', ' '],
                                [' ', ' ', ' ', '*', ' ', ' ', '*', ' ', '*', ' '],
                                ['*', ' ', '*', '*', ' ', ' ', '*', ' ', ' ', ' '],
                                [' ', '*', ' ', ' ', ' ', ' ', ' ', ' ', '*', ' '],
                                ['*', ' ', ' ', ' ', '*', ' ', '*', '*', ' ', '*'],
                                [' ', '*', ' ', ' ', ' ', ' ', '*', ' ', ' ', ' '],
                                [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', '*'],
                                ['*', ' ', ' ', ' ', ' ', ' ', '*', ' ', ' ', '*'],
                                [' ', ' ', ' ', ' ', '*', '*', ' ', ' ', '*', ' ']])

    window = Curses::Window.new(Curses.lines, Curses.cols, 0, 0)
    loop do
      window.setpos(0, 0)
      window.addstr(game.to_s)
      game.next
      window.getch
    end
  ensure
    window.close
  end
end
</pre></pre>