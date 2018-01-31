---
title: "fish shellでrbenvを使うまで"
date: 2018-01-31T14:34:50+09:00
---

fishとrbenvのインストールについては割愛。

## omfやfishermanのpluginを使わない場合

config.fishに以下を記述。

```sh
set -x PATH ~/.rbenv/bin $PATH
rbenv init - | source
```

## omfを使う場合

まずはoh-my-fishをインストール。

- [oh\-my\-fish/oh\-my\-fish: The Fishshell Framework\.](https://github.com/oh-my-fish/oh-my-fish)

```sh
curl -L https://get.oh-my.fish | fish
```

config.fishにはPATHの記述が必要だけど、config.fishに書いてしまうとomfのrbenvプラグインの方が先に読み込まれるため、rbenvがないとエラーになってしまう。なので先にPATHの設定が登録されるように~/.config/fish/conf.d/000-env.fishに記述する。

```sh
set -x PATH ~/.rbenv/bin $PATH
```

PATHを追加したらプラグインをインストール。

```sh
omf install rbenv
```

## fishermanを使う場合

fishermanをインストール。

- [fisherman/fisherman: The fish\-shell plugin manager\.](https://github.com/fisherman/fisherman)

```sh
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
fisher install rbenv
```

こちらもrbenvのPATH追加が必要。こちらはconfig.fishでも000-env.fishでも問題ない。

```sh
set -x PATH ~/.rbenv/bin $PATH
```

## config.fishと000-env.fish

fishは個人向けの設定は~/.config/fish/config.fishに記述するのが一般的。ただ設定ファイルの読み込み順序の問題で問題が起きるケースがある(今回のomfのrbenvプラグインなど)

具体的にどういうことかというとomfのrbenvプラグインは~/.config/fish/conf.d以下にファイルが設置されるが、config.fishより先にそちらの方が読み込まれるため、config.fishにPATHの設定を記述してもプラグインの読み込み時点ではPATHは設定されない。

なので、conf.dの中で一番早く読み込まれる名前のファイル(000-env.fish)を作り、そこにPATHの設定を定義する。
