---
title: Ruby1.8.7とRuby1.9.2を共存させる
date: 2009-08-25
aliases:
- /2009/08/25/multiruby
---
<strong>現在は、以下の方法より<a href="http://rvm.beginrescueend.com/">rvm</a>を使うことをオススメします。 10/05/28 追記</strong>

ローカルに開発環境としてRuby1.8.7とRuby1.9.2を共存させる方法。

<h2>Rubyのインストール</h2>
まずはRubyの処理系をインストール。<a href="http://www.ruby-lang.org/ja/">ruby-lang.org</a>から適当に落とす。今回はruby 1.8.7-p174とruby 1.9.2-preview1を使用。

まず、Ruby1.9.2から。

<pre><code>$ ./configure --prefix=/Users/uk/local --program-suffix=-1.9.2
$ make
$ make install
</code></pre>

--prefixでインストール箇所を指定。自分の$HOME以下のどこかにいれるのが最近のマイブーム。この後でてくるgemも$HOME以下。Rubyはともかくgemは$HOME以下を推奨する。ある程度有名なライブラリならいいが、適当な野良ライブラリをインストールするにはこちらの方が安心な為。

--program-suffixを指定するとインストールしたバイナリの後ろに指定した文字列を付加できる。この例だと「ruby-1.9.2」となる。他の処理系と分けるためこの指定は必須。

次に同じ要領で1.8.7もインストール。やることは同じ。

<pre><code>$ ./configure --prefix/Users/uk/local --program-suffix=-1.8.7
$ make
$ make install
</code></pre>

これでそれぞれのバイナリが/Users/uk/local/binに入っている状態となる。

<h2>RubyGems</h2>
次にgemの設定。Ruby1.9からはgemが標準で入っている為、インストールは必要ない。ただバージョンが1.3.4なのでアップデートしておくといいだろう。

1.8.7は別途gemをインストールする。<a href="http://rubyforge.org/projects/rubygems/">RubyForgeにプロジェクトがある</a>のでそこからダウンロードしてくる。

<pre><code>$ ruby-1.8.7 setup.rb
</code></pre>

それぞれのgemのenvを見ておくと、インストールしたライブラリがどこに保存されるかわかる。

<pre><code>$ gem-1.9.2 env
$ gem-1.8.7 env
</code></pre>

それぞれ、GEM PATHSの先頭が/Users/uk/local/lib/ruby/gems/1.8と/Users/uk/local/lib/ruby/gems/1.9.1(何で1.9.2じゃないのかはわからん)になっているはずだ。今後、gemを使ってライブラリをインストールするときはsudoは必要ない。

<h2>シンボリックリンク</h2>
この時点でRuby1.9.2とRuby1.8.7がそれぞれ使える状態になってはいるが、いちいちバージョンを指定するのも面倒なので、シンボリックリンクで対応する。riとかも必要に応じて作る。

<pre><code>$ ln -s ~/local/bin/ruby-1.8.7 ~/local/bin/ruby
$ ln -s ~/local/bin/irb-1.8.7 ~/local/bin/irb
$ ln -s ~/local/bin/gem-1.8.7 ~/local/bin/gem
</code></pre>

Ruby1.9.2を使いたいときは、一度シンボリックリンクを消し、再度作りなおす。

とは言え、その作業を手動で行うのは手間なのでスクリプトで対応するのがオススメ。5分ぐらいで書いたスクリプトをgistに貼っておいた。実行権限を与えて、引数にバージョンを与えると使えるはずだ。PATHとCMDは適当に書き換えること。そのうちもうちょっとマシなものに書き直すかも。

<script src="http://gist.github.com/174406.js"></script>

<h2>まとめ</h2>
とりあえず、こんな感じでRuby1.9.2とRuby1.8.7を共存させてみた。いくつか、気になる点があって例えばgemでRailsをインストールするとシェバングが「#!/Users/uk/local/bin/ruby-1.9.2」となっており、シンボリックリンクを用意しただけではダメな時もある。その時はとりあえず諦めて以下の様に実行している。

<pre><code>$ ruby -S Rails hoge
</code></pre>

実際にこの環境で開発するのはこれからなので、もしかしたらそのうち色々な問題もでてくる可能性はあるが、とりあえずこの環境でやってみようと思う。