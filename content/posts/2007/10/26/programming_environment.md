---
title: Re:あなたの最も実力を発揮できる開発環境を教えてください
date: 2007-10-26
aliases:
- /2007/10/26/programming_environment
---
<a href="http://ujihisa.nowa.jp/entry/720100065b">rubyneko -
あなたの最も実力を発揮できる開発環境を教えてください</a>に反応してみる。
<h2>開発まっしーん</h2>
マシン: MacBook
OS     : Mac OS X
今年買ったMacBookの白が愛用機。サブディスプレイとかは無し。キーボードはJIS配列。ASCII配列にすればよかったと後悔している。日本語入力はAquaSKKを使用。
<h2>使用ソフト</h2>
<h3>Terminal.app</h3>
iTermは重いから標準のTerminalを使用。
<h3>vim</h3>
EmacsよりVi派です。あまり使いこなせてないけど。
<h3>zsh</h3>
MacBookを買った時に、zshを薦められて以来使用。こっちも使いこなせていない。キーバインドはviモードにしてる。
<h3>screen</h3>
キーバインドはデフォルトのまま。
<ul>
	<li>メインのソースコード編集</li>
	<li>テストコード編集 &amp; 実行</li>
	<li>メインのスクリプト実行</li>
	<li>ファイル操作</li>
</ul>
で、4画面ぐらいを使いわけ。最後のファイル操作は特に用意しないことも多い。
<h2>開発の流れ</h2>
作るものの規模にもよるけど、大体の構成を紙に書いて考えることが多い。Webアプリなら画面設計のラフとか、ちょっとしたクラス図とか。

コード書くときは基本的にTDDもどきな感じでテストコードを書くようにしてる。テストコードを書くようになったのはつい最近でまだまだ慣れてない感じ。テストコード書きながら設計の細かいところを考えていく。

あまり横断的に作業せず、機能を1つ1つ作りこんでいく感じ。そうしないと性格的に最後の方になって、各機能それぞれ80%ぐらい出来てるけど、100%のものは1つも無いってことになりがち。

コード管理はSVN。テストが通っていないものはCommitしない方針。
<h2>オマケ</h2>
作業につまると、意味もなくViで:wをしたり、シェルでlsやpwdをしがち。