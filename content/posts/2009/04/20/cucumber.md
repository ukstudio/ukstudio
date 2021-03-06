---
aliases:
- /2009/04/20/cucumber
date: "2009-04-20"
title: Cucumberの登場でRailsのテスティング環境が変わった
---
ちょっと大げさなタイトルかもしれないですが、個人的にはそれぐらいの感動。「これで勝つる!」な気分。何に勝つのか知らないけれど。

今までのRailsのテストはもっぱらRSpecで書いてて、確かにこれはこれで素晴らしい。採用当初はバグが減ってその時も「これで勝つる!」な気分でした。でもやっぱり受け入れテストがネックになるんですよね。Seleniumとかも使ったりしてましたけど、ブラウザががちゃがちゃ動くし、なんとなく面倒で結局手動で確認という感じになってしまいました。

そこでCucumberの登場ですよ。個人的に素晴しいと思うのは

<ul>
<li>テストケースが自然文(っぽい)</li>
<li>そんなに邪魔じゃない</li>
</ul>

あたりかなぁ。テストケースが自然文っぽいというのは実はかなり大事で例えば

<blockquote>
お客さん: まずトップページにアクセスするとログインフォームがあって、そこにログインすると「ようこそ!ほげほげさん」と出すようにして欲しい
</blockquote>

っていう要望、つまりユーザーストーリがあった場合に割とそのままシナリオとしてテストに変換できる。

<pre lang='ruby'>
もし トップページ にアクセス
かつ メールアドレス に hogehoge@hoge.com と入力
かつ パスワード に hogehoge と入力
かつ ログイン ボタンを押す

ならば ようこそ!ほげほげさん と表示されること
</pre>

これは疑似言語とかじゃなくて、これがそのままテストとして実行できる。つまり今までこっちがブラウザをポチポチしてお客さんに「できましたー(多分)」と報告していて、お客さんからすると何をどうテストしていたのかが曖昧という問題があったのだけれど、 Cucumberだと<strong>お客さんと一緒に受け入れテストを作ることができて、そのテストケースもお客さんが読むことができる</strong>から曖昧さが消えて安心が生まれる。

もちろん開発者にもメリットはあって、Cucumberはユーザ視点レベルのテストだからテストとしては一番外側なテストでここのテストがちゃんと通っていれば、アプリケーションの動作がユーザ視点での正しく動くという保証ができるわけです。

その保証ができるとどうなるかと言うと、極端な話、ユーザ視点での動作が正しければ内部の動作なんて割とどうでもいいわけで、内部に自由がでてきます。内部に自由がでてくると、コードの修正や設計の変更が怖くなくなり、リファクタリングがしやすくなります。結果、メンテのしやすいアプリが出来上がります。

Cucumberは残念なことに、Ajaxのテストができないのでその辺りはSeleniumや手動での確認、あとはjsonやxmlを吐き出すアクションをRspecでテストするなど臨機応変に対応する必要がありそうです。

最後にオマケですが、僕が実際にCucumberを使ったときの開発の流れをば。

<ul>
<li>Cucumberのシナリオを書く</li>
<li>Rspecでモデルのテストを書く</li>
<li>モデルにロジックを書く</li>
<li>Rspecでコントローラとビューのテストを書く</li>
<li>コントーラとビューを書く</li>
<li>Cucumberのテストが通ったのを確認して、実際に手動でも確認する</li>
<li>それぞれのテストをautotestとかでまわしながらリファクタリング</li>
</ul>

まず最初にCucumberのシナリオを書きます。仕様のブレを防ぐためです。この時点では当然Cucumberのテストは通りませんが、とりあえずモデルからビューにかけてボトムアップでコードを書きます。基本的にテストファーストです。

ビューまで書いたらこの時点でCucumberのテストが通っていれば手動で確認、通っていなければ同じ要領でテストファーストでコードを書きます。

最後に今まで書いたテストが落ちないようにリファクタリングを行います。ここまでで1つのユーザストーリ(Cucumberでいうフィーチャ)の実装が完了します。

CucumberはRspecの時もそうでしたが、新しく導入するときにどうしてもコストがかかります。でも慣れてくればそのコストは大分減りますし、stepもある程度使いまわせるものが多いので長期的に見れば逆にコストが減ると思っています。個人的にはCucumberを採用しない理由はないと思うので、この記事を読んでいる人も是非試してみてください。