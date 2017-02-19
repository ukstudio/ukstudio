---
title: UbuntuでMacOSのpbcopyっぽいことをする
date: 2010-11-17
---
普段ブログ書くとき、ローカルのvimで記事を書いてからそれをWordPressの記事作成画面にコピペしている。Macの時はpbcopyを使っていたけど、それと同じことをUbuntuでするにはxselというのを使えばよさそうだ。

<pre><code>$ sudo aptitude install xsel
$ cat hoge.txt | xsel -ib
</code></pre>