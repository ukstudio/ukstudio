---
title: コードブロックとyield文
date: 2007-09-05
---
メソッド内でyield文を使うことでメソッドからコードブロックを呼び出すことができます。yield文が呼び出されるたびに、ブロックに処理が移り、処理が終わるとyieldの直後の処理に移ります。
<pre lang="ruby">def exec_block
  yield
  puts "hoge"
end

exec_block{ puts "Hello,World"}

-----
Hello,Wold
hoge</pre>
ブロックで引数を使いたいときはこんな感じ。yield文に値を与えることでブロックからその値を変数として呼ぶことができます。
<pre lang="ruby">
def exec_block
  yield("foo", 3)
end

exec_block {|str,num| puts str * num}

-----
foofoofoo</pre>
ちなみに当たり前ですが、ブロックはブレース{}でなくても、do endでも問題ありません。１行のブロックの場合にはブレース、複数行の場合にdo endが一般的なようです。

コードブロックを使うとイテレータが実装できますけど、大抵は組み込みのもので事足りるのであまり自分でイテレータを作るっていうのは少ないのかもしれないですね。ま、Rubyの経験が少ないのでよくわかりませんが。