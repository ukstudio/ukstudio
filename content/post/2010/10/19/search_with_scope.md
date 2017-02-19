---
title: scopeでお手軽検索
date: 2010-10-19
---
Rails3.0のscope(2系で言うnamed_scope)を使ったお手軽検索。モデルにextendして使う。やってることは渡されたパラメータのkeyのscopeを呼び出して、それらを全部チェインさせるだけ。お手軽だけど、scopeを定義するだけなので結構融通が効くし便利。
<script src="http://gist.github.com/632769.js?file=searchable.rb"></script>