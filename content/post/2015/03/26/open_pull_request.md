---
title: 特定のコミットが含まれるGitHub Pull Requestを開く
date: 2015-03-26
aliases:
- /2015/03/26/open_pull_request
---

今日たまたまあるコミットが含まれているGitHubのPull Requestをサクッと探したい事案が発生した。というのも自分が以前書いたコードがどうしてこうなっているのかというのを知りたかったんだけど、commit messageだけじゃよくわからんかった(〜を実装したみたいなことを英語で書いてあっただけ)。

Pull Requestは割と丁寧に説明を書いているのできっとPull Requestのdescriptionを見ればわかりそうという感じはしたのだけれどパッとそれを開く手段がわからず、色々ググったりtwitterで教えてもらったりした結果下のようなfunctionをzshrcに書いた。

```shell
function find-pr() {
  local parent=$2||'master'
  git log $1..$2 --merges --ancestry-path --reverse --oneline | head -n1
}

function find-pr-open() {
  local pr="$(find-pr $1 $2 | awk '{print substr($5, 2)}')"
  local repo="$(git config --get remote.origin.url | sed 's/git@github.com://' | sed 's/\.git$//')"
  open "https://github.com/${repo}/pull/${pr}"
}
```

```
find-pr-open REVISION
```

あまりシェルは得意ではないのでそこらへんは大目に見て欲しい。やってることはfind-prで該当のcommitが含まれているMerge commitを探してcommit messageからGitHub Pull Requestの番号を取り出している。リポジトリ名はgit configから取得して余計な文字はsedで削除。あとはURLを組み立ててブラウザで開くだけ。多分これでPull Requestを開けるはず。

なんにせよcommit messageはもうちょっと丁寧に書こうと思いました。