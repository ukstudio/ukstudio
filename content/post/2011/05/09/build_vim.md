---
title: Vimをソースからビルド
---
aptで入れたvimのrubyインターフェースのバージョンが1.8.6なのが気にいらなくてvimをソースからビルドした。

<pre><code>$ hg clone https://vim.googlecode.com/hg/ vim
$ hg update vim73

$ cd vim
$ ./configure --enable-multibyte --prefix=$HOME/local --enable-rubyinterp</code></pre>

これでOK。aptで入れたvimも一応残しておきたかったのでprefixで$HOME以下にビルドするようにした。Rubyインターフェースはrvmで入れた1.9.2を見るようになっていたのでとりあえずよしとする。何でrvmの奴を見にいったのかはよくわからない。
