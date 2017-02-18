---
title: Macのログインシェルをzshに変更する
---
<a href="http://uk-studio.net/2007/07/08/start-macbook/">以前</a>に一度設定はしていたのですがちょっとおかしなところ(screenがうまく起動しない、日本語が入力できないとか)がいくつかあったので再設定しました。
<h2>zsh-develをMacPortsでインストールする</h2>
どうやら最初からインストールされているzshではバージョンの4.24のため日本語が入力できないみたいなのでMacPortsであらたに4.3以上のものをインストールしなおします。
<pre>
$sudu port install zsh-devel
Enter password:</pre>
インストールが終わると、/opt/local/binにzsh-4.3.4があるはずです。
<h2>ログインシェルの変更</h2>
ユーティリティのNetInfoマネージャもしくは、Terminalからchshを実行してログインシェルを変更します。今回はchshを使用して変更します。ちなみにTerminalの環境設定でシェルを指定している場合は「/usr/bin/loginを使ってデフォルトのログインシェルを実行する」に直しといて下さい。

追記:
MacPortsでインストールしたzshをそのまま登録しても不正なシェルだかなんだか言われてエラーがでるのでそれの対応も必要。/etc/shellsに今回使用するzshのパスを追記します。書くの忘れてたよ・・・

<pre>
$vi /etc/shells

<span style="color:#f00">/opt/local/bin/zsh-4.3.4</span>
</pre>

chshを実行すると編集画面にうつるので、Shellの項目に先程インストールしたzshのパスを指定します。
<pre>
$chsh

6: ##
7: Shell: <span style="color: #ff0000">/opt/local/bin/zsh-4.3.4</span>
8: Full Name: 名前</pre>
<h2>日本語設定</h2>
Terminal、zshの日本語設定を行います。
<h3>Terminalの日本語設定</h3>
<ol>
	<li>Cmd + i でターミナルインスペクタを開く</li>
	<li>エミュレーション-&gt;「非ASCII文字をエスケープする」のチェックをはずす</li>
	<li>ディスプレイ-&gt;日本語や中国語などにワイドグリフを使用する」と「ワイドグリフは2桁とカウントする」のチェックをオンにする</li>
	<li>文字 エンコーディングをUnicode(UTF-8)に変更する</li>
</ol>
<h3>zshの日本語設定</h3>
ホームディレクトリの.inputrcに以下の文を追記。ファイルが無い場合新規に作成する
<pre>
同じくホームディレクトリの.zshenvに以下の文を追記。lsで日本語をきちんと表示させるためにaliasで"ls -v"を指定しています。
<pre>
alias ls="ls -v"

export LANG=ja_JP.UTF-8</pre>
<h2>Terminalの再起動</h2>
設定を読みこむためにTerminalを一度再起動します。以下の点が確認できれば問題ないとおもいます。
<ol>
	<li>ログインシェルがzshになっている</li>
	<li>echo $SHELLで/opt/local/bin/zsh-4.3.4が出力される</li>
	<li>echo 日本語など日本語が入力でき、かつちゃんと出力される</li>
	<li>lsを発行したときに日本語のファイルやディレクトリが文字化けしていない</li>
</ol>
