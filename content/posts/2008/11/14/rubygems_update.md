---
title: RubyGemsのupdateの方法が変わっていた
date: 2008-11-14
aliases:
- /2008/11/14/rubygems_update
---
せっかくMerb1.0がでたことだしインストールしてみようかと思ったら、gemを1.3以上いれやがれ!と怒られてしまった。それならアップデートするかーと思い、update --systemをやってsuccessと出たはいいけど、gem -vで1.2と表示される。MacPortsの方でアップデートして、1.3入れても-vは1.2でなんぞーとか思っていたらupdateの方法が変わってたみたい。

以下、update手順。

<ol>
<li><a href="http://rubyforge.org/frs/?group_id=126&release_id=16500">RubyForge</a>からrubygems-upate-1.3.1.gemをダウンロード</li>
<li><pre lang="bash">$ sudo gem install rubygems-update-1.3.1.gem</pre></li>
<li>update_rubygemsというコマンドができてるので実行。
<pre lang="bash">$ sudo update_rubygems</pre></li>
<li>完了</li>
</ol>

これで無事、RubyGemsの1.3.1がインストールされた。

<pre lang="bash">
$ gem -v
1.3.1
</pre>

<pre lang="bash">
$ sudo gem install merb
・・・
・・・
37 gems installed
</pre>

これでOK。37gems installedってのも凄いな。