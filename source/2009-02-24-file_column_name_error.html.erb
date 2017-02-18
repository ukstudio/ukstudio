---
title: Rails2.0.2から2.2.2に上げたらFileColumnがNameErrorだした。
---
自分の担当している案件のRailsのバージョンを2.0.2から2.2.2に上げたら以下のようなエラーが発生。
<blockquote>
uninitialized constant FileColumn::ClassMethods::Inflector (NameError)
</blockquote>

これの対応は/vender/plugin/file_column/lib/file_column.rbの以下の部分を
<pre lang="ruby">
my_options = FileColumn::init_options(options,
                                                 Inflector.underscore(self.name).to_s,
                                                 attr.to_s)
</pre>

以下のように書き換えればとりあえず対応できる。

<pre lang="ruby">
my_options = FileColumn::init_options(options,
                                                 self.name.to_s.underscore,
                                                 attr.to_s)
</pre>

ちゃんちゃん。
