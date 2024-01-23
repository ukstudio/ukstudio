---
aliases:
- /2007/11/27/ruby_euclid
date: "2007-11-27"
title: ユークリッドの互除法をRubyで書いた
---
<pre lang="ruby">
def euclid(a, b)
  return nil if a < b
  return (a%b).zero? ? b : euclid(b, a%b)
end
</pre>

Rubyは三項演算子でもちゃんと値返すから3行目みたいな書き方が出来るからラクだ。</pre>