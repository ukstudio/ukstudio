---
title: RetrospectivaをMacBookに設置してみた
date: 2007-12-05
---
<a href="http://retrospectiva.org/blog">blog . retrospectiva</a>

どんなものか試しに設置してみた。あくまで試しなのでSQLite、WEBrickで。まずは必要なソフトのインストールから。

<h2>SQLite3のインストール</h2>
MacPortsを使ってSQLiteを、RubyGemsを使ってSQLiteを扱うライブラリをインストール。
<pre lang="bash">
% sudo port install sqlite3
% sudo gem install sqlite3-ruby
</pre>

<h2>retrospectivaの設置</h2>
<a href="http://retrospectiva.org/wiki/Quick+install">Quick Install - wiki . retrospectiva</a>を参考にしつつ。

<pre lang="bash">
% svn export http://retrospectiva.googlecode.com/svn/branches/1-0 retrospectiva
% cd restrospectiva
</pre>

リポジトリからファイルを持ってきたら、DBの設定がMySQLになっているのでSQLiteの設定に変更。
<pre lang="bash">
% mv config/database.yml.todo config/database.yml
% vim config/database.yml
</pre>
<strong>database.yml</strong>
<pre lang="ruby">
development:
  adapter: sqlite3
  database: retrospectiva_development

test:
  adapter: sqlite3
  database: retrospectiva_test

production:
  adapter: sqlite3
  database: retrospectiva
</pre>

rakeは試しなのでdevelopment(引数なし)で。特にエラーがでないようならWEBRickを起動してhttp://localhost:3000/にアクセス。

<pre lang="bash">
% rake db:retro:load
% ruby script/server
</pre>

IDとパスワードを聞かれるので admin / passwordを入力。

適当にプロジェクトを作ってみた感じが以下のキャプチャ。
<img src="http://farm3.static.flickr.com/2067/2086299815_6a6030a3b6.jpg?v=0"/>

SVNの連携とかはまたそのうち。Rails環境があれば、とりあえず起動するのはラクチン。