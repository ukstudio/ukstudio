---
aliases:
- /2007/12/01/ruby_rpn_ujihisa_sixeight
date: "2007-12-01"
title: 後置記法のコードを添削してもらっちゃいました
---
<a href="http://ujihisa.nowa.jp/entry/60c2b3fcf9">rubyneko - Re: UK STUDIO 後置記法での計算</a>
<a href="http://d.hatena.ne.jp/Sixeight/20071130/1196438912">後置記法での計算の添削に便乗してみた - チナミニ</a>

ujihisaさんとSixeightさんには感謝です。せっかくなんで添削してもらったコードを自分なりにちゃんと理解しときたいと思います。

<h2>ujihisaさんのコード</h2>

<pre lang="ruby">
class String
  def rpn
    expr = self.split(" ")
    stack = []
    operators = %w[+ - * /]

    expr.each do |i|
      if operators.include? i
        stack = [calc(i, stack)]
      else
        stack < < i.to_i
      end
    end

    stack[0]
  end

  private
  def calc(operator, stack)
    stack.inject {|result, i|
      result.__send__(operator, i)
    }
  end
end
</pre>
<h3>stackに文字列でなく数値を格納していく</h3>
確かに所々でto_i使い過ぎだ。これだけで全然スッキリするなぁ・・・
<h3>スコープは狭く</h3>
ですよねぇ。なんでクラス変数にしたんだろう、おれは。猛省。
<h3>Array.newを[]に</h3>
個人的にはなんかArray.newがしっくりくるんですよね。「Arrayをnewする」みたいな感じで。[]だとあまりそんな感じがしない。

まぁ慣れの問題な気もするので、[]も使っていこうと思います。

<h3>returnは省略</h3>
これはなんか個人的には解決してない問題でして。値を返すことを強調したいときはreturnをつけようとか思っていたんだけど。

ただ、Rubyは必ず値が返ってくることを考えると、やっぱり基本的に省略なのかなぁ。

ちなみにTwitterでぼそっとぼやいたらこんな反応が。
<ul>
<li><a href="http://twitter.com/yuki_neko_nyan/statuses/456843452">http://twitter.com/yuki_neko_nyan/statuses/456843452</a></li>
<li><a href="http://twitter.com/natsutan/statuses/456852982">http://twitter.com/natsutan/statuses/456852982</a></li>
</ul>

<h3>Array(...)を[...]に</h3>
[]で囲むのでもいいのか。知らなかった。

<h3>calcがArrayを返すより、stackに入れるときにArrayにするべし</h3>
説明がなんかHaskellerっぽいですな。

calc::char->[int]->[int]ってどう言う意味だっけ。確か、第1引数の型->第2引数の型->返り値の型だったかな。[int]はintの配列ってことかな・・・

確かにcalcの処理内容を考えると[int]よりintの方がわかりやすいな。ふむ。

<h3> eachのブロックを{}からdo endに</h3>
そもそも、自分のコーディング規約を守ってない件。複数行のブロックはdo...end使うって決めたのに!

<q>副作用を目的としているケースでは、こちらのが直感的</q>とあるけど、何故だかちょっとわからない。直感的ってのもまた人それぞれな部分あるしなぁ。

<h3>if i == "+" || i == "-" || i == "*" || i == "/"をArray#include?を使ってシンプルにまとめた</h3>
このifは自分でも汚いなとは思ってた。各演算子を配列にまとめてinclude?で判断か。ブロック引数iの値が配列に含まれていればtrueを返すから、この場合だと"+", "-", "*", "/"のどれかだとtrueになると。

<h3>calcについて</h3>
</pre><pre lang="ruby">
result.__send__(operator, i)
</pre>
って記述を見たとき、「あれ、resultに代入しなくていいの?」とか思ったんだけど、ちゃんと調べてみると途中のブロックの返り値は次の呼び出しの時にresultに渡されるんだとさ。ちゃんと調べろよって話ですね。


ujihisaさんにはさらに短かくしたコードも書いてもらってるんだけどまだちょっと追えてない。これはまた後日こっそり調べとく。

<h2>Sixeightさんのコード</h2>
関係ないけどSixeightさんってtyoroの後輩だっけ?

<pre lang="ruby">
class String
  # Reverse Polish Notation
  # '4 5 +'.rpn => 4 + 5 = 9
  def rpn
    stack = []
    opr = %q[ + - * / ]

    split(' ').each do |i|
      if opr.include? i
        stack[-1] = stack[-2].__send__(i, stack.pop)
      else
        stack < < i.to_i
      end
    end
    stack.first
  end
end
</pre>
一応、最終的なコードを見せてもらう。(もちろん、その前のコードも読みましたよ)全体的にSixeightさんもujihisaさんのコードを見たあとのせいか、基本的には上で書いたことと同じ感じかなー。

ただ、演算の処理をメソッドで別にせず1行で済ませてますな。あとオレの場合はめんどくさくて、stackを全部上書きしちゃってるけど、Sixeightさんはpopで取り出してちゃんと処理してる。

個人的にはstack[-1]とstack[-2]が気になるかな。インデックスの-が個人的に好きじゃないようで。まぁあんなcalcメソッド書いといて何言ってるんだって感じですよね。すみません。

逆ポーランド記法の仕様についてはあまりちゃんと調べてなかったり。なんかSchemeの前置記法と似た感覚で複数の値も計算するもんだと思ってたけど違うのかな。

<h3>追記</h3>
はてブにSixeightさんのコメントが!
<blockquote>
インデックスの-は僕も否定派なんですが、スタックから取り出す順番をひっくり返すのが思い浮かばなくて＞＜精進しなきゃ
</blockquote>
やっぱ-は否定的なのかー。お互いがんばりまっしょい。

<h2>書き直したコード</h2>
</pre><pre lang="ruby">
class String
  def rpn
    expr = self.split(" ")
    stack = []
    operators = %w[+ - * /]

    expr.each do |i|
      if operators.include? i
        stack = [stack.inject{|result, item| result.__send__(i, item)}]
      else
        stack < < i.to_i
      end
    end

    stack.first
  end
end
</pre>
ujihisaさんのコードをほとんど反映させた感じ。例外処理とか考えてないよ。あとスタックにある数値も全部計算する仕様のまま。</pre>