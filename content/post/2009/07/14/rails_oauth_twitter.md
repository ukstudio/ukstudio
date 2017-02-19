---
title: RailsからOAuthを利用してTwitterにポストする
date: 2009-07-14
---
OAuthの細かい説明は抜き。

まず、OAuthを使うためにはTwitterでアプリケーションの登録が必要なので、<a href="http://twitter.com/oauth_clients">http://twitter.com/oauth_clients</a>で登録をしておいてください。 以下のコードの6行目の部分を取得したConsumer keyとConsumer secretをに置き換えてください。

<script src="http://gist.github.com/146684.js"></script>

適当なところからverifyアクションにリダイレクトしてくると、さらにTwitterにリダイレクトします。その後、callbackアクションに戻ってくるので、そこで認証して取得したトークンをUserモデルに保存します。(ここでは自分のサービスにログインしているユーザが認証を行っています。)

その後、保存したトークンを使ってTwitterに発言をします。リクエストが受け入れられなかった場合の処理などは省いてます。

<script src="http://gist.github.com/146685.js"></script>

Twitterには取得したトークンに有効期限はありませんが、有効期限が存在するものもある(どちらかというとそっちの方が多いのかも)気をつける必要があります。

ちなみに細かいことを調べていないので「トークンをDBに保存してしまっていいのか」とか「トークンが外部に漏れてしまった場合はどうしたらいいのか」などについてはよくわかっていません。