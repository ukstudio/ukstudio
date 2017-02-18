---
title: Better Subversionとしてのgit-svn
---
普段のプログラミングにgitを使用しているのだけど、実際の現場ではまだまだsvnが主流だったりする。svnを直接使ってもいいのだけど、やはりローカル上でコミットしたいとか、複数のコミットを1つにまとめたいとか、トピックブランチを切りたいとかあるのでそれはsvn単体だと厳しい。そんなわけでBetter SVNとしてのgit svnの紹介、と言うよりメモ。

<h2>リポジトリのクローン</h2>
<code><pre>git svn clone repository_url</pre></code>
これでsvnリポジトリをgitリポジトリとして取得できる。大きめのリポジトリだと結構時間がかかるのでのんびりと。svnリポジトリの構成がtrunk/branches/tagsという一般的な構成であればオプション-を付けるのがおすすめ。trunkをmaster、branches/tagsをremote branchとして扱うようになる。個別に指定する方法もあるのでhelp参照。
<code><pre>git svn clone -s repository_url</pre></code>

<h2>リポジトリの更新</h2>
<code><pre>git svn rebase</pre></code>
svn upに相当する。remote brancheのtrunkをgit coしてそれをmergeする方法もあるけど、基本はこれで問題ない。

<h2>リポジトリへのコミット</h2>
<code><pre>git svn dcommit</pre></code>
これはsvn ciに相当するって言うと、少し違う気もするのだけどsvnリポジトリにコミットするっていう意味だと同じ。git pushの方がイメージに近い。ローカルにたまっているコミットをsvnリポジトリにpushする感じ。ローカルにコミットされていない変更があるとdcommitできないので、その時はgit stashする。
<code><pre>git stash
git svn dcommit
git pop
</pre></code>

<h2>ブランチの作成</h2>
<code><pre>git svn branch name</pre></code>
trunk-masterでやり取りするだけだったら、上記さえ覚えておけば後は普通のgitリポジトリと同じ。gitのブランチを作るのは通常のgitリポジトリと同じだけど、svnのブランチを作るにはこのコマンドを叩く。この時点でsvnリポジトリにコミットされるので注意(--dry-runオプションはある)。-mオプションでコミットメッセージを書ける。指定しない場合は「Create branch name」となる。

svnリポジトリの別のブランチや、ローカルのgitリポジトリのブランチから新しくブランチを作る場合には後ろに名前を指定する。
<code><pre>git svn branch name remotes/branch
git svn branch name local_branch</pre></code>

<h2>ブランチのチェックアウト</h2>
<code><pre>git co -b branch remotes/branch</pre></code>
svn switchに相当。git svnはsvnのbranches/tagsをremote branchとして扱うのでそれをgit coすればいい。これは上記のgit svn branchで作成したものも同じ。

<h2>ブランチ間のマージ</h2>
<code><pre>git merge --no-ff branch_name
git svn dcommit</pre></code>
マージは通常のgitとほぼ同じ。注意しなくてはいけないのは--no-ffが必要なこと(参考: <a href='http://webtech-walker.com/archive/2010/03/26101332.html'>http://webtech-walker.com/archive/2010/03/26101332.html</a>)。

<h2>ブランチの削除</h2>
<code><pre>svn rm branches/name #svnリポジトリをcoしてそこで
git branch -r -d name #git-svnのgitリポジトリ上で</pre></code>
現時点(v1.7.0.6)ではsvnリポジトリのブランチを削除するコマンドは用意されていない模様。なので直接svn上でブランチを消して、git側のremote branchも直接消すしかないと思う。

<h2>どのブランチにコミットされるのか</h2>
<code><pre>git svn info</pre></code>
もしかしたら、今いるgitリポジトリのブランチでgit svn dcommitしたらsvnリポジトリのどのブランチにコミットされるのかがわからなくなることもあるかもしれない。その時はgit svn infoで表示されるURLをみればよい。

<h2>ignoreの設定</h2>
<code><pre>git svn create-ignore</pre></code>
ignoreは少しややこしいんだけど、svn側とgit側の2つ存在する。このコマンドはsvn側のignore設定を.gitignoreとして出力する。ちなみにsvn側のみignore設定してある場合、当然git側ではignoreされずgit svn dcommit出来てしまう。その場合、svn側のignoreも無視して通常通りコミットされてしまうので注意。

<h2>まとめ</h2>
git-svnでの開発はsvnの面倒なところをカバーしてくれたりするので非常にオススメ。もちろん全てがgit-svnで出来るわけでもないので、その辺は諦めて直接svnを使う必要もある。ある意味、最悪わからなくなったらいつでもsvnに戻ればいいのでとりあえず試してみるといいと思う。

ちなみにgitに詳しくない人は濱野さんの入門Gitがおすすめです。

<iframe src="http://rcm-jp.amazon.co.jp/e/cm?lt1=_blank&bc1=000000&IS2=1&bg1=FFFFFF&fc1=000000&lc1=0000FF&t=ukstudio0c-22&o=9&p=8&l=as1&m=amazon&f=ifr&md=1X69VDGQCMF7Z30FM082&asins=4798023809" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>

