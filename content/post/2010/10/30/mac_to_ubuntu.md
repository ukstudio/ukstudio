---
title: MacからUbuntuに乗り換えた
---
最近メインで使っているMacBookが調子悪かったので新しいマシンを買うことにした。元々、Core i7&メモリ8GBでMacBook Proの15インチを買うつもりだったけど、Lenovoが18周年記念でThinkPadが安かったので以前から考えていたLinuxマシンに手を出すことにした。

<h2>X201sをCore i7&メモリ8GBで</h2>
基本的にほぼ毎日パソコンを持ち歩くので比較的重さが軽めのX201sを選択。CPUとメモリは元々予定してたi7と8GBを選択。HDDとSSDで迷ったけど、500GB HDDから128GB SSDへの変更で +6万円だったのでSSDは自分で換装することにしとりあえずはHDDを選択。キーボードは当然英字配列。

X201sが届いて最初にやったことは電源を入れることではなく、SSDへの換装。HDDを引っこぬいてSSDを挿すだけだったのですぐに終了。ちなみに使用したSSDはまわりに聞いて評価の高かった<a href='http://amzn.to/byjKi8'>Intel SSD 160GB SATA 2.5 SSDSA2MH160G2C1</a>。Ubuntuは10.10の日本語RemixをCDに焼いてそれでインストール。

<h2>立ち上がりの速さに感動</h2>
起動して最初に思ったのが、立ち上がりの速さ。ログインするまでが本当に速い。普段起動時間が長いのを嫌ってノートPCの電源は基本的に落さないタイプだけどこれならちゃんと電源落してもいいかなと思える。Firefoxも待ち時間がほとんどなく立ち上がる。素晴しい。

<h2>セットアップ</h2>
とりあえずキーボードレイアウトからCapsLockをCtrlにする設定をした。次にSKKを使うためにuim-skkをaptitudeでインストール。Sands(Space長押しでShiftにするやつ)は結構設定がめんどうな感じだったのでとりあえず諦め。

ChromeやCompiz、xchat、Sylpheedなど必要そうなものをインストール。Chromeは同期機能のおかげでMacの方のChromeから特別なにもしなくてもほとんど移行できた。Compizは余計なアニメーションとかさせなければ結構便利。

IRCはxchatをとりあえずインストール。@ursmさんから<a href='http://quassel-irc.org/'>quassel</a>という奴をおすすめされたけど使い方がよくわからないのでとりあえず保留。おもしろそうな感じはするのでそのうちゆっくり試してみよう。

EvernoteはUbuntu用のアプリケーションがないのでNevernoteやWine上でWindowsのEvernoteを動かしてみたけど日本語が文字化けして使い物にならないのでとりあえずWebで我慢。

後は開発ツールまわりをインストール。vim、rvm、MySQL、screen(git://git.savannah.gnu.org/screen.git)、zshあたりをインストール。なんちゃらrc系全部githubに置いてあるのでこの辺りもさくっと移行完了。

<h2>まとめ</h2>
なによりUbuntu + SSDは本当に快適で素晴しい。これだけでも買い替えてよかったと思える。Linuxはデスクトップマシンとして使うのは初めてだけど、Ubuntuは一昔前じゃ考えられないぐらい洗練されていて何も不自由を感じない。プリンタなどのハードウェアまわりで不安がないわけじゃないけれど、とりあえずは何とかなるだろう。

参考にしたところ
<ul>
<li><a href='http://gihyo.jp/admin/serial/01/ubuntu-recipe'>連載：Ubuntu Weekly Recipe｜gihyo.jp … 技術評論社</a></li>
<li><a href='http://d.hatena.ne.jp/voidy21/20091127/1259345628'>キーボード派におすすめするLinuxのCompiz設定 - Secret Sword!!!</a></li>
<li><a href='http://nippondanji.blogspot.com/2010/08/blog-post.html'>漢(オトコ)のコンピュータ道: ラップトップ購入!OSは・・・</a></li>
