---
title: RSpecでprivateメソッドをテストする
date: 2009-11-02
---
<script src="http://gist.github.com/223674.js"></script>

Object#send(__send__)ならメソッドの呼び出し制限に関わらずメソッドを呼び出すことが可能なので、privateメソッドもテスト可能。

確か、1.9以降はメソッド呼び出し制限がObject#sendにも影響するとどこかで見た記憶があるのだけど結局そうはなっていないみたい。

1.9.1、1.8.7で確認済み。

ちなみにオマケ。
<script src="http://gist.github.com/223679.js"></script>

Pythonはメソッド名の前にアンダースコアを2つけるとprivateなメソッドになるのだけれど、実際のところ別名でメソッドを定義してそちらを呼び出してるっぽい。別名で定義された方はprivateではないので、そちらを呼び出してテストすることが可能。

他にもJavaだったらsetAccessible(True)を実行すればpublicなメソッドに変更されるのでテスト可能。と聞いただけで確認はしていない。