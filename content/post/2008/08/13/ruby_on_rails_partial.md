---
title: Railsのpartialの使い方
---
あまりpartialをちゃんと使いこなせていない気がするので(いつもインスタンス変数で適当に値わたしてる)使い方をちょっとメモ。

<pre lang="ruby">
render :partial => 'entry'
</pre>

一番基本となるpartialの使い方。_entry.html.erbを描画。

<pre lang="ruby">
render :partial => 'entry', :locals => {:title => "タイトル"}
</pre>

localsでpartial側に値を渡す。partial側ではローカル変数titleで文字列"タイトル"を参照できる。

<pre lang="ruby">
render :partial => 'entry', :object => @object
render :partial => @entry # インスタンス変数で単数形
</pre>

objectでpartial側に値を渡す。@objectの内容をpartial側でローカル変数entryで参照できる。

<pre lang="ruby">
render :partial => 'entry', :collection => @objects
render :partial => @entries # インスタンス変数で複数形
</pre>

collectionで値を渡す。@objectsの値を1つずつ、partial側でentryとして参照できる。もちろん描画は@objects分繰り返される。
