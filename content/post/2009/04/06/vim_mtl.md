---
title: Vim勉強会 in MTLで話してきました
date: 2009-04-06
---
<a href="http://atnd.org/events/482">Vim勉強会 in MTL : ATND</a>
当日の<a href="http://www.lingr.com/room/vim_mtl/archives/2009/04/03">Lingrのログ</a>と<a href="http://www.flickr.com/photos/iandeth/sets/72157616306681532/">写真</a>と<a href="http://www.ustream.tv/channel/vimmtl20090403">録画</a>

録画はあまり質に期待しないでとのこと(見てない)

<h2>便利なVimスクリプトやTips紹介 id:iandeth</h2>
タイトル通り便利なTipsの紹介。個人的には今回の勉強会に参加してくれた人達を見ると、これぐらいの内容が丁度よかったのかなーって思う。おれのはちょっと調子に乗りすぎたw

<h2><de>Vim捌きを上達させる、たったひとつの冴えたやり方</del>至高のエディタには、至高のキーボード id:ursm</h2>
Vim勉強会なのにVimの話を一切しないという荒技。4万円ぐらいのキーボードの営業してました。フットペダル欲しいです。

<h2>Vim Script DE OOP id:ukstudio</h2>
とりあえず<a href="http://www.slideshare.net/ukstudio/vim-de-oop">資料</a>

完全に参加者置いてけぼりの発表内容でした。まぁネタだからいいんです。Vim ScriptでOOPはネタです。

Vim Scriptは名前空間とスクリプトローカルなスコープとかがあるのである程度規模が大きくてもなんとかなるので、無理矢理OOPする必要ないです。

if_rubyもOOPできるというよりはVim Scriptヨクワカラナイヨーな人が気軽にスクリプト書きたい時にちょこちょこっと使うってのが多いんじゃないですかね。if_rubyのプラグインってほとんどみないいし。ujihisaのmixi.vimだっけ、そこらへんの連投スクリプトぐらい。

今回のはどっちかというと僕個人がおれおれOOPというかそゆのをVim Scriptで作るのが楽しかったという理由だけでこの内容をチョイスしました。 ちなみにVim Scriptはスコープや可変長引数の文法がパッと見わかりづらいですけど、慣れればそんな難しい言語ではないですよ。一度挑戦してみるといいと思います。

<h2>懇親会</h2>
懇親会ではピザを食べながら適当に談笑しつつ、Rails.vimやオススメのプラグイン教えてと言われたので適当にプロジェクタ使って話してました。以下プラグインのリスト。

<h3><a href="http://www.vim.org/scripts/script.php?script_id=1567">Rails.vim</a></h3>
VimでRails開発するなら必須です。最初はとりあえず:Rcontroller, :Rmodel, :Rviewとgf、:Rpartialあたり使っておけばいいんじゃないでしょうか。

<h3><a href="http://www.vim.org/scripts/script.php?script_id=294">Align.vim</a></h3>
整形したいコードをヴィジュアルモードなどで選択して,t=とかやると=でキレイに並べてくれます。コードの整形にこだわりのある人へ。

:[Range]Align=>とかやると複数の文字(この例だと=>)で整形できます。これはid:ursmさんに教えてもらいました。

<h3><a href="http://www.vim.org/scripts/script.php?script_id=2290">smartchr.vim</a></h3>
id:haltさんの記事を読むといいと思います。

<a href="http://project-p.jp/halt/anubis/blog_show/1068">smartchrというvim pluginが簡単便利で目ウロコ - /halt/Snapshot</a>

<h3><a href="http://www.vim.org/scripts/script.php?script_id=1984">fuzzyfinder.vim</a></h3>
バッファで開いてるファイルとか最近使ったファイルとかを開くのに便利です。コマンド呼び出すのは面倒なので適当にマッピングして使いましょう。

<blockquote>
nmap fb :FuzzyFinderBuffer<cr>
nmap ff :FuzzyFinderFile<cr>
nmap fm :FuzzyFinderMruFile<cr>
</blockquote>

これtaku-oさんの<a href="http://d.hatena.ne.jp/taku-o/20090404/1238829761">指摘</a>で気づきましたけど、fがもろに被ってますね。よい子は他のキーにマッピングしましょう。

<h3><a href="http://github.com/Shougo/neocomplcache/blob/master/presen/neocomplcache.txt">neocomplecache.vim</a></h3>
autocomplpop.vim的な補完プラグインです。詳細はとりあえずリンク先を見ればいいと思います。

<a href="http://www.lingr.com/room/vim-users.jp">vim-users.jpのlingr</a>に作者がいるので興味がある人、物申したい人は来たらいいんじゃないでしょうか。


<h2>永和システムマネジメント及びMTLの皆様に感謝</h2>
今回はちょっとしたことがきっかけで勉強会を行うことになったわけですが、永和システムマネジメントの角谷さん、MTLの石橋さん、小林さん他、このような場を提供して頂きありがとうございました!

また、ATNDを見る限り50人弱の人に参加して頂いたようなのですが、お忙しいところありがとうございました。

またどこか別の機会がありましたらよろしくお願いします。

追記: 永和システムマネジメントを永和マネージメントシステムと誤表記していました。ごめんなさい。