---
aliases:
- /2010/12/24/misawa-ruby-recipe
date: "2010-12-24"
title: IRCでミサワをいつも側に...
---
このエントリーは<a href="http://atnd.org/events/10901">Ruby逆引きレシピAdvent Calendar</a>の参加エントリです。担当は12月24日です。前日のエントリは@kei-sさんの <a href="http://d.hatena.ne.jp/kei-s/20101223/1293084650">Ruby逆引きレシピで作る、忙しい人のための『地獄のミサワの「女に惚れさす名言集」』- 札幌市西区</a>です。

<a href="http://ukstudio.jp/wp-content/uploads/2010/12/FxCam_12931282608781.jpg"><img src="http://ukstudio.jp/wp-content/uploads/2010/12/FxCam_12931282608781.jpg" alt="" title="FxCam_1293128260878" width="360" height="240" class="alignnone size-full wp-image-783" /></a>


さて、私達プログラマが使うソフトウェアの中で最も起動時間の長いものは多分エディタでしょう。では次はなんでしょうか?そう、<strong>IRC</strong>ですね!今回は逆引きレシピの中から「レシピ109 IRC botを作りたい」を紹介します。

レシピのサンプルコードを参考に「ミサワ」のキーワードに反応して地獄っぽい返答をするBOTを作ってみました。これでいつでもミサワ先輩のありがたい御言葉を頂戴することができますね!

<script src="https://gist.github.com/753353.js?file=irc.rb"></script>
<a href="http://ukstudio.jp/wp-content/uploads/2010/12/screenshot3.png"><img src="http://ukstudio.jp/wp-content/uploads/2010/12/screenshot3.png" alt="" title="screenshot3" width="711" height="125" class="alignnone size-full wp-image-781" /></a>

上記のコードだとありがたい御言葉がハードコーディングされていますね。ミサワ先輩のありがたい御言葉はたくさんありますから全て書くのはあまり効率的ではありません。なのでRuby逆引きレシピAdvent Calendarの12月17日を担当した@june29さんの<a href="http://june29.jp/2010/12/17/glamorous-rubysappororecipe/">地獄のRuby札幌の「女に惚れさす逆引きレシピ集」 - 準二級.jp</a>を参考に御言葉のかわりに画像へのパーマリンクを取得しておいて返答するという方法もありだと思います。

このエントリを書きはじめたのは火曜日でしたが、前日の@kei-sさんがまさかのミサワネタ。「おいおい天丼なんてレベルじゃねーぞ」状態でも動じない。それが俺の流儀だ。

さて、ミサワ先輩以上に偉大なレシピ先輩ですが、@noplansさんに頂いてから「○○やるにはどうするんだっけ」と思ったらレシピ先輩に聞くようになりました。Rubyのコードを書くときは横に置いておきたい一冊です!ありがとうございます!