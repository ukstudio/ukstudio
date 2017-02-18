---
title: JRubyとProcessing1.1でaction-coding!
---
せっかくProcessingも正式版になったことだし、少しaction-codingで遊んでみる。

まずはJRubyをインストール。面倒なのでバイナリで。環境はMac OSX 10.5.5。

<a href="http://dist.codehaus.org/jruby/">http://dist.codehaus.org/jruby/</a>からjruby-bin-1.1.5.tar.gz(バージョンは適宜読み替え)をダウンロード。現時点では1.1.5をインストールしておけば大丈夫だろう。解凍したら適当な位置に移動。

<pre lang="bash">
$ tar zxvf jruby-bin-1.1.5.tar.gz
$ sudo mv jruby-bin1.1.5 /usr/local/bin
</pre>

次にパスを通す。

<pre lang="zsh">
export JRUBY_HOME=/usr/local/bin/jruby-1.1.5
export PATH=/opt/local/ghc/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:$JRUBY_HOME/bin:$PATH
</pre>

PATHは環境によって違うと思うので適当に読み替え。sourceで読み込ませてjrubyコマンドが使えればOK。

<pre lang="bash">
$ source ~/.zshrc
$ jruby -v
jruby 1.1.5 (ruby 1.8.6 patchlevel 114) (2008-11-03 rev 7996) [i386-java]
</pre>

次にaction-codingをインストールする。基本的には<a href="http://code.google.com/p/action-coding/wiki/Tutorial">チュートリアル</a>に従っておけばいい。一点だけProcessing1.0からファイルの位置が変っているので以下の作業がいる。Processingのパスは普通にインストールしていれば同じだと思うけど、違う場合は適宜読み替えで。

<pre lang="bash">
$ pushd /Applications/Processing.app/Contents/Resources/Java/lib
$ cp ../core.jar .
$ popd
</pre>

最後に、config.yamlの修正。

<pre lang="ruby">
p5home: /Applications/Processing.app/Contents/Resources/Java
</pre>

これでサンプルのアプリケーションが実行できるはず。

<pre lang="bash">
 jruby aco.rb examples/basics/arrays/array_objects.rb
</pre><a href="http://ukstudio.jp/wp-content/uploads/2008/12/array_objects.jpg"><img src="http://ukstudio.jp/wp-content/uploads/2008/12/array_objects.jpg" alt="" title="array_objects" width="300" height="253" class="alignnone size-medium wp-image-270" /></a>

後はチュートリアルに従って、サンプルを修正してリアルタイムに変更が反映されるのを楽しみつついろいろ弄ればいいんじゃないかな。(setup内の編集だけは、ウィンドウにフォーカスをあててCmd+rもしくは、Ctrl+rでリロードが必要)

結構、変更がリアルタイムに反映されていくのは楽しい。スケッチっていう観点からしたらわざわざビルドするより、こっちの方が気楽でいいよね。

<iframe src="http://rcm-jp.amazon.co.jp/e/cm?t=2004-05-22&o=9&p=8&l=as1&asins=4873113784&md=1X69VDGQCMF7Z30FM082&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>

<iframe src="http://rcm-jp.amazon.co.jp/e/cm?t=2004-05-22&o=9&p=8&l=as1&asins=4861005582&md=1X69VDGQCMF7Z30FM082&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>
