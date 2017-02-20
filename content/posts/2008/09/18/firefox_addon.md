---
title: Firefoxの拡張の整理
date: 2008-09-18
aliases:
- /2008/09/18/firefox_addon
---
1つ前の記事でプロファイルの使い分けの設定をしたけど、整理もかねて~/Library/Application Support/Firefoxを削除して、1から構築しなおした。

<h2>拡張のインストール</h2>
<h3>開発/普段共通</h3>
<dl>
<dt>Nightly Tester Tools</dt>
<dd>今、メインに使っているのがShiretoko(Firefox3.1α2)なので、これを入れないと動かない拡張が多い</dd>
<dt>Vimperator</dt>
<dd>Firefoxをvimみたいに操作。もうこいつがないと生きていけない体になってしまった。</dd>
<dt>XUL/Migemo</dt>
<dd>Vimpでmigemo_hint.jsを使うために。</dd>
<dt>GreaseMonkey</dt>
<dd>あんまりグリモンは使っていなくてAutopagerizeぐらいかな。でも必須。</dd>
</dl>

<h3>開発</h3>
<dl>
<dt>Web Developer</dt>
<dd>HTMLやCSSいじったりするときに。ブロック要素の枠表示が一番使用率高いかも。</dd>
<dt>Firebug</dt>
<dd>JavaScriptを書くときに。Inspect Element(日本語だと要素を表示とかだっけ?)が地味に便利。</dd>
<dt>Live HTTP Headers<dt>
<dd>ブラウザがどんなリクエストを送って、どんなレスポンスを受けとってるか調べるときに。HTTPステータスとか。</dd>
<dt>HTML Validator</dt>
<dd>名前のとおり。タグの閉じ忘れとかもわかる。</dd>
<dt>SQLite Manager</dt>
<dd>RailsでたまにSQLiteを使うのでその時に。</dd>
<dt>SeleniumIDE</dt>
<dd>Seleniumのテストケースを作る時に。ブラウザが勝手に動くのはおもしろい。</dd>
<dt>RestTest</dt>
<dd>RESTアプリのテストに。GET/POST/PUT/DELETEのヘッダを偽装。</dd>
</dl>

大体こんな感じか。普段は基本的に閲覧しかしないので、vimpとグリモンがあればOK。他の拡張はほとんど開発のときにしか使わないので、必要なときだけ読み込めばいい。

vimpのプラグインと設定ファイルに関しては、<a href="http://github.com/ukstudio/config/tree/master">githubに置いてある</a>ので、それをもってくるだけ。

とりあえずこんなもんかなー。