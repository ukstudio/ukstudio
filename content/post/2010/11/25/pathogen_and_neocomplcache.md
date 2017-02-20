---
title: pathogen.vimとneocomplcache.vimのスニペット機能
date: 2010-11-25
aliases:
- /2010/11/25/pathogen_and_neocomplcache
---
vimの環境を少し整理した。

<h2>pathogen.vimを使うことにした</h2>
<a href="https://github.com/tpope/vim-pathogen">tpope&apos;s vim-pathogen at master - GitHub</a>

我らがtpope先生のプラグイン、pathogen.vimを使ってプラグインを管理するようにした。.vim/bundleにあるプラグインに対してruntimepathを追加してくれるので、今まで.vim以下のautoloadやpluginsとかにバラバラになってたプラグインを1つにまとめたまま管理できる。

1つにまとめられると、githubとかにあるプラグインはgitのsubmoduleで扱うことが出来るので便利。特にgithubにあがってるようなプラグインは更新が速いものが多いのでなおさら便利(unite.vimとか)。これで主要なプラグインの更新はgit submodule updateで済む。

ちなみに今のディレクトリ構成はこんな感じ。
<a href="https://github.com/ukstudio/config/tree/master/.vim/bundle/">.vim/bundle at master from ukstudio&apos;s config - GitHub</a>

ちなみにこういうことをしていて、プラグインの自動更新とかがデフォルトでないvimもいい加減レガシーな環境だよなぁと思うのであった。

<h2>neocomplcache.vimのsnippets機能を使いはじめた</h2>
何となくなじめなかったsnippets機能だけど、neocomplcacheにいつのまにか実装されてたので試すことにした。とりあえず、rspecまわりをいくつか追加したけど思いの他便利である。補完で候補がでてくるのとsnippetsの編集がラクなのがとてもいい。

<a href="https://github.com/ukstudio/config/blob/master/.vim/snippets/rspec.snip">.vim/snippets/rspec.snip at master from ukstudio&apos;s config - GitHub</a>