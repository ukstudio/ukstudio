---
aliases:
- /2013/12/27/funtoo
date: "2013-12-27"
title: GentooからFuntooに移行しました
---

GentooからFuntooに移行した。[Funtoo Linux インストール講習会](http://esminc.doorkeeper.jp/events/3547)から大分日が立ってしまった。

インストール自体は[Funtoo Linux Installation](http://www.funtoo.org/Funtoo_Linux_Installation)をそのまま実行。boot-updateのビルドだけ失敗したが、texinfo-5.1以上をmaskしたら解決。

ネット関係はNetworkManagerが妙に不安定だったのでwicdを使うことにした。wicd-cursesがいい感じ。今のところ接続も安定している。

X環境まわりは例のごとくXmonadで。GNOMEも一度入れたけど、結局使わないのでアンインストール。mix-inのGNOMEも余計なUSEフラグをつけて邪魔だったので使わないことにした。

GNOMEを削除したのでGDMではなくSlimeを使うことにした。GDMとかstartxがxinitrcを読むのかxprofileを読むのかとかいっつも忘れる…

その他GitやらRubyやら入れてひととおり終了。カーネルをバイナリで入れてるので起動が遅いけどカーネルのコンフィグでハマるのもダルいしとりあえずこのままで行く予定。
