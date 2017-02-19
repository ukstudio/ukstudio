---
title: Cucumber+email_specでActionMailerのテストをする
date: 2009-05-11
---
今までメール(ActionMailer)のテストはどうにも面倒で、自分でブラウザから動かしてログを見てってやっていたんですが、Cucumberでメールのテストもできるっぽいので試してみました。

確認環境はRails2.3.2、Cucumber0.2.3、email_spec0.0.10。

email_specはgithubをsourceに指定してインストールすることができます(<a href="http://github.com/bmabey/email-spec/tree/master">bmabey's email-spec at master - GitHub</a>)。config/environments/test.rbあたりに書いておくといいと思います。

email_specをインストールするとgenerateにコマンドが追加されています。

<pre lang="bash">
$ ruby script/generate email_spec
</pre>

ここで生成されるfeatures/step_definitions/email_steps.rbは英語なので日本語に直したものを使います。

<script src="http://gist.github.com/109924.js"></script>

これは僕がこないだ出向していたときのプロジェクトに使われていたものなので、多分その出向先の誰かが作ってくれたものだと思います。ありがとうございます。

最後にemail_specを使えるようにfeatures/support/env.rbに

<pre lang='ruby'>
require 'email_spec/cucumber'
</pre>

を追記してやります。あとはシナリオにテストケースを書いてテストすればOKです。

<pre lang="ruby">
 ならば "example@hoge.com" がメールを1通受信していること
</pre>

ちなみにメールの文章中にあるURLに遷移することもできるので、例えば仮登録→メールで認証URL→本登録という流れもちゃんとテストできます。