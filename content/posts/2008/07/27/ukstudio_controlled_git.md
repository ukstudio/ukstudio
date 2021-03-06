---
aliases:
- /2008/07/27/ukstudio_controlled_git
date: "2008-07-27"
title: ukstudio.jpをgitで管理するようにしてみた
---
最近流行りのgitを使ってみようかなーってことでとりあえずukstudio.jpを全部gitで管理するようにした。

最終的に以下のような構成になった。

<a href="http://ukstudio.jp/wp-content/uploads/2008/07/git-ukstudio.png"><img src="http://ukstudio.jp/wp-content/uploads/2008/07/git-ukstudio.png" alt="" title="git-ukstudio" width="284" height="284" class="alignnone size-medium wp-image-145" /></a>

<h2>MacBookにgitをインストールする</h2>
MacBookにgitをインストールするのは簡単だった。MacPortsですんなり入った。

参考: <a href="http://d.hatena.ne.jp/from_kyushu/20080414/git_on_mac">MacPortsを使ってgitをインストールしてみた - Post-itみたいな</a>

<h2>サーバにgitをインストールする</h2>
サーバはslicehostのCentOS5.1を使用。インストールされてるsvnが1.4なのでこちらは一旦remove。

<pre lang="bash">
$ yum remove subversion
</pre>

gitはyumの標準リポジトリでは管理されてないので、外部リポジトリ(<a href="http://dag.wieers.com/rpm/">DAG</a>)を登録してそこからインストールした。

<pre lang="bash">
$ wget http://dag.wieers.com/packages/rpmforge-release/rpmforge-release-$0.3.6-1.el5.rf.i386.rpm
$ rpm -ivh rpmforge-release-0.3.6-1.el5.rf.i386.rpm
$ yum install git
</pre>

<h2>リポジトリを作る</h2>
とりあえずコミットする人の名前とメールアドレスを登録しないといけないらしいので登録。これはサーバの方も同じ。

<pre lang="bash">
$ git config --global user.email yuki.0w0[at]gmail.com
$ git config --global user.name YukiAkamatsu
</pre>

次にローカルのファイル群をcommitする。
<pre lang="bash">
$ cd ~/ukstudio.jp
$ git init
$ git add .
$ git commit -m "first commit"
</pre>

この状態だとまだローカル内での変更のみ。なので、この変更をサーバ側で受け取れるようにする。

<pre lang="bash">
# ukstudio.jpにログインした状態
[ukstudio.jp]$ mkdir /var/git/ukstudio.jp
[ukstudio.jp]$ cd /var/git/ukstudio.jp
[ukstudio.jp]$ git init-db
</pre>

んで、またローカルに戻ってさっきcommitしたのをpushして反映させる。

<pre lang="bash">
$ git remote add ukstudio.jp ssh://ukstudio@ukstudio.jp/var/git/ukstudio.jp
$ git push ukstudio.jp ukstudio.jp master
</pre>

最後に外部から見れるように配置する。

<pre lang="bash">
# ukstudio.jp
[ukstudio.jp]$ cd /var/www/vhost/
[ukstudio.jp]$ git clone /var/git/ukstudio.jp
</pre>

これで/var/www/vhost/ukstudio.jpが作成されて、そこにずらーっとファイルができてるはず。とりあえずこれでukstudio.jpをgitで管理できるようになった。(と思う)

<h2>ローカルで変更を加えてみる</h2>
本当にうまく管理できているのか、適当なファイルを作って確かめてみたいと思う。

<pre lang="bash">
$ cd ~/ukstudio.jp
$ touch hoge.txt
$ git add hoge.txt
$ git commit -m "commit test"
$ git push ukstudio.jp master

#ukstudio.jp
[ukstudio.jp]$ cd ~/var/www/vhost/ukstudio.jp
[ukstudio.jp]$ git pull
</pre>

これでhoge.txtがあれば、うまく管理できてることになると思う。

そんな感じで、とりあえずしばらくはgitを使ってみようかなーと思う。「git log -p」とやるとコミットログがdiff付きでみれて便利。

<h3>参考</h3>
<a href="http://www8.atwiki.jp/git_jp/pub/Documentation.ja/user-manual.html">Git ユーザマニュアル(1.5.3以降)</a>
<a href="http://www8.atwiki.jp/git_jp/pub/Documentation.ja/tutorial.html">Gitチュートリアル(1.5.1以降)</a>
<a href="http://www.nofuture.tv/index.rb?GitMemo">Gitメモ</a>
<a href="http://blog.champierre.com/archives/670">せっかちな人のためのgit入門</a>
<a href="http://www.kaeruspoon.net/articles/477">バージョン管理をsubversionからgitに移行してみた</a>

<h2>SSHについて補足</h2>
サーバへのSSH接続は鍵認証でやっています。秘密鍵を~/.ssh/id_dsa_ukstudio.jpで保存して、~/.ssh/configに以下のように書いています。

<pre lang="bash">
Host ukstudio.jp
IdentityFile ~/.ssh/id_dsa_ukstudio.jp
Protocol 2,1
</pre>