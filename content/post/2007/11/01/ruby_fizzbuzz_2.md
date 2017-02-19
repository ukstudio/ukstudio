---
title: RubyでFizzBuzz #2
date: 2007-11-01
---
<a href="http://uk-studio.net/2007/10/28/ruby_fizzbuzz/">RubyでFizzBuzz</a>の第二弾。大分スッキリしたと思うんだけどどでしょ。
<pre lang="ruby">
fizzbuzz = (1..100).map{|i|
if i%5 == 0 && i%3 == 0 : "FizzBuzz"
elsif i%5 == 0 : "Buzz"
elsif i%3 == 0 : "Fizz"
else i end
}</pre>
