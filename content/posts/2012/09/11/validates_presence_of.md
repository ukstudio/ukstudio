---
aliases:
- /2012/09/11/validates_presence_of
date: "2012-09-11"
title: validates :foo_id, :presence => trueを追う
---
チームメンバーから「validates_presence_of :user_idはそのuser_idが存在するか確かめてくれる」という情報を得て、そんな隠れ仕様あんの?とおもってちょっと調べてみた。

結論だけまず言うと
<pre>
validates :user_id, :presence => true
validates_presence_of :user_id
</pre>
ではなく、
<pre>
validates :user, :presence => true
validates_presence_of :user, :presence => true
</pre>
の用に関連名を指定するとそれっぽい動作をしなくもない。

とりあえずコードを追うとpresence系のバリデーション自体はActiveModel::Validations::PresenceValidatorで定義されている。

<pre>module ActiveModel
  # == Active Model Presence Validator
  module Validations
    class PresenceValidator < EachValidator
      def validate(record)
        record.errors.add_on_blank(attributes, options)
</pre>

次にadd_on_blankを見てみる。

<pre># File activemodel/lib/active_model/errors.rb, line 251
def add_on_blank(attributes, options = {})
  [attributes].flatten.each do |attribute|
    value = @base.send(:read_attribute_for_validation, attribute)
    add(attribute, :blank, options) if value.blank?
  end
end
</pre>

add_on_blankメソッドはattributesの内容を走査してblankだったらerrorsに追加してるんだろうなーというのが読み取れる。じゃあ実際に値を取ってきてるであろう:read_attribute_for_validationは何なのだろう。api.rubyonrails.orgで検索してもヒットしない。仕方ないからgitリポジトリをgrepして探す。そうすると以下の様なコードがみつかる。

<pre># activemodel/lib/active_model/validations.rb line 327
alias :read_attribute_for_validation :send
</pre>

つまりただのsend。なので

<pre>validates :user_id, :presence => true</pre>

というコードは

<pre>instance.send(:send, :user_id)</pre>

となり、結局は普通に指定した属性の値を見るに過ぎない。


で、最初の話に戻るが

<pre>
validates :user_id, :presence => true
</pre>
は普通にuser_idの値がblank?かどうかだけを見るので実際にそのuser_idでUserが存在するかチェックはしない。

<pre>
validates :user, :presence => true
</pre>

はどうかというと、instance.userがnilの状態でinstance.userを呼び出すとinstance.user_idでUserを取りにいく。そこでUserが存在しなければ[]が返ってくるのでblank?がtrueとなりこのバリデーションは失敗する。

<pre>
instance = Model.new
instance.user_id = 111111111
instance.valid? #=> false
  User Load (3.4ms)  SELECT "users".* FROM "users" WHERE ""."id" = 111111111 LIMIT 1
</pre>

なので、このケースに限って言えばそのIDのレコードが存在するか確認する動作をしている。とは言え、あくまでisntance.userの値を見るだけなので

<pre>
instance = Model.new
instance.user = User.new
instance.valid? #=> true
</pre>

この様に直接値を入れてしまえばDBにselect文はなげない。

なので、そういう動作をすることもあるだけで厳密にはそのIDのレコードが存在を確かめているわけではない。