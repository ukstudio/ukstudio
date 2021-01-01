---
aliases:
- /2010/12/17/recovery-network-manager-gnome
date: "2010-12-17"
title: うっかりnetwork-manager-gnomeを消してネット繋がらなくなった
---
xubuntuを以前インストールしててもういらねーやと思って色々消してたら、気づいたらnetwork-manager-gnomeも消えていてインターネットに繋がらなくなったでござる。

とりあえず手元のHT-03Aで適当にぐぐった結果、<a href="https://forums.ubuntulinux.jp/viewtopic.php?id=6441">Ubuntu日本語フォーラム / [Ubuntu 9.10] ネットワーク・マネジャーを復元したい</a>が見つかったので試してみるもそれっぽいパッケージがCDから見つからず挫折。

んじゃ、コマンドラインからなんかネット接続する方法があればなんとかなるかな?と思ってこれまた適当にぐぐると<a href="http://felix-labo.jp/pukiwiki/?Ubuntu%2Femobile-H11HW%E6%8E%A5%E7%B6%9A%E6%96%B9%E6%B3%95">Ubuntu/emobile-H11HW接続方法 - Felix-labo&apos;s Wiki</a>が見つかったので試した結果なんとかインターネット接続成功。

あとは<a href="http://packages.ubuntu.com/"> Ubuntu Packages Search</a>からnetwork-manager-gnomeのdebパッケージを落としてきて、recovery consoleからaptitudeでインストールで無事終了。