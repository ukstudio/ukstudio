---
title: RailsでMySQLとPostgreSQLを同時に扱う方法(+問題点)
date: 2008-10-04
aliases:
- /2008/10/04/rails_many_db
---
プラグインとか無しで、複数のDB(MySQLとPostgreSQL)を扱う方法。Rails2.1でしか試してないけど、多分1.2とかでも大丈夫。多分。MySQLとPostgreSQLの接続ライブラリはgemからインストールしておくこと。

まずは、database.ymlに扱うデータベースの定義を書く。

<pre lang="ruby">
development:
  adapter: mysql
  encoding: utf8
  database: db_development
  username: root
  password:

test:
(面倒だから略)

production:
(面倒だから略)

psql_development:
  adapter: postgres
  encoding: utf8
  database: ma2_mcd
  username: root
  password:

psql_test:
(面倒だから略)

psql_production:
(面倒だから略)

</pre>

次にPostgreSQLに接続させたいモデルを編集する。例えば、ProfileモデルはPostgreSQLの方に接続させたい場合は以下のようになる。

<pre lang="ruby">
class Profile < ActiveRecord::Base
  establish_connection("psql_#{RAILS_ENV}".to_sym)
end
</pre>

establish_connectionにシンボルでdatabase.ymlの定義を渡せば、そのモデルはその定義のデータベースに接続する。本番、テスト、開発でそれぞれ定義が違うだろうから、RAILS_ENVで今起動している環境の定義を呼び出すようにしてやる。

<h2>追記</h2>
上記の設定で一応アプリは動作するけど、いくつか問題点があるのでそれをメモしておく。

<h3>マイグレーションの使い分けはどうする</h3>
例えば、db/migrateにcreate_hoge_for_psql.rb(数値は略)とcreate_foo_for_mysql.rbと合った場合、それをどう実行するかが問題になってくる。

普通にrake db:migrateやrake db:migrate RAILS_ENV=psql_developmentとやったら、hogeとfooが両方とも作られてしまう。こちらとして望んでるのは、hogeがPostgreSQLのみ、fooがMySQLのみにできて欲しい。

うーむ、弱った。