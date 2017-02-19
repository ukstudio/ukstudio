---
title: TIG+Limechatで携帯百景の画像をインライン展開する
date: 2010-04-23
---
<strong>公式の方でtwitpic, tweetphoto, yfrog, twitgoo, img.ly, movapic, f.hatena.ne.jpの画像展開がサポートされました。よって現在はこの方法を取らなくても大丈夫です。<a href="http://limechat.net/mac/ja.html">http://limechat.net/mac/ja.html</a></strong>

引き続き、Limechatネタ。Limechatは画像のURLをインライン展開してくれるので、当然TIG(<a href="http://www.misuzilla.org/dist/net/twitterircgateway/" target='_blank'>TwitterIRCGateway</a>)で取得してきたものに画像へのリンクがあればそれも展開する。

しかし、Twitterでは必ずしも画像とわかるURLが流れてくるわけじゃないので展開しない場合もある。個人的にTwitterに画像をあげるとき携帯百景を使うことが多いんだけど、それはURLが画像とわかるものじゃないのでLimechatでは展開してくれない。

TIGではIronRubyやら、IronPythonやらで色々とごにょごにょする仕組みがあるらしく、一応はそれでなんとかできたので手順を書いておく。

まず、TIGのディレクトリにConfigs/[User]にScriptsディレクトリを作る。

<script src="http://gist.github.com/375695.js?file=movapic.rb"></script>

そしてこのファイルを適当な名前でそこに保存する。

次に、Limechatの方で#Consoleにjoinし、"DLR"と入力。更にそのまま"reload"と入力。ファイルを読み込んだことを告げるメッセージが返ってくればOK。

仕組みとしては単純で、携帯百景は画像のURLが決まっているので、Twitterにポストされた携帯百景のURLから画像パスを求め、それを発言の末尾に追加しているだけ。スクリプトの正規表現が結構適当なのでもしかしたらうまくうごかない時があるかもしれない。もし使うとしたらそこらへんは自己責任で。

ちなみに展開された画像はこんな感じ。これはTwitterにWeb上からポストした僕の発言。

<img src="http://173.230.148.68/wp-content/uploads/2010/04/20100422-8paygkaqdx7gn71snmcektsqs9.jpg" alt="20100422-8paygkaqdx7gn71snmcektsqs9" title="20100422-8paygkaqdx7gn71snmcektsqs9" width="400" height="314" class="aligncenter size-full wp-image-623" />

多分、似たようなやり方でTwitpicとかも対応できると思うので後でやってみようと思う。