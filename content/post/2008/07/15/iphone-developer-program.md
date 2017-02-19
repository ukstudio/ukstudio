---
title: iPhone Developer Programに登録しました。
date: 2008-07-15
---
結論から言うと、まだ実機検証も配布もできてない段階です。そもそもアプリ作れてないですしね。ただ、米国在住者じゃないと登録できないってことはないですね。とりあえず登録はできたっぽいので。

端的に今の状況を説明すると、

<ul>
<li>iPhone Developer Program(Standardの方、$99)を日本のオンラインApple Storeから注文する</li>
<li>activate codeがメールで届く</li>
<li><blockquote>
We are unable to activate your iPhone Developer Program membership because we are unable to successfully verify your identity. Please contact us and reference Enrollment ID#xxxxxxx for further assistance.</blockquote></li>
<li>activateできねーよ!って日本語と英語でADC(Apple Developer Connection)のcontact usから送信</li>
<li>数時間後、「あんたのアカウント情報調整したからもっかい試してみ」って返事がくる(日本語できた)</li>
<li>めでたくactivate完了</li>
</ul>

そんな感じでとりあえずDeveloper Programには登録できましたーと。んで、そのあとも実機検証までデバイスの登録とか証明書の作成とか色々ある。やり方は一応英語でドキュメントがあるけれど、なんかキレイにまとまってない。とりあえずはProgram Portal(activate後、ログインできるページ)のメニューを順番にやっていけばいいんじゃないかねー。各メニューにHow Toがあるからそれに従えばいいはず。

おれがやったのは

<ul>
<li>Certificatesの追加</li>
<li>Devicesの追加</li>
<li>App IDsの追加</li>
<li>Provisioningの追加</li>
<li>xcodeのオーガナイザ上で、iPod Touchのrestore</li>
<li>オーガナイザでTouchにProvisionを追加</li>
<li>xcodeのプロジェクトのinfoでDeviceを選択しようにも選択肢にでない! <- ｲﾏｺｺ</li>
</ul>

正直、手順が悪かったのか何が悪かったのかがよくわからない。AppleIDに登録してある情報が日本語だからから至るところで文字化けしてるし。証明書のコモンネームまで文字化けしてる。

xcodeのinfoでiPhoneDeveloper:<firstname><lastname>を入力するところがあるんだけど、そこに証明書のコモンネームを書けってドキュメントに書いてあったけど、上で書いたようにコモンネームが文字化けしてるのでどうしたもんかなーと。

んで、証明書を作りなおししまくってたら、Errorがでるようになって追加できなくなってしまった。んで、またメールでなんとかしてーって連絡したところ。

そんな感じでまだiPod Touchで自作appを作るところまではいってない。これからやる人は英語のApple ID作った方がいい気がする。その方が問題なさそう。ただ、あれって日本の住所でも英語で登録できたっけ・・・

とりあえずまた進展があったらエントリ書く。

<h2>追記</h2>
どうやら大抵の人は一発でactivateできてないっぽいですね(We are unable to activate your iPhone...ってやつ)。そう言うときはとりあえずメールでなんとかしてくれーと頼むのがいいんじゃないですかね。

実機で動かすまでが長いですなぁ。