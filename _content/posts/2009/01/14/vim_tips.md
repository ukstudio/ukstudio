---
aliases:
- /2009/01/14/vim_tips
date: "2009-01-14"
title: 覚えとくと便利かもしれないVimのTips
---
適当に思い付いたものを書いてみる。

<h2>CTRL-X CTRL-L</h2>
行単位での補完。まぁ該当の行でyyしてpして貼り付けでもいいかもしれないけど、移動するの面倒な場合もあるし。

以下、自分のvimrcで「n CTRL-X CTRL-L」した例。

<a href="http://ukstudio.jp/wp-content/uploads/2009/01/c-xc-l.jpg"><img src="http://ukstudio.jp/wp-content/uploads/2009/01/c-xc-l.jpg" alt="" title="c-xc-l" width="300" height="234" class="alignnone size-medium wp-image-294" /></a>

ちなみに俺がこれを一番使うときはRSpecのdescribeの行を補完する時かな。こんな感じ。

<pre lang="ruby">
describe "hogehoge" do
end

desCTRL-X CTRL-L
↓
describe "hogehoge" do
</pre>

んで、hでちょこちょこっと"の中に移動してdi"で"の中を削除する感じ。

<h2>di"</h2>
こっそり上で登場してるけど"で囲まれた文字列をd(削除)する。da"だと"も含めて削除。ちなみにこれはテキストオブジェクトっていうVim7からの機能で他にも色々パターンがあって、個人的にVimの機能の中でも特別気に入っている。ちゃんと説明すると長いのでいくつか例だけ示す。

<dl>
<dt>di"</dt>
<dd>"の中を削除</dd>
<dt>da"</dt>
<dd>"も含めて削除</dd>
<dt>yi"</dt>
<dd>"の中をコピー</dd>
<dt>ya"</dt>
<dd>"も含めてコピー</dd>
<dt>di(</dt>
<dd>()の中を削除</dd>
<dt>da(</dt>
<dd>()も含めて削除</dd>
<dt>di{</dt>
<dd>{}の中を削除</dd>
<dt>da{</dt>
<dd>{}も含めて削除</dd>
</dl>

<h2>gf</h2>
カーソル以下のファイル名を開いてくれる。requireやinclude、ファイルをオープンしたりする処理のところで便利。

<pre lang="ruby">
require "hoge"
</pre>

hogeのところでgfするとhoge.rbを開く。

<h2>CTRL-AとCTRL-X</h2>
VimM#3でamachangが感動してた気がする。カーソル以下の数字をインクリメントとデクリメントしてくれる。ちゃんと1000とかも1001や999にしてくれるよ。マクロで多用するかも。

<h2>guuとgUUと~</h2>
guuはカーソル行の文字を全部小文字に、gUUは全部大文字に。~はカーソル以下の文字を小文字なら大文字に、大文字なら小文字に。

書いといてなんだけどあまり使った記憶ないな、これ。

<h2>:!</h2>
:!を使うと外部コマンドを叩くことができる。単体だと結果を返すだけなので頭に.(ドット)を付けて結果を挿入したりする。単体で使うときはlsの結果を見るときが多いかも。一々screenのウィンドウを移動しなくて済む。なんか段々書くのが面倒になってきたので例で示す。

<strong>追記</strong>: kanaさんより指摘がありました。挿入はr!〜ですね。

<blockquote>
> 単体だと結果を返すだけなので頭に.(ドット)を付けて結果を挿入したりする。
嘘。:{range}!{cmd}はフィルタリング。結果的にそうなるケースはあるけれど意味は違う。本当に挿入するなら:r!{cmd} (:read !{cmd})。
</blockquote>
<dl>
<dt>:!ls ~</dt>
<dd>ls ~の結果が表示される</dd>
<dt>:.!date </dt>
<dd>date結果が挿入される</dd>
<dt>:%!sort</dt>
<dd>今開いてるファイルをsortした結果に書き変わる</dd>
<dt>:%!grep hoge</dt>
<dd>hogeが含む行だけに書き変わる</dd>
<dt>:!ruby -c %</dt>
<dd>今開いてるファイルをrubyの構文チェックに通す。PHPとかでも似たようなことができる</dd>
</dl>