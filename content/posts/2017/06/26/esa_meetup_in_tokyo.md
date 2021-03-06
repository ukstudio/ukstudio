---
title: DIST.16 「esa meetup in Tokyo〜情報共有Night」で発表してきました
date: "2017-06-26T17:29:12+09:00"
---


6月23日に開催された、[DIST\.16 「esa meetup in Tokyo〜情報共有Night](https://dist.connpass.com/event/58048/)にて「サービス開発を加速させる情報共有」というタイトルで発表させて頂きました。

<script async class="speakerdeck-embed" data-id="acfcc545bb1b4fc2b9e58ab20cea25b2" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

弊社では色々なesaの使い方をしていて、例えば私のesaの使い方とマーケティングチームやカスタムサポートチームでの使い方が結構違ったりします。

今回、DISTの沖さんから「サービス開発」というテーマを頂いていたので、私が今メインで携わっている[STEERS](https://steers.jp/)の開発でのesaの活用事例について話をしました。

DISTのイベントは初参加でしたが、沖さんの進行が上手で最後までスムーズでとてもよかったです。

本編も懇親会もたくさんの参加者がいらっしゃってとても楽しいイベントでした。今回登壇の機会を頂けたことをありがたく思います。

# Tシャツを提供させて頂きました

STEERSからスピーカー様と参加者様のプレゼント用に10枚程度ですがTシャツを提供させて頂きました。

こちらSTEERSで購入可能ですので、よければお買い求めください。前回の名古屋でのTシャツも販売中です。

今後とも[STEERS](https://steers.jp/)をよろしくお願いいたします。

[【全品送料無料】esa meetup in Tokyo ~情報共有Night 記念Tシャツ \| オリジナルTシャツ販売 STEERS（ステアーズ）](https://steers.jp/c/esa-meetup-in-tokyo)

![](https://cdn-ak.f.st-hatena.com/images/fotolife/u/ukstudio/20170626/20170626162739.png)


[【全品送料無料】esa meetup in Nagoya @ Misoca \| オリジナルTシャツ販売 STEERS（ステアーズ）](https://steers.jp/c/esa-misoca)

![](https://cdn-ak.f.st-hatena.com/images/fotolife/u/ukstudio/20170626/20170626162800.png)

# 発表の補足

発表内容については資料を見ていただくとして、当日発表後や懇親会などで質問頂いたりしたのでその辺について少しまとめてみようと思います。

## 中間成果物として書いた仕様は全部ストック記事に整理していますか？

していません。というのも、大体のことはコードなりでサービスそのものに実装されているので、出来上がっているモノ自体が仕様になるためです。

どちらかというと資料に書いたとおり、調べようとしてサクッとわからなかったらという感じで必要になったときにまとめることが多いです。他にも誰かから（例えばステークホルダーとか）質問されたときにも記事にしたりしています。

## 中間成果物に書いた仕様と実装をあわせるの大変じゃないですか？

基本的に中間成果物として書かれた仕様は「とっかかり」ぐらいのものです。開発するためにお互いの認識をある程度揃えるためのスタート地点的ぐらいのつもりで書いています。

なので、実際に実装に入ってしまえばあとはチャットだったりプルリクエストでのやりとりだったりします。ちょっとぐらい認識のズレがあってもそこで実装を修正してしまう感じですね。

もしかしたら「仕様」という言葉でちょっと重たく捉えた方もいるかもしれませんが、ノリ的にはホワイトボードでちょっと情報を共有するのとあまり変わりません。

今のところそれであまり混乱も起きていませんが、中間成果物の仕様と実装の食い違いで混乱があった場合はある程度中間成果物の仕様も更新したりする必要もあるかもしれません。

## README使っていますか？

使っています。結構好きな機能ですね。カテゴリのREADMEはトップにあるREADMEより目立たないのがちょっと残念ですが、今のesaだとカテゴリをクリックしたときにそのカテゴリの記事一覧がでるので仕方ない気もします。

READMEには主にストック記事へのリンクをまとめています。どこどこのカテゴリにあるよというよりは、READMEにまとめてあるよの方がわかりやすいと思うので。

STEERSの場合だと、例えばTシャツの印刷位置・印刷サイズの大きさや、返品時の対応のルールといった業務上のことだったり、開発環境の構築といったような開発用ドキュメントへのリンクがはってあったりします。

他にもプロジェクトカテゴリの各施策で重たい施策ではREADMEを置いていたりします。施策の概要やチェックボックスで施策の進捗状況をメモしていたり、施策を進めるにあたって必要なドキュメントへのリンクや、打ち合わせなどで決まったことをまとめたりしています。
