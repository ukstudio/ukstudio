---
title: clojure+vimclojureのインストール
date: 2010-02-17
---
結構時間かかった。今日(正確には昨日)の夕方からずっといじってた。まとめるとそんな時間かかるようなものでもないんだけどね。clojureよりvimclojureで色々手間取った。ちなみに<a href='http://www.amazon.co.jp/gp/product/4274067890?linkCode=shr&camp=1207&creative=8411&tag=ukstudio0c-22' target='_blank'>プログラミング Clojure</a>のサンプルを動かすだけなら、サンプルコードの中にClojureの実行環境(REPL)が含まれてるので以下の設定をやる必要はなし。

<h2>clojureのインストール</h2>
ソースはgithubから落としてくる。masterでもいいんだけど、clojure-contribの方がmasterだとうまくbuildできなかったので1.1.0を使うことにした。

<pre>
$ git clone git://github.com/richhickey/clojure.git
$ cd clojure
$ git co -b 1.1.0 1.1.0
$ ant
</pre>

<h2>clojure-contribのインストール</h2>
プログラミング Clojureではcontribのライブラリを結構使うみたいなのでこちらもインストール。

<pre>
$ git clone git://github.com/rechhickey/clojure-contrib.git
$ cd clojure-contrib
$ git co -b 1.1.0 1.1.0
$ ant -Dclojure.jar=/github/clojure/clojure.jar
</pre>

<h2>REPLの起動</h2>
<pre>
$ java -cp /github/clojure/clojure.jar:/github/clojure/clojure-contrib.jar clojure.main
</pre>

これで無事REPLが起動すればOK。contribが使えるか気になる人は試しにuseなどしてみるといい。エラーがでずにnilが返ってくればOK。

<pre>
user=> (use 'clojure.contrib.str-utils)
nil
</pre>

<h2>起動コマンド</h2>
いつもjava -cpとかやるのは面倒なので起動コマンドを使う。

<pre>
$ mkdir ~/.clojure
$ ln -s /github/clojure/clojure.jar ~/.clojure
$ ln -s /github/clojure-contrib/clojure-contrib.jar ~/.clojure
$ export CLOJURE_EXT=~/.clojure
$ alias clj=/github/clojure-contrib/launchers/bash/clj-env-dir
</pre>

clojure-contribに起動用のスクリプトがあるのでそれを使う。CLOJURE_EXTにjarのあるディレクトリを指定する必要があるため、適当なディレクトリを作り、そこにjarを入れておく。あとは適当にaliasはるか、実行パスのあるところにファイルを置けばよい。

<h2>vimclojureのインストール</h2>
vimclojureもリポジトリから落としてくる。tip(masterとかtrunkと同義)だとBuildツールがantじゃなくてgradleになってるけど、うまくbuild出来なかったので2.1.2を使う。

<pre>
$ hg clone http://bitbucket.org/kotarak/vimclojure/
$ cd vimclojure
$ hg co -r v2.1.2
</pre>

/path/to/vimclojureにlocal.propertiesというファイルを作る。

<pre>
clojure.jar = /home/user/.clojure/clojure.jar
clojure-contrib = /home/user/.clojure/clojure-contrib.jar
nailgun-client = ng
vimdir = /home/user/.vim
</pre>

そしてbuild。

<pre>
$ cd /path/to/vimclojure
$ ant
$ ant install
</pre>

antでbuild、ant installでvimdirにpluginとかがインストールされる。vimrcを設定すれば、この時点でsyntax-highlightとかOmni補完とかは使えるようになっているはず。

<h2>VimでREPL</h2>
vimでREPLなどの機能を使うためにはng-serverを立ち上げる必要がある。CLASSPATHにjarが設定されていないといけないみたいなので設定する。

<pre>
$ export CLASSPATH=$CLOJURE_EXT/clojure.jar:$CLOJURE_EXT/clojure-contrib.jar:/path/to/vimclojure.jar
$ sh bin/ng-server
NGServer started on 127.0.0.1, port 2113.
</pre>

そして、vimrcの修正。syntax highlightの設定なども含む。

<pre>
" vimclojure
let clj_highlight_builtins = 1
let clj_highlight_contrib = 1
let clj_paren_rainbow = 1
let clj_want_gorilla = 1
let vimclojure#NailgunClient = "/path/to/vimclojure/ng"
</pre>

適当なclojureのファイルを開く。使い方は<code>:help clojure.vim</code>を見ればよい。とりあえず、REPLの起動は<code>&lt;LocalLeader&gt;sr</code>。
<img src="http://173.230.148.68/wp-content/uploads/2010/02/vimclojure.jpg" alt="vimclojure" title="vimclojure" width="618" height="465" class="alignnone size-full wp-image-561" />

これで一通り設定完了。結構時間がかかったけど、大体詰まるところはCLASSPATHまわりだったのでもしうまく動かなかったらまずそこを確認した方がいいかも。

良いclojure + vimライフを。

参考:
<a href='http://kotka.de/projects/clojure/vimclojure.html'>Kotka : Projects : Clojure : VimClojure</a>
<a href='http://en.wikibooks.org/wiki/Clojure_Programming/Getting_Started'>Clojure Programming/Getting Started - Wikibooks, collection of open-content textbooks</a>

<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=ukstudio0c-22&o=9&p=8&l=as1&m=amazon&f=ifr&md=1X69VDGQCMF7Z30FM082&asins=4274067890" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>