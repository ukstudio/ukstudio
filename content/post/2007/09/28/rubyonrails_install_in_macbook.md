---
title: MacBookにRubyOnRailsをインストールする
---
Railsを試すためにMacBookにRubyOnRailsをインストールしてみました。MacPortsは既にインストールされてるものとして話を進めるので、インストールしていない人はGoogleで調べるなりしてインストールしてくださいな。と言ってもRubyGemsのインストールでしか今回は使いませんけど。
<h2>まずはRubyGemsをインストール</h2>
MacPortsを利用してRubyGemsを入れます。rb-rubygemsという名前で登録されているはずです。
<pre>% sudo port install rb-rubygems</pre>
<a href="http://www.flickr.com/photo_zoom.gne?id=1447826801&amp;size=o"><img src="http://farm2.static.flickr.com/1008/1447826801_bf64321738.jpg?v=0" alt="install gem" /></a>
<h3>というかRubyGemsってなに?</h3>
いわゆるパッケージマネージャーってやつです。Perlで言うところのCPANみたいなものです。Rubyはまだ標準のパッケージマネージャーはありませんが、Railsがインストールできるということもあってか大抵はRubyGemsが使われるようです。
<ul>
	<li><a href="http://jp.rubyist.net/magazine/?0006-PackageManagement">Rubyist Magazine - シリーズ パッケージマネジメント 【第 1 回】 RubyGems (1)</a></li>
	<li><a href="http://d.hatena.ne.jp/secondlife/20061106/1162785661">川o・-・）＜2nd life - RubyGems パッケージの作り方 - rubyforge 登録まで</a></li>
	<li><a href="http://www.rubygems.org/">RubyGems Manuals</a></li>
</ul>
<h2>gemからRailsをインストール</h2>
<pre>% sudo gem install rails</pre>
<a href="http://www.flickr.com/photo_zoom.gne?id=1447826981&amp;size=o"><img src="http://farm2.static.flickr.com/1341/1447826981_c3eb32b601.jpg?v=0" alt="install rails" /></a>

gemをインストールしてしまえば、コマンド一発でRailsがインストール出来てしまいます。簡単ですね。
<h2>プロジェクトを作ってみる</h2>
<pre>% rails hello</pre>
<a href="http://www.flickr.com/photo_zoom.gne?id=1447827317&amp;size=o"><img src="http://farm2.static.flickr.com/1245/1447827317_f6bc5901ef.jpg?v=0" alt="create project" /></a>

gemでRailsをインストールしたら、プロジェクトを作ってみましょう。helloというディレクトリが出来て、その中にappディレクトリやRakefileとかが作られていれば問題ありません。ちなみにhelloというのはプロジェクト名です。
<h3>おまけ</h3>
キャプチャのMelchiorっていうのはエヴァネタです。マギシステムの。痛い子ですみません。
