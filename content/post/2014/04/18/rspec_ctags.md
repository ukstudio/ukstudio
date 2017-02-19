---
title: Vim(TagBar)でRSpecのctagsを扱う

tags: rspec,vim
date: 2014-04-18
---

![rspec ctags](/images/2014-04-18-vim-rspec-ctags.png)

unite-outlineとかを使う人には不要なのかもしれないけど、あいにくuniteユーザではないのでctagsでなんとかできないか調べてみた。

まず、Funtooで入るctagsではrspecのタグは生成できないのでforkされたctagsを使う必要がある。

[fishman/ctags](https://github.com/fishman/ctags)

インストール場所はお好みで。個人的には手で入れる系のものは$HOME/localにインストールするのが好きなのでそこにインストールした。あとはTagBarの方でこのctagsを使うよう設定する。


```vim
let g:tagbar_ctags_bin="/home/ukstudio/local/bin/ctags"
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }
```

これで上の画像のような感じでTagBarに表示されるようになるはず。