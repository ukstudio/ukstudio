---
title: CoffeeScript + QUnitでTDD環境作ったよ
date: 2011-04-19
aliases:
- /2011/04/19/coffeescript-qunit
---
Rails3.1からCoffeeScriptがデフォルトで入ってるとかなんとかで、とりあえずCoffeeScriptだけで少し触ってみた。とりあえずQUnit自体もCoffeeScriptで書けるようなTDD環境を作ってみた。

とりあえず、UbuntuにCoffeeScriptをインストールするわけだけどaptの方が古いしせっかくだから最新のを触るかと思ったのでgithubからCoffeeScriptとnode.jsのリポジトリをcloneしてインストール。

<pre>$ git clone git://github.com/joyent/node.git 
$ cd node
$ ./configure
$ make
$ sudo make install
$ node -v
v0.5.0-pre</code></pre>

<pre><code>$ git clone git://github.com/jashkenas/coffee-script.git
$ cd coffee-script
$ sudo bin/cake install
$ coffee -v
CoffeeScript version 1.1.0-pre</code></pre>

ディレクトリ構成はこんな感じ。coffeeにCoffeeScriptに入れて生成されたJavaScriptはsrcにいれるルール。test/index.htmlはQUnitの結果を見るため。test/qunitはずばりQUnitそのもの。

<pre>./coffee/hello.coffee
./src/hello.js
./test/index.html
./test/qunit/qunit.css
./test/qunit/qunit.js
./test/coffee/test-hello.coffee
./test/src/test-hello.js</pre>

CoffeeScriptは-wでファイルの変更を監視してコンパイルしなおすことができるので,以下の用に実行しておけばそれぞれ変更があったらコンパイルしてくれる。CoffeeScriptはデフォルトでfunction(){}();で囲って外部からアクセスできなくなるので,-bを付けてトップレベルにJavaScriptを生成するようにする。

<pre>$ coffee -w -b -o src/ -c coffee</pre>
<pre>$ coffee -w -b -o test/src -c test/coffee</pre>

これでテストコードもしくは本体のコードを修正すれば勝手にコンパイルするのでtest/index.htmlを見ればよい。後はもうちょい頑張ってブラウザを勝手にリロードするか,Rhinoとか使えばindex.htmlを用意しなくてもCUIでテスト結果をみれそう。

一式は以下のgistに置いた。(Qunitはライセンス見てないので外してある)
<a href="https://gist.github.com/925753">CoffeeScript+QUnit — Gist</a>