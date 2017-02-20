---
title: BitlBeeでHipChatに接続する
date: 2014-03-18
aliases:
- /2014/03/18/bitlbee_hipchat
---

HipChatのLinuxクライアントは残念ながら日本語入力ができないのでかわりにIRCを使ってみる。
HipChatはJabberが使えるのでBitlBeeを使ってJabber経由でIRCと繋ぐことにする。BitlBee自体の設定はなにもいらないので各環境にあわせて適当に入れて起動する。

	sudo emerge bitlbee
	sudo /etc/init.d/bitlbee start

次にIRCクライアントでBitlBeeに接続する。BitlBeeはlocalhostに6667ポートで立ち上がっているので(コンフィグで修正していなければ)、そこに接続する。文字コードはUTF-8でOK。
接続できたらbitlbeeの部屋でコマンドを入力し、アカウントを追加する。HipChatのJabberのアカウントは「Account Setting > XMPP/Jabber info」にある。

	account add jabber username@chat.hipchat.com 'password'

次に各ユーザがニックネームで表示されるように設定する。これをやらないと数字の羅列で誰が誰だかわからない状態になってしまう。

	account hipchat set nick_source full_name

次にアカウントを有効化する。この時点で認証などもしているので失敗したらアカウント情報を見直すこと。

	account hipchat on

有効化できたらすでに部屋に参加できるが数字の羅列が頭についているので使いにくい。別の名前を割り当てることができるので適当に自分が使いやすい名前をつける。

	chat add hipchat room_jaber_name@conf.hipchat.com #channelname

ニックの設定次第だとHipChatから怒られるのでその場合HipCHatで使っている名前を設定する。

	channel #channelname set nick 'room nickname'

無事、部屋にjoinしてログが流れてきたら終了。

	/join #channelname