---
title: たのしいRuby 第10章 練習問題
date: 2007-12-20
aliases:
- /2007/12/20/tanoshi_ruby_sec10_practice
---
たのしいRuby 第10章 数値(Numeric)クラスの練習問題をやってみた。

(1)と(2)は華氏を摂氏、もしくは逆の摂氏を華氏に変換するプログラムを書けと言う問題。小数点以下を求める為に引数をFloat()で囲む。そんなに難しい問題じゃないので、テストはかなり適当。

<pre lang="ruby">
def cels2fahr(cels)
  Float(cels) * 9 / 5 + 32
end
</pre>
<pre lang="ruby">
require 'test/unit'
require 'cels2fahr'

class TestCels2Fahr < Test::Unit::TestCase
  def test_cels2fahr
    assert_equal(50, cels2fahr(10))
    assert_equal(77, cels2fahr(25))
  end
end
</pre>
</pre><pre lang="ruby">
def fahr2cels(fahr)
  (Float(fahr) - 32) * 5 / 9
end
</pre>
<pre lang="ruby">
require 'test/unit'
require 'fahr2cels'

class TestFahr2Cels < Test::Unit::TestCase
  def test_fahr2cels
    assert_equal(10, fahr2cels(50))
    assert_equal(25, fahr2cels(77))
  end
end
</pre>

(3)は乱数の問題。1から6までの数字を出力するメソッドdiceを実装する。乱数のテストって何書いたらいいんだろう。今回はテストは用意しなかったけど、1から6までの数値かどうかのテストぐらいは用意するべきだったのかな。

</pre><pre lang="ruby">
def dice
  rand(6) + 1
end
</pre>

(4)は引数が素数かどうかを調べるメソッドの実装。2より小さい数(負数、0、1)は即falseを返す。それ以上の数は引数の平方根までの数で割り切れるか調べ、途中で割り切れたら素数ではないので、falseを返す。ループを抜けたら素数なのでtrueを返す。

<pre lang="ruby">
def prime?(num)
  return false if num < 2
  (2..Math.sqrt(num)).each do |i|
    return false if (num % i).zero?
  end

  true
end
</pre>
</pre><pre lang="ruby">
require 'test/unit'
require 'prime'

class TestPrime < Test::Unit::TestCase
  def test_prime
    assert(!prime?(0))
    assert(!prime?(1))
    assert(prime?(2))
    assert(prime?(3))
    assert(!prime?(4))
    assert(prime?(5))
    assert(prime?(13))
    assert(prime?(17))
    assert(prime?(113))
  end
end
</pre>

書いたコードはCodeReposにCommitしてみた(<a href="http://coderepos.org/share/browser/dan/ruby/tanoshi_ruby/sec10_numeric">/dan/ruby/tanoshi_ruby/sec10_numeric/</a>)。突っ込み、添削大歓迎です。これぐらいの規模のプログラムだと添削とかしづらいかもですが。

<table class="g-tools_table"><tr><td colspan="2"><span class="g-tools_title"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4797336617/ukstudio0c-22/" target="_top">たのしいRuby 第2版 Rubyではじめる気軽なプログラミング</a></span></td></tr><tr><td valign="top"><span class="g-tools_img"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4797336617/ukstudio0c-22/" target="_top"><img src="http://ecx.images-amazon.com/images/I/11FDBHKSKWL.jpg"  alt="たのしいRuby 第2版 Rubyではじめる気軽なプログラミング" /></a></span></td><td valign="top"><span class="g-tools_body">高橋 征義 後藤 裕蔵 <br /><br /><strong>おすすめ平均</strong> <img src="http://g-images.amazon.com/images/G/01/detail/stars-3-5.gif" /><br /><img src="http://g-images.amazon.com/images/G/01/detail/stars-4-0.gif" alt="stars" />プログラミング初心者にとっては少し難易度が高いかも<br /><img src="http://g-images.amazon.com/images/G/01/detail/stars-4-0.gif" alt="stars" />変数のスコープと寿命について詳しく書いて欲しかった<br /><img src="http://g-images.amazon.com/images/G/01/detail/stars-4-0.gif" alt="stars" />練習問題の内容にやや難あり<br /><img src="http://g-images.amazon.com/images/G/01/detail/stars-4-0.gif" alt="stars" />Rubyをこれから覚える方は必読かも<br /><img src="http://g-images.amazon.com/images/G/01/detail/stars-1-0.gif" alt="stars" />読みやすいだけ<br /><br /><a href="http://www.amazon.co.jp/exec/obidos/ASIN/4797336617/ukstudio0c-22/" target="_top">Amazonで詳しく見る</a></span><span class="g-tools_by"> by <a href="http://www.goodpic.com/mt/aws/index.html" >G-Tools</a></span></td></tr></table></pre>