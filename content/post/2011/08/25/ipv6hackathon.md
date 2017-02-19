---
title: IPv6 Hackathonに参加してきた
date: 2011-08-25
---
この間のLL PlanetsでIPv6 Hackathonとやらに参加してきた。Ruby組は僕と @sugamasao と @takano32 の3人でチーム組んだ。

<h2>RailsはIPv6でも大丈夫っぽい</h2>
大丈夫っぽいっていうのは軽くさわった程度なので断言できるほどでもないため。IPv6でRailsを立ち上げたかったら上記のように--bを指定すれば大丈夫です。

<pre><code>rails server --b="::"  -p 3000</code></pre>

Unicornの場合もオプションで大丈夫。

<pre><code>unicorn_rails -l '[::]:3000'</code></pre>

あとはApacheは対応してるし一応なんとかなるのではないか。Nginxとかthinは調べてないのでわからないです。あとMySQLはIPv6に対応していないらしいけど、データベースはWebサーバから見えれば大丈夫だし何とかなるでしょう。きっと。

<h2>github.comやrubygems.orgはAAAAレコードがない</h2>
digコマンド叩けばわかるけど、みんな大好きgithub.comとrubygems.orgにはAAAAレコードがありません。ということで、IPv6オンリーな環境だと使えないと思うのでトンネル掘るなりなんなりの対応が必要っぽい。

<h2>今回作ったもの</h2>
ネタアプリを作っただけなので実装としてはそんなにおもしろいものでもないかな。

ひとつは、twitterの発言ひとつに対してIPv6のアドレスをひとつ割り振って、そのIPv6にリクエストがきたらそれに対応するtwitterの発言を表示させるというもの。ただのアドレスの無駄遣いですね。

あと1時間ぐらい僕の時間があまったので、その1時間でIPv6アドレスをキーとするストレージっぽいものを作った。あるIPv6に対してPOSTするとbodyの内容が保存されて、GETすると保存された内容が取得できるみたいな。更新はPUTだろっていう話もあったけど、時間が足りなかったのでした。

発表資料がそのうち公開されると思います。
<a href="http://ll.jus.or.jp/2011/slide.html">Lightweight Language Planets : 公開資料</a>
<h2>Net::HTTPとURI</h2>
そのストレージのテストをするのにRubyでNet::HTTPとURIを使って画像をPOSTするコードを書いた。その時にちょっとハマったことがあるので説明しておく。

<script src="https://gist.github.com/1170083.js?file=ipv6.rb"></script>

IPv6は:を使ってアドレスを区切るので、ポート部とわけるために[]を使うことがある。そのアドレスをURI.parseしたあとにURI::HTTP#hostで値を取得すると[]が残ったままになり、Net::HTTPは[]があるとどうやらダメっぽくてエラーがでる。パッと見コードに何も問題がなさそうに見えるので知っておかないとハマる人はハマりそう。実際に僕はハマりました。

で、たまたまURI::HTTP#hostnameというメソッドがみつけてこっちは[]を取り除く。このURI::HTTP#hostnameはるりまを見るとどこにも乗ってなくて、挙動の違いはバグかとも思ったりしたんだけどどうやら違うみたい。

Rubyのuri/generic.rbを見ると以下のように書いてあった。

<blockquote>
# Since IPv6 addresses are wrapped by brackets in URIs,
# this method returns IPv6 addresses wrapped by brackets.
# This form is not appropriate to pass socket methods such as TCPSocket.open.
# If unwrapped host names are required, use "hostname" method.
#
#   URI("http://[::1]/bar/baz").host #=> "[::1]"
#   URI("http://[::1]/bar/baz").hostname #=> "::1"
</blockquote>

ということで、hostnameメソッドを使いましょうという話でした。