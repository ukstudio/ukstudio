---
aliases:
- /2007/12/30/rubycocoa_brainfuckinterpreter
date: "2007-12-30"
title: RubyCocoaでBrainFuckインタプリタっぽいものを作ってみた
---
初めてのRubyCocoaでのプログラミング。以前作ったBrainfuckのコードを処理するRubyプログラムを流用した。主に参考にしたのは<a href="http://limechat.net/rubycocoa/tutorial/">RubyCocoa 入門</a>。と言うか、ここしか見てない。

<img src="http://farm3.static.flickr.com/2055/2148748886_48f93983a6.jpg?v=0"/>

上のテキストフィールドにBrainfuckのコードを入力して、executeのボタンを押すと変換された文字列が下のフィールドに表示される。キャプチャのBrainfuckのコードは途切れてるだけで、実際はもっと長い。本当はテキストエリアみたいなのにしたかったんだけれど、オブジェクトがどれだかわからなかった。

以前、Objective-Cで少しだけCocoaプログラミングをした時も同じことを思ったけど、Interface BuilderはやっぱりUIを設計していく上で優秀だと思う。コントローラクラスとオブジェクトを関連づける操作もかなり直感的でさすがAppleと言ったところか。