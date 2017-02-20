---
title: duostackでnode.jsアプリを動かすまで
date: 2011-05-10
aliases:
- /2011/05/10/duostack_nodejs
---
<h2>node.jsのインストール</h2>
何はともあれnode.jsのインストール。aptではなくgithubからリポジトリをcloneしてmakeした。最近はapt以外のものは$HOME/localに入れるルールでやってるのでnode.jsも同様に。node.jsをsudoで入れると結構ハマるみたいな話を聞くので特に理由がなければaptとかで入れるか$HOME以下に入れるのがよさそう。

<pre>$ git clone git://github.com/joyent/node.git
$ cd node
$ ./configure --prefix=$HOME/local
$ make
$ make install
$ which node
/home/ukstuido/local/bin/node</pre>

<h2>npmのインストール</h2>
duostackを使うのにnpmが必要なのでnpmもインストール。curl使う方じゃなくてmakeしてインストールした。curl ... | sh の形式があまり好きじゃない程度の理由。

<pre>$ git clone git://github.com/isaacs/npm.git
$ cd npm
$ make install
$ which npm
/home/ukstudio/local/bin/npm</pre>

npmがインストールされる場所は特に指定しなくても$HOME/localに入った。node.jsの位置でも見てるんだろうか。よくわからない。

<h2>duostackのインストール</h2>
あらかじめ、<a href="https://www.duostack.com/">Duostack</a>のアカウントは取っておくこと。結構すぐ登録確認メールが来る。

duostackのインストールは-gオプションを付けないとnode_modulesディレクトリがカレントディレクトリに出来る。最初-gオプションを知らなくて困惑した。

<pre>$ npm install -g duostack
$ which duostack
/home/ukstudio/local/bin/duostack</pre>


<h2>アプリの作成とデプロイ</h2>
ここまで来ると<a href="http://docs.duostack.com/node/quick-start-guide#create-a-new-node-app">Duostack · Docs: Quick Start Guide</a>に従うだけでOK。

適当なディレクトリを作ってそこにserver.jsを置く。

<pre>$ mkdir sample
$ cd sample
$ vim server.js</pre>
<script src="http://gist.github.com/963569.js?file=gistfile1.js"></script>

git initしてやる。

<pre>$ git init
$ git add .
$ git commit -m 'init'</pre>

duostackコマンドでアプリケーションを登録。ここで指定したアプリ名がそのままドメインになる。

<pre>$ duostack create ukstudio
$ git push duostack master</pre>

無事にpushできればURLが表示されているはずなのでブラウザで確認する。今回の例だと<a href = "http://ukstudio.duostack.net/">http://ukstudio.duostack.net/</a>になる。

こんな感じでduostackでnode.jsアプリを動かすところまで試してみた。herokuとかもそうだけど、こうサクッとアプリが動かせる環境があるのはうれしい。

次はnode.js + CoffeeScriptとか、もうちょっとアプリらしいアプリを作ってみようかな。

<h2>追記: duostackでCoffeeScriptを動かす</h2>
CoffeeScriptからコンパイルしたJavaScriptを乗せるんじゃなくて、CoffeeScriptそのものを乗せる方法。server.jsは必要っぽいのでそこからrequireする形にした。CoffeeScriptはアプリの中にインストールしておく。 これで一応動くことは動く。

<pre>$ npm install coffee-script</pre>

<script src="https://gist.github.com/964149.js"> </script>