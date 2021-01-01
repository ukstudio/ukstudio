---
aliases:
- /2014/03/13/openvpn_qnap_funtoo
date: "2014-03-13"
title: FuntooからQNAPにOpenVPNでつなぐ
---

まずはFuntooにOpenVPNを入れる。

    sudo emerge openvpn

次にQNAPからOpenVPNの設定ファイルをダウンロードする。場所は「コントロール・パネル -> アプリケーション -> VPNサービス -> 設定ファイルのダウンロード」にある。(QTS 4.0.3)

zipが落ちてくるのでunzipするとca.crtとopenvpn.ovpnが展開されるので/etc/openvpnにmvする。他にOpenVPNで接続するところはないのでそのまま放りこむ。openvpn.opvnのままだと/etc/init.d/openvpn start時に怒られるのでopenvpn.confにリネーム。

    /etc/init.d/openvpn start

で起動する。ユーザとパスを聞かれるのでadminで認証する。他のユーザーで認証したい場合はVPNサービスの設定からユーザを追加する。ローカルIPでQNAPに繋れば無事終了。