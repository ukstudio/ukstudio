---
aliases:
- /2008/06/04/rails_for_beginner
date: "2008-06-04"
title: RE:Rails初心者はどうやって他人のRailsコードを読めばいいか
---
オレもRailsを初めて3ヶ月(もうちょいあるかも)たったので、ある程度オレの経験を元にまとめてみる。参考になるといいなー。

<h2>1. まずはアプリケーションを実際に動作させる</h2>
<pre lang="bash">
% ruby script/server
</pre>
とりあえずコード読む前にそのアプリケーションがどんなものを把握するのが重要。コード読んでもわかるだろうけど、実際にブラウザでいじくりまわした方がはやく理解できると思う。その時にコントローラー名とアクション名もみといた方がよさげ。

<h2>2. モデル図を書く</h2>
これはid:Hash本人も重要って書いてたけど、ほんとに重要。そんなにキレイな図とかじゃなくていいから、紙とかに多対多なのか1対多なのかとか、参照名はなにかとかぐらいメモがてら書いておくと吉。モデルの関連さえ把握できれば、そのRailsアプリの半分以上理解できたも同然ってぐらい重要。

<h2>3. Logをみる</h2>
<pre lang="bash">
% tail -f log/development.log
</pre>
開発時にも言えることだけどなるべくLogはみた方がいい。log/の下にdevelopment.log(多分ないと思うけど、productionで動作させてるならproduction.log)があるのでtailコマンドとかでみるといい。フォームのsubmit時のパラメータが見れたり、あとはlogger.infoで出力をチェックしたりとかできる。

<h2>4. script/consoleを使う</h2>
<pre lang="bash">
% ruby ./script/console
</pre>
基本的な使い勝手はirbと同じ。irbと違うのはRails環境があらかじめロードされていること。例えば、モデルのメソッド名を呼び出したりとか。メソッドレベルで動作をみたい場合に便利。あと、2.0以降からモデル名を入力するとカラムの一覧も表示される。

<pre lang="ruby">
>> User
=> User(id: integer,  created_at: datetime, updated_at: datetime)
>> User.find(:all)
=> []
>> user = User.new
=> #<user id: nil, created_at: nil, updated_at: nil>
</pre>

<h2>test(or spec)があれば見る *追記08/06/04*</h2>
<blockquote>
できれば「test(or spec)があれば、見ろ」も入れて欲しい。
あれは「どういう挙動をして欲しいか」=「どう使うか」が書いてあるんだから、
どんな構造のアプリなんだか理解する助けになるよ。
てか、ならないなら書く意味ないもの。
</blockquote>
コメント欄での指摘。このエントリを書こうと決めたときは書くつもりだったのに、実際に書いたら忘れてたっていう。

thx、faultier。

<h2>まとめとオマケ</h2>
なんかTips的なエントリになったけど、とりあえずざっと思いついたのはこんな感じ。あとはコントローラのアクションからスタートして、モデルのメソッドや一連の流れを追えばいいんじゃないかな。コントローラーのアクションも上から順に読むよりは、機能ごとの流れで追った方がいいと思う。例えば、new->create->showとかedit->update->showとか。実際はもうちょい複雑な場合もあるだろうけど。実際の流れがどんな風になってるかは実際にアプリを動かしながらURLを確認したり、ログの出力やビューのフォームのアクションを見れば大体わかるはず。

あとはオマケ的な指摘だけど、Railsが2系であればビューファイルの拡張子は「.rhtml」より「.html.erb」の方がいい。この辺はActionPackのマルチビューに関係してる。この辺は初心者のうちはとりあえず「.html.erb」にしとくぐらいでいいと思うし、なによりオレがマルチビューについてまだちゃんと理解してないので詳細ははぶく。ｻｰｾﾝ｡

respond_toは1つのアクションで複数のフォーマットを出力するときに使う。
<pre lang="ruby">
respond_to do |format|
  format.html
  format.xml { render :xml => @user }
end
</pre>
上記のように書くと、ブラウザからの通常アクセス時はhtmlを、WebサービスなどでXMLを指定された場合はXMLを出力する。Webアプリは、例えばブラウザからのアクセスとAPIでのアクセスで、処理は同じだけど出力が違うなんてことがあったりする。そういうときにrespond_toで指定してやることで無闇にアクションを増やさなくてすむ。

<table  border="0" cellpadding="5"><tr><td colspan="2"><a href="http://www.amazon.co.jp/gp/redirect.html%3FASIN=4797336625%26tag=2004-05-22%26lcode=xm2%26cID=2025%26ccmID=165953%26location=/o/ASIN/4797336625%253FSubscriptionId=0G91FPYVW6ZGWBH4Y9G2" target="_top">Railsレシピブック 183の技</a><img src='http://www.assoc-amazon.jp/e/ir?t=2004-05-22&l=ur2&o=9' width='1' height='1' border='0' alt='' /></td></tr><tr><td valign="top"><a href="http://www.amazon.co.jp/gp/redirect.html%3FASIN=4797336625%26tag=2004-05-22%26lcode=xm2%26cID=2025%26ccmID=165953%26location=/o/ASIN/4797336625%253FSubscriptionId=0G91FPYVW6ZGWBH4Y9G2" target="_top"><img src="http://ecx.images-amazon.com/images/I/419FtZYCmyL._SL160_.jpg" border="0" alt="Railsレシピブック 183の技" /></a></td><td valign="top"><font size="-1">高橋 征義<br /><br />ソフトバンククリエイティブ  2008-05-31<br />売り上げランキング : 1080<br /><br /><br /><a href="http://www.amazon.co.jp/gp/redirect.html%3FASIN=4797336625%26tag=2004-05-22%26lcode=xm2%26cID=2025%26ccmID=165953%26location=/o/ASIN/4797336625%253FSubscriptionId=0G91FPYVW6ZGWBH4Y9G2" target="_top">Amazonで詳しく見る</a></font><font size="-2"> by <a href="http://www.goodpic.com/mt/aws/index.html" >G-Tools</a></font></td></tr></table>

<table  border="0" cellpadding="5"><tr><td colspan="2"><a href="http://www.amazon.co.jp/gp/redirect.html%3FASIN=4274066967%26tag=2004-05-22%26lcode=xm2%26cID=2025%26ccmID=165953%26location=/o/ASIN/4274066967%253FSubscriptionId=0G91FPYVW6ZGWBH4Y9G2" target="_top">RailsによるアジャイルWebアプリケーション開発 第2版</a><img src='http://www.assoc-amazon.jp/e/ir?t=2004-05-22&l=ur2&o=9' width='1' height='1' border='0' alt='' /></td></tr><tr><td valign="top"><a href="http://www.amazon.co.jp/gp/redirect.html%3FASIN=4274066967%26tag=2004-05-22%26lcode=xm2%26cID=2025%26ccmID=165953%26location=/o/ASIN/4274066967%253FSubscriptionId=0G91FPYVW6ZGWBH4Y9G2" target="_top"><img src="http://ecx.images-amazon.com/images/I/51Y%2BviLzM5L._SL160_.jpg" border="0" alt="RailsによるアジャイルWebアプリケーション開発 第2版" /></a></td><td valign="top"><font size="-1">前田 修吾 <br /><br />オーム社  2007-10-26<br />売り上げランキング : 8708<br /><br /><strong>おすすめ平均  </strong><img src="http://g-images.amazon.com/images/G/01/detail/stars-5-0.gif" alt="star" /><br /><img src="http://g-images.amazon.com/images/G/01/detail/stars-5-0.gif" alt="star" />充実した内容でわかりやすい<br /><img src="http://g-images.amazon.com/images/G/01/detail/stars-5-0.gif" alt="star" />railsが良いのかrubyが良いのか本が良いのか<br /><img src="http://g-images.amazon.com/images/G/01/detail/stars-5-0.gif" alt="star" />１日に少しの時間で成果が分かる１冊<br /><br /><a href="http://www.amazon.co.jp/gp/redirect.html%3FASIN=4274066967%26tag=2004-05-22%26lcode=xm2%26cID=2025%26ccmID=165953%26location=/o/ASIN/4274066967%253FSubscriptionId=0G91FPYVW6ZGWBH4Y9G2" target="_top">Amazonで詳しく見る</a></font><font size="-2"> by <a href="http://www.goodpic.com/mt/aws/index.html" >G-Tools</a></font></td></tr></table>