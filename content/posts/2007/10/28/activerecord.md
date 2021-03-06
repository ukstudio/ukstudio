---
aliases:
- /2007/10/28/activerecord
date: "2007-10-28"
title: ActiveRecordを使ってみる
---
ActiveRecordはRubyOnRailsのO/Rマッパーとして有名ですが、Railsに依存しているわけではなく単体で使えます。

<h2>DBを用意する</h2>
なにはともあれ、DBがないと始まらないので適当に用意します。

<pre lang="sql">create database ar;
 use ar;
 create table users (
   id int unsigned not null auto_increment,
   name varchar(50),
   age int,
   primary key (id)
 );
</pre>

ユーザ名と年齢を管理するテーブルってことで。

<h2>DBへの接続とマッピング</h2>

<pre lang="ruby">
require 'rubygems'
require_gem 'activerecord'

# ARで接続
ActiveRecord::Base.establish_connection(
  :adapter    =>      'mysql',
  :host       =>      'localhost',
  :username   =>      'ユーザ名',
  :password   =>      'パスワード',
  :database   =>      'ar',
  :socket     =>      '/tmp/mysql.sock'
)

# マッピングクラスを定義
class User < ActiveRecord::Base
end
</pre>

データベースへのコネクションはActiveRecord::Base.establish_connectionで作られます。特にむずかしいところはないですね。socketは必ず書く必要はないです。書かない場合は/tmp/mysql.sockを見にいくのかな。

ActiveRecord::Baseを継承することでマッピングクラスを定義することができます。クラス名がUserusersテーブルへのマッピングを定義していることになります。クラスを単数形、テーブル名を複数形にすることで自動的にマッピングされます。いわゆるCoC(Convention over Configuration)ってやつです。

<h2>データの保存</h2>
newメソッド、もしくはcreateメソッドを使用し、ARオブジェクトを作成することでDBにデータを保存(Insert)することができます。newとcreateの違いは、newは明示的にsaveメソッドを実行する必要があり、createは自動的にsaveメソッドも実行されます。

</pre><pre lang="ruby">
# ARオブジェクトを作成
user = User.new(:name => "UK", :age => 20)
user.save    # DBに格納
</pre>

<pre lang="ruby">
# ARオブジェクトを作成
user = User.create(:name => "UK", :age =>20) # この時点でDBに格納される
</pre>

<img src="http://farm3.static.flickr.com/2121/1590439456_c3203f167b.jpg?v=0" />

<h2>データの検索</h2>
<img src="http://farm3.static.flickr.com/2137/1786644895_9bfe2b148c.jpg?v=0" />
データが1件だけじゃ少ないので数件ほど追加しました。

データの検索(Select)にはfindメソッドを使用します。他にもfind_allとか、find_by_sqlとかあるけどとりあえずfindのみの説明で。ちなみにfind_allは非推奨的な雰囲気。find(:all)を使えってことですね。

<blockquote>
DEPRECATION WARNING: find_all is deprecated and will be removed from Rails 2.0 ( use find(:all, ...)) See http://www.rubyonrails.org/deprecation for details.
</blockquote>

<h3>findメソッド</h3>
findメソッドの引数にIDを指定することで、該当するデータのオブジェクトが得られます。IDは複数指定することが可能でその場合の戻り値は配列です。:allを指定すると、 全件分のオブジェクトが得られます。こちらの場合も配列です。:firstを指定すると、先頭のオブジェクトを得られます。

<pre lang="ruby">
p User.find(1) # ID = 1のオブジェクト
=> #<user :0x147fbe8 @attributes={"name"=>"UK", "id"=>"1", "age"=>"20"}>
p User.find(1,4) # ID =1, ID = 4 のオブジェクトを格納した配列
=> [#</user><user :0x1476ed0 @attributes={"name"=>"UK", "id"=>"1", "age"=>"20"}>,
 #</user><user :0x147709c @attributes={"name"=>"bar", "id"=>"4", "age"=>"38"}>]
p User.find([2]) # ID = 2のオブジェクトを格納した配列
=> [#</user><user :0x14711d8 @attributes={"name"=>"hoge", "id"=>"2", "age"=>"40"}>]
p User.find(:all) # 全件分のオブジェクトを格納した配列
=> [#</user><user :0x140fca8 @attributes={"name"=>"UK", "id"=>"1", "age"=>"20"}>, #</user><user :0x140fc94 @attributes={"name"=>"hoge", "id"=>"2", "age"=>"40"}>, #</user><user :0x140fc6c @attributes={"name"=>"foo", "id"=>"3", "age"=>"14"}>, #</user><user :0x140fc44 @attributes={"name"=>"bar", "id"=>"4", "age"=>"38"}>]
p User.find(:first) # 先頭のオブジェクト
=> #</user><user :0x140cd28 @attributes={"name"=>"UK", "id"=>"1", "age"=>"20"}>
</user></pre>

各カラムのデータにアクセスする場合は以下のようにします。

<pre lang="ruby">
p User.find(1).name # UK
p User.find(1,4)[1].age # 38
p User.find([2])[0].name # hoge
p User.find(:all)[3].name # bar
p User.find(:first).age # UK
</pre>

<h3>ActiveRecord::RecordNotFound</h3>
ちなみに存在しないID(この場合だと5とか)を指定すると例外(ActiveRecord::RecordNotFound)が発生するので注意して下さい。

<h3>条件文の指定</h3>
普通に考えて、データへのアクセスにIDの指定とか不便すぎますよね。次は引数に条件文を与えてみたいと思います。SQLで言う、where文に該当します。

<pre lang="ruby">
p User.find(:first, :conditions => {:name => "UK"})
=> #<user :0x107fa84 @attributes={"name"=>"UK", "id"=>"1", "age"=>"20"}>
p User.find(:first, :conditions => {:name =>"hoge", :age => 40})
=> #</user><user :0x29954ec @attributes={"name"=>"hoge", "id"=>"2", "age"=>"40"}>
p User.find(:first, :conditions => {:name => "aaa"})
=> nil
</user></pre>

条件文は:conditionsで指定します。1番目のfindはnameカラムのデータが"UK"に該当するものから先頭のオブジェクトを返します。ここで:firstの指定を:allに変更すると:conditionsに該当する全てのオブジェクトを配列で返します。

<pre lang="ruby">
User.crate(:name => "UK", :age => 20) # ID = 1と同じデータを保存
p User.find(:fist, :conditions => {:name => "UK"}
=> #<user :0x2980718 @attributes={"name"=>"UK", "id"=>"1", "age"=>"20"}>
p User.find(:all, :conditions => {:name => "UK"}
=> [#</user><user :0x297b45c @attributes={"name"=>"UK", "id"=>"1", "age"=>"20"}>, #</user><user :0x297b614 @attributes={"name"=>"UK", "id"=>"5", "age"=>"20"}>]
</user></pre>

<h3>パラメータによるサニタイズ</h3>
上記のやり方だとパラメータを直接クエリに挿入します。いわゆるサニタイズと言ったものは行っていません。それだと流石にまずいと思うので以下のようにパラメータ使用します。

<pre lang="ruby">
p User.find(:all, :conditions => ["name = ? and age = ?", "UK", 20])
=> [#<user :0x296aa08 @attributes={"name"=>"UK", "id"=>"1", "age"=>"20"}>, #</user><user :0x296abc0 @attributes={"name"=>"UK", "id"=>"5", "age"=>"20"}>]
</user></pre>

このようにしてパラメータを指定することで"UK"と20はサニタイズされます。

<h3>名前付きパラメータ</h3>
パラメータを使用している場合、クエスチョンマークが増えすぎるとわかりにくくなる時があります。その場合は名前つきパラメータを使用します。クエスチョンマークの代わりにシンボルを使用し、シンボルをキーにしたハッシュを渡します。

<pre lang="ruby">
User.find(:all, :conditions => ["name = :name and age = :age", {:name => "UK", :age => 20}])
=> [#<user :0x2962c7c @attributes={"name"=>"UK", "id"=>"1", "age"=>"20"}>, #</user><user :0x2962e34 @attributes={"name"=>"UK", "id"=>"5", "age"=>"20"}>]
</user></pre>

<h2>データの上書き保存</h2>
データの上書き保存(Update)するにはfindメソッドなどでARオブジェクトを作成、操作しsaveメソッドで行ないます。

<pre lang="ruby">
user = User.find(:first, :conditions => {:name => "hoge"})
p user.age # 40
user.age =69
user.save

User.find(:first, :conditions => {:name => "hoge"})
=> [#<user :0x292d694 @attributes={"name"=>"hoge", "id"=>"2", "age"=>"69"}>]
</user></pre>

<h2>データの削除</h2>
データの削除(Delete)はdeleteメソッドや、destroyメソッドを使用します。

<pre lang="ruby">
User.delete(1) # ID = 1を削除

user = User.find(:first, :conditions => {:name => "UK"})
user.destory # name が "UK"のデータを削除
</pre>

<h2>雑感</h2>
とりあえずざっとActiveRecordに触れてみましたが、DBをRubyのオブジェクトのように扱えるのは思いの外気持ちがいいですなー。ただ、プライマリーキー名が"id"固定なところやテーブル名を複数形云々のあたりが気になる人はいるのかなぁと。あと複合キーとかどうするんだーとか。そういうところを気にしないので済むのであれば、ActiveRecordはかなり良いと思います。

それにしてもコードがみづらいことこの上ないですね・・・そのうちなんとかしたいところです。

<a href="http://www.amazon.com/gp/redirect.html%3FASIN=1590598474%26tag=ukstudio0c-22%26lcode=xm2%26cID=2025%26ccmID=165953%26location=/o/ASIN/1590598474%253FSubscriptionId=1N9AHEAQ2F6SVD97BE02" title="Click and drag this image to the post editor"><img src="http://ecx.images-amazon.com/images/I/21rVApqb6cL.jpg" width="121" /></a>