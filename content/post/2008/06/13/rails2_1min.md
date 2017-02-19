---
title: Ruby on Rails 2.0アプリを10秒で作る2.0
date: 2008-06-13
---
<ul>
<li>Railsのインストールは作業時間に含みません</li>
<li>shファイル作る時間も含みません</li>
<li>筆者の環境がMacBookなのでそれ以外の環境は適当に脳内変換すべし</li>
<li>ネタです</li>
</ul>

適当なディレクトリにhoge.shを作る。

<pre lang="sh">
rails itpro
cd itpro
script/generate scaffold itpro userid:string name:string
rake db:migrate
</pre>

<pre lang="bash">
$ chmod 775 hoge.sh
#別に775じゃなくてもとりあえず実行権限あたえればおk
</pre>

んじゃ、こっからスタート。以下の3行を10秒でうちこむ。Tabキー使えば余裕でしょ。あと、hoge.shの実行時間とserverの起動は考慮してないから。
<pre lang="bash">
$ ./hoge.sh
$ cd itpro
$ ruby ./script/server
</pre>

んで、http://localhost:3000/itprosにブラウザからアクセス。表示されればおk。

<a href="http://itpro.nikkeibp.co.jp/article/COLUMN/20080606/306873/">Ruby on Rails 2.0アプリを1分で作る : IT Pro</a>