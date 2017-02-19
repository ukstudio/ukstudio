---
title: Arelあれこれ

tags: ruby,rails,arel
date: 2014-09-05
---

## Model.arel_table を読みづらいと感じる

例えばこういうコード。

```ruby
Post.joins(:comments).order(Comment.arel_table[:created_at].desc)
```

発行されるSQLはこんな感じ。

```sql
SELECT "posts".* FROM "posts" INNER JOIN "comments" ON "comments"."post_id" = "posts"."id"  ORDER BY "comments"."created_at" DESC
```

こちらの方が個人的には読みやすい。

```ruby
Post.joins(:comments).order('comments.created_at desc')
```

## 問題もある

### テーブル名を変えてしまったとき

仮にテーブル名がかわったら後者の場合はエラーになる。

```sql
SELECT "posts".* FROM "posts" INNER JOIN "new_comments" ON "new_comments"."post_id" = "posts"."id"  ORDER BY comments.created_at DESC
SQLite3::SQLException: no such column: comments.created_at: SELECT "posts".* FROM "posts" INNER JOIN "new_comments" ON "new_comments"."post_id" = "posts"."id"  ORDER BY comments.created_at D
ESC
ActiveRecord::StatementInvalid: SQLite3::SQLException: no such column: comments.created_at: SELECT "posts".* FROM "posts" INNER JOIN "new_comments" ON "new_comments"."post_id" = "posts"."id"
  ORDER BY comments.created_at DESC

```

前者はモデルの方でテーブル名を変更すれば動作する。

```ruby
class Comment < ActiveRecord::Base
  self.table_name  :new_comments
end
```

### scopeでmergeしたいとき

```ruby
class Comment < ActiveRecord::Base
  scope :recent, -> { where('created_at > ?', 10.days.ago) }
end

Post.joins(:comments).merge(Comment.recent)
```

これだとCommentのcreated_atが解決できなくてコケる。

```sql
SELECT "posts".* FROM "posts" INNER JOIN "comments" ON "comments"."post_id" = "posts"."id" WHERE (created_at > '2014-08-26 09:16:45.106691')
SQLite3::SQLException: ambiguous column name: created_at: SELECT "posts".* FROM "posts" INNER JOIN "comments" ON "comments"."post_id" = "posts"."id" WHERE (created_at > '2014-08-26 09:16:45.
106691')
ActiveRecord::StatementInvalid: SQLite3::SQLException: ambiguous column name: created_at: SELECT "posts".* FROM "posts" INNER JOIN "comments" ON "comments"."post_id" = "posts"."id" WHERE (cr
eated_at > '2014-08-26 09:16:45.106691')
```

正しくはこう。

```ruby
class Comment < ActiveRecord::Base
  scope :recent, -> { where(self.arel_table[:created_at].gt(10.days.ago)) }
end
```

```sql
SELECT "posts".* FROM "posts" INNER JOIN "comments" ON "comments"."post_id" = "posts"."id" WHERE ("comments"."created_at" > '2014-08-26 09:19:17.406299')
```

## 僕個人の結論

Model.arel_tableはできる限り隠したい(読みづらいから)。そしてmergeを使いたいケースではArelを使っておく。その変わりmergeが必要になるまでは無理にArelを使わない。

さっきのComment#recentの例でいうなら最初は```where('created_at > ?', 10.days.ago)```で書いておく。merged使いたい時になったらArelの方で書き直す。

テーブル名の変更のリスクは気にしない。そもそもあまりテーブル変更しないし…。既にあるDBの上にRailsアプリケーションを構築する場合はDBリファクタリングのことを考えてArel使いまくった方がいいのかもしれない。