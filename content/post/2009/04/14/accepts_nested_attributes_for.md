---
title: accepts_nested_attributes_forしたモデルの日本語化
date: 2009-04-14
aliases:
- /2009/04/14/accepts_nested_attributes_for
---
名前、長いよね。accepts_nested_attributes_for。以下、ネストしたって言います。長いので。

最近はもっぱら日本語化はi18nにしてるんですが、今回ちょこっとこのネスト関係ではまったのでメモ。

<script src="http://gist.github.com/94931.js"></script>

とりあえずモデルの作成までガッとやります。Railsのバージョンは2.3.2です。最下行はgemのインストールが必要です(<a href="http://github.com/amatsuda/i18n_generators/tree/master">http://github.com/amatsuda/i18n_generators/tree/master</a>)

<script src="http://gist.github.com/94933.js"></script>
<script src="http://gist.github.com/94934.js"></script>

それぞれアソシエーションとバリデーションのコードを追記しておきます。当然、accepts_nested_attributes_forの記述も必要です。その辺の詳細は省くので適当にググってみてください。

で、日本語化はモデルを作成した後に行なっているのでとりあえずカラムは日本語化されてる筈です。その辺の詳細も省きます。

<script src="http://gist.github.com/94935.js"></script>

されてるはずなのですが、一部日本語化されてない箇所があるのでこれを日本語化させます。

<script src="http://gist.github.com/94936.js"></script>

userモデルのところにentries_xxxが追記されています。ちなみにhas_oneの場合はentry_xxxになります。xxxはカラム名。

<script src="http://gist.github.com/94937.js"></script>

おわり。