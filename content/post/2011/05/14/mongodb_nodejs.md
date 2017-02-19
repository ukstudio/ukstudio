---
title: mongodb + node.js を軽く試した
date: 2011-05-14
---
<h2>mongodbのインストール</h2>
<pre class='sunlight-hilight-bash'>$ sudo aptitude install mongodb
$ mkdir /path/to/data
$ mongod --dbpath /path/to/data</pre>

<h2>mongooseのインストール</h2>
<pre>$ npm install -g mongoose</pre>
node.jsでmongodb扱うのに他にもライブラリあるみたいだけど、とりあえずnpmでサクッと使えるmongooseを使ってみる。
<h2>サンプル</h2>
軽く試しただけなので、詳細は <a href="https://github.com/LearnBoost/mongoose">LearnBoost/mongoose - GitHub</a> を参照。
<script src="https://gist.github.com/971943.js"> </script>
実行するとmongodbの中身はこんな感じ。

<pre>> db.users.find()
{ "_id" : ObjectId("4dce0fb5bad67a145c000001"), "name" : "AKAMATSU Yuki", "age" : 24 }</pre>

印象としてはActiveRecordっぽいというかORMっぽいというか。mongodb自体をそんなに触ってないからこのアプローチが正しいのかどうかはわからないけど、馴染みやすくはある。