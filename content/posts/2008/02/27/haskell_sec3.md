---
aliases:
- /2008/02/27/haskell_sec3
date: "2008-02-27"
title: ふつケル第3章
---
<h2>型と値</h2>
Haskellには<strong>型推論</strong>という機能がある。型推論は処理系の方で型を推測し、<strong>矛盾なく全ての式が型づけできればコンパイル時にエラーにはならない</strong>。Haskell以外にも、OCaml、Scala、MLなど静的型付け関数型言語のほとんどが型推論の機能を供えている。

Haskellの型には、<strong>Int(整数値)、Char(文字)、String(文字列)、Bool(真偽値)</strong>がある。Intは最低30ビット幅の符号付き整数値を意味する。CharやStringで扱う文字(列)のエンコードにはUnicodeを採用しているが、GHCの実装は中途半端で入出力でのエンコーディング変換などが実装されていない。

また、Int型のリスト、Char型のリストと言う風にリストの型を表現し、Int型のリストの各要素はInt型になる。<strong>ソースコード上では[Int]や[Char]と書く</strong>。文字列は文字のリストなので[Char]ということになり、別名として上記したString型が用意されている。

関数の型をは引数の型と返り値の型を組合せて表現する。例えば、<strong>String -> [String]というのは第1引数の型がString(文字列)で、返り値の型が[String](文字列のリスト)となる</strong>。

<pre lang="haskell">
第1引数の型 -> 第2引数の型 -> ・・・ -> 返り値の型
</pre>

では、引数の型が決まっていない場合どうするのかと言うと、<strong>型変数</strong>と言うものを使う。型変数はアルファベット小文字であらわし、アルファベット小文字の部分は好きな型に読み替えてよい。

<pre lang="haskell">
[a] -> Int
Int -> [a] -> [a]
</pre>

上記の場合だと、1行目は任意の型のリストを引数にもち、Intを返す関数。2行目はIntを第1引数、任意の型のリストを第2引数にもち、第2引数と同じ型のリストを返す関数という意味になる。

<strong>関数の型を宣言</strong>するには、先程関数の型を表現したものに少し付け足せばいい。Haskellは型推論の機能をもつので必ずしも型の宣言が必要というわけではないが、なるべく宣言しておくのが好ましい。

<pre lang="haskell">
関数名 :: 第1引数の型 -> 第2引数の型 -> ・・・ -> 返り値の型
</pre>

<h2>高階関数</h2>
高階関数とは<strong>引数に関数をとる関数</strong>のこと。

<pre lang="haskell">
main = do cs < - getContents
          putStr $ expand cs

expand :: String -> string
expand cs = map translate cs

translate :: Char -> Char
translate c = if c == '\t' then '@' else c
</pre>

このプログラムでは5行目で高階関数のmap関数が使われている。map translate csと言うのは、<strong>translate関数そのものにmapを適用しているのであって、translateの結果にmapを適用しているわけではない</strong>。

mapの型は
<pre lang="haskell">
map :: (a -> b) -> [a] -> [b]
</pre>
となっており、<strong>(a -> b)は「a型の値を引数にとりb型の値を返す関数」</strong>を意味する。今回の場合だと、translate関数の型が Char -> Char となっているので、「Char型の値を引数にとりChar型の値を返す関数」と読み替えることができる。更にいうと(a -> b) -> [a] -> [b] は (Char -> Char) -> [Char] -> [Char]となる。

<pre lang="haskell">
main = do cs < - getContents
          putStr $ expand cs

expand :: String -> String
expand cs = concat $ map expandTab cs

expandTab :: Char -> String
expandTab c = if c == '\t' then "        " else [c]
</pre>

この辺はちょっとややこしくなってくるが、ちゃんと順に考えていけば問題ない。

<h2>パターンマッチ(1)</h2>

<pre lang="haskell">
tabStop = 8

main = do cs < - getContents
          putStr $ expand cs

expand :: String -> String
expand cs = concatMap expandTab cs

expandTab :: Char -> String
expandTab '\t' = replicate tabStop ' '
expandTab c = [c]
</pre>

個人的にtabStopがグローバル変数みたいでなんか気持ち悪い。定数と考えればいいのかな。まぁ今はとりあえず置いておこう。

今回のプログラムの最後2行で<strong>パターンマッチ</strong>を使用している。下から2行目が引数が「\t」の時に使われる定義。最後の行は仮引数が使われているので、「どんな値」にもマッチする。<strong>パターンマッチは上に書いたものが優先され、マッチするパターンが無い場合には実行時にエラーが発生する</strong>。

<pre lang="haskell">
関数名 第1引数のパターン 第2引数のパターン ・・・・ = 定義1
関数名 第1引数のパターン 第2引数のパターン ・・・・ = 定義2
関数名 第1引数のパターン 第2引数のパターン ・・・・ = 定義3
</pre>

<h2>パターンマッチ(2)</h2>
<pre lang="haskell">
map :: (a -> b) -> [a] -> [b]
map f []     = []
map f (x:xs) = f x : map f xs
</pre>

2行目のパターンマッチは空リストに一致する。つまりmapの第2引数が[]だった場合、必ず[]を返すと言うことになる。

3行目の(x:xs)もリストに対するパターンで、空リスト以外のリストにマッチする。<strong>リストの最初の要素がxに束縛され、残りの要素がxsに束縛される</strong>。まぁSchemeのcarやcdrみたいなものかな。

3行目での定義ではまたさらにmapを適用している。つまり、<strong>再帰を用いて処理している</strong>。Haskellには<strong>ループを扱う構文は存在しない</strong>為である。

<pre lang="haskell">
map length ["abc", "de", "f"]
  length "abc" : map length ["de", "f"]
    length "de" : map length ["f"]
      length "f" : map length []
      (1 : [])
    (2 : [1])
  (3:[2,1])
[3, 2, 1]
</pre>

例えば「map length ["abc", "de", "f"」だと多分こんな感じ。<strong>「:」演算子はリストを生成する演算子で(y:ys)ならリストysの先頭に要素yを追加する</strong>。

<h2>練習問題</h2>
<pre lang="haskell">
main = do cs < - getContents
          putStr $ swapa cs

swapa :: String -> String
swapa cs = map replaceA cs

replaceA :: Char -> Char
replaceA 'a' = 'A'
replaceA 'A' = 'a'
replaceA c = c
</pre>

とりあえず動く。

<h2>追記(08/02/27)</h2>
<pre lang="haskell">
main = do cs < - getContents
          putStr $ map swapa cs

swapa :: Char -> Char
swapa 'a' = 'A'
swapa 'A' = 'a'
swapa c = c
</pre>

書き直した。この方が短い。