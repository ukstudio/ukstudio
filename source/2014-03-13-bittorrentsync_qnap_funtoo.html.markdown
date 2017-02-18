---
title: BitTorrent SyncでQNAPとFuntooで同期する
date: 2014-03-13 03:23 UTC
tags: bittorrentsync qnap funtoo
---

QNAPの一部のディレクトリ(主に電子書籍)とローカルのマシンで同期を取りたかったのでBitTorrent Syncで同期を取ってみる。NFSでもいいんだけど、電子書籍ぐらいならローカルにおけるぐらいのストレージ容量はあるので。

QNAPにBitTorrent Syncを入れる
----------------------------

基本的には[QNAPのドキュメント](http://www.qnap.com/useng/index.php?sn=9137)を参照すれば問題ないと思う。簡単に説明しておくとQTSにBitTorrent Syncを追加し、BitTorrent SyncのWebUIを起動する。WebUIのアクセスユーザは途中で"Please modify the Login ID / Password"とか言われる画面でLogin IDとPasswordを入力し、Apply Changesをすればそのユーザで接続できる。

次にBitTorrent SyncのWebUIが起動したらAdd Folderから該当のディレクトリを選択する。Secret KeyはここでGenerateしておく。(後でローカルの方の設定で使用する)。QNAP側はこれで終わり。

FuntooにBitTorrent Syncを入れる
------------------------------

FuntooはportageにBitTorrent Syncのebuildがあるのでそれを使う。

    sudo emerge bittorrent sync

起動は`/etc/init.d/btsync start`だが、コンフィグの修正が必要。init.dで起動するとログがでないからわからないが、`/opt/btsync/btsync`で起動するとstorage_pathが存在しないと怒られるのがわかる。コンフィグは`/etc/btsync/config`がそう。

    // "storage_path" : "/home/user/.sync",
    "storage_path" : "/home/ukstudio/.sync",

ディレクトリはお好みで。

`/etc/init.d/btsync start`で無事btsyncが起動したら、http://localhost:8888/guiでWebUIにアクセスできる。IDとパスは'admin'と'password'。

WebUIにアクセスできたら、Add FolderでQNAPと同期させたいディレクトリを指定する。Secret Keyはここでは生成させず先程のQNAPのsecret keyをコピペする。保存し、WebUIのトップ画面で"connected devices and status"でダウンロード速度が表示されたら無事同期がはじまっている。
