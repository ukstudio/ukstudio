---
title: 「地味に便利なVim設定」をもうちょい地味に便利にする
---
<a href="http://blog.blueblack.net/item_317">地味に便利なVim設定 - ナレッジエース</a>

いくつかもうちょい便利にできるよーってところがあったので書いてみる。

<h2>スペース + wで保存</h2>
別に¥¥で保存でもいいと思うけど、ちょっと指が遠い気がする。ので僕はスペース + wで保存してる。同じ要領でquitも。
<pre lang="vim">
nnoremap <space>w :<c-u>write<cr>
nnoremap <space>q :<c-u>quit<cr>
</pre>

<h2>jとkでカーソルキーを中心に保ってスクロール</h2>
わざわざスペースを使わなくてもできる。gj、gkにしておくと表示行で上下に移動できるので折り返しの行があるときとかに便利。
<pre lang="vim">
nnoremap j gjzz
nnoremap k gkzz
</pre>

ちなみに僕のvimrcはgithubに公開してあるのでよかったら参考にどうぞ。そんな大したものでもないですが。

<a href="http://github.com/ukstudio/config/tree/master">.vimrc at master from ukstudio's config - GitHub</a>
