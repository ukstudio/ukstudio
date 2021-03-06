---
aliases:
- /2007/10/14/ipodtouch_hack_ruby
date: "2007-10-14"
title: iPod touchでRubyを動かす
---
<strong style="color: #ff0000">以下の作業は自己責任でお願いいたします。</strong>
<h2>Installer.appをインストールする</h2>
まずはRubyを入れるためにInstaller.appをiPod touchをインストールします。
基本的に以下のリンク通りに作業すれば問題ないはずです。

<a href="http://hostname.jp/wk/index.php?iPod%20Touch%20jailbreak%20for%20Windows">iPod Touch jailbreak for Windows</a>
<a href="http://hostname.jp/wk/index.php?iPod%20Touch%20jailbreak%20for%20OSX">iPod Touch jailbreak for OSX </a>
<h2>必要なアプリのインストール</h2>
Installer.appから以下のアプリをインストールします。
<ul>
	<li>System &gt; BSD Subsystem</li>
	<li>System &gt; MobileTerminal</li>
	<li>Sources &gt; Community Sources</li>
</ul>
BSD Subsystemを入れることでBSD由来のコマンドが使えるようになります。今回に限らずtouchをいじくり倒すのに必須のアプリかと。MobileTerminalはその名の通りTerminalです。Community SourcesはInstaller.appからインストールできるアプリが増えます。Rubyもこのなかに含まれています。
<h2>Rubyのインストール</h2>
Community SourcesをインストールすることでInstaller.appのアプリ一覧にRubyが増えているはずなので、そこからRubyをインストールします。
<h2>Rubyにパスを通す</h2>
<strike>Rubyにパスを通すために.zshenvをSSH経由で作成します。</strike>
<pre lang="bash"><strike>
% ssh -l root iPodtouchのIPアドレス
root@IPアドレス password:パスワードを入力

# vi /Applications/.zshenv

1: export PATH=/opt/iphone/bin:$PATH</strike></pre>
<strike>次にiPod touchのMobileTerminalから今つくった.zshenvを適用させます。</strike>
<pre lang="bash"><strike>
# # source /Applications/.zshenv
# # ruby -v
ruby 1.8.6 (2007-03-13 patchlevel 0)
[arm-darwin]</strike></pre>
どうやら.zshenvだとMobileTerminalを閉じるたびに設定がリセットされる模様。毎回Terminalを起動させる度にsourceするのもアレなのでlnコマンドでシンボリックリンクを作ることで対応します。

シンボリックリンクはSSH経由でrootで作成します。
<pre lang="bash">
% ssh -l root iPodtouchのIPアドレス
root@IPアドレス password:パスワードを入力

# ln -s /opt/iphone/bin/ruby /bin/ruby</pre>
これでMobileTerminalを閉じたあとでもRubyへのパスが通っているはずです。ただこの方法だとPerlやPHP、Pythonをインストールしたときもシンボリックリンクを用意しなければいけないですし、irbのシンボリックリンクも用意する必要があります。(irbはなんかエラーでてつかえないけど)

<img src="http://farm3.static.flickr.com/2133/1568034636_00c9cd91c8.jpg?v=0" />

できれば、PATHの設定をしてやった方が色々手間がないはずなので、やり方わかる人いたら教えていただけるとありがたいです。
<h2>オマケ</h2>
せっかくSSHを使えるようにしてあるんだからsshsでマウントすると便利ですよ。

<img src="http://farm3.static.flickr.com/2130/1567200415_f186903c3b.jpg?v=0" />
<h2>追記:irbがなくてもボクたちにはeval.rbがあるじゃないか!</h2>
irbは動かないけど、eval.rbならもしかして・・・？

ってことで試してみましたよ。SSHでeval.rbをtouchに送って実行!

<img src="http://farm3.static.flickr.com/2355/1573467889_1f56f2e5ba.jpg?v=0" />

<strong>できた!!</strong>

eval.rbはサンプルとしてRubyにくっついてると思うから探せばあると思う。もしわからなければソースを<a href="http://www.ruby-lang.org/ja/downloads/">ダウンロード</a>して、解凍すると/sample/eval.rbがあるからそれを使えばいいと思います。
<h2>追記</h2>

<h2>追記 2007/10/26</h2>
<a href="http://d.hatena.ne.jp/faultier/20071025/1193293222">[iPod touch][プログラミング]iPod touchでRubyを使うのはちょっと厳しいかも</a>
irbが動かない件をfaultierさんが検証していた様です。irbだけじゃなくて標準ライブラリもダメだったのね・・・