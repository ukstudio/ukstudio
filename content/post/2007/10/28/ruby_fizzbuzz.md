---
title: RubyでFizzBuzz
date: 2007-10-28
aliases:
- /2007/10/28/ruby_fizzbuzz
---
今更ながらにFizzBuzz問題をRubyで問いてみる。前は確かPHPだけで問いて、Rubyで問いてなかったと思うから。

<strong>ループ内で出力</strong>
<pre lang="ruby">
100.times(){|i|
  i += 1
  if i%5 == 0 && i%3 == 0 then
    puts "FizzBuzz"
  elsif i%5 == 0
    puts "Buzz"
  elsif i%3 == 0
    puts "Fizz"
  else
    puts i
  end
}</pre>
<strong>配列を作ってそれを出力</strong>
<pre lang="ruby">
fizzbuzz = Array.new(100){|i|
  i += 1
  if i%5 == 0 && i%3 == 0 then
    "FizzBuzz"
  elsif i%5 == 0
    "Buzz"
  elsif i%3 == 0
    "Fizz"
  else
    i
  end
}
puts fizzbuzz</pre>
まぁ、普通ですな。後々データを再利用する可能性を考えると、ループ内で出力するより配列を作った方がいいかなとは思う。

if文のところはもうちょっとなんとかなる気もするけど、コードゴルフしてるわけでもないし、これでいいかな。再帰で書けって言われたら多分できないけど。

精進ですなー。