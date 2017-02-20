---
title: MacBook始めました
date: 2007-07-08
aliases:
- /2007/07/08/start-macbook
---
普段使っていたノートPC(Win) がどうやら逝ってしまったみたいなのでこの機会に念願のMacBookを手に入れました。
<table border="0" cellpadding="5">
<tr>
<td valign="top"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B000QUIURY/ukstudio0c-22/" target="_top"><img src="http://g-ec2.images-amazon.com/images/I/11Cbr66vqlL.jpg" alt="Apple MacBook White 2.16GHz Core 2 Duo/13.3/1G/120G/8x SuperDrive DL/Gigabit/BT/DVI MB062J/A" border="0" /></a></td>
<td valign="top"><font size="-1"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B000QUIURY/ukstudio0c-22/" target="_top">Apple MacBook White 2.16GHz Core 2 Duo/13.3/1G/120G/8x SuperDrive DL/Gigabit/BT/DVI MB062J/A</a></font><font size="-1">アップルコンピュータ  2007-05-16
売り上げランキング : 3083</font><font size="-1"><a href="http://www.amazon.co.jp/exec/obidos/ASIN/B000QUIURY/ukstudio0c-22/" target="_top">Amazonで詳しく見る</a></font><font size="-2"> by <a href="http://www.goodpic.com/mt/aws/index.html">G-Tools</a></font></td>
</tr>
</table>
MacBookを起動して行った設定のメモ
<h3>Vimの日本語対応</h3>
~/.vimrcを作り以下のように設定
<pre>
:set enc=utf-8

:set fenc=utf-8

:set fencs=iso-2022-jp,euc-jp,cp932</pre>
Terminalの設定変更。
<ol>
	<li>ファイル-&gt;情報をみる</li>
	<li>エミューレーション-&gt;非ascii文字をエスケープするのチェックをはずす</li>
</ol>
<h3>シェルをzshに変更</h3>
<ol>
	<li>ターミナル-&gt;環境設定</li>
	<li>｢このコマンドを実行する｣にチェック。パスに｢/bin/zsh」</li>
</ol>
これでターミナル起動時のシェルがzshになります。zshインストールしないといけないと思ってたらデフォルトでインストールされてた。

あとは、FirefoxとFirebugとGoogleBrowserSyncとかのAdd-onを少々。