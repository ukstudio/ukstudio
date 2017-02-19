---
title: Firefoxα2とβ1preを試してみた
date: 2008-09-09
---
いつのまにかFirefoxのα2とβ1preがリリースされてたので試してみた。個人的にVimpとかグリモンがないとどうにもならない体になってしまったので<a href="https://addons.mozilla.org/ja/firefox/addon/6543">Nightly Tester Tools</a>をインストール。これで3.01で動いていた拡張は大体動く模様。

それとTraceMonkeyを使えるようにするためabout:configを開いて、「jit」で検索。2項目ほどヒットするので、それぞれの値をfalseからtrueに変更する。これでTraceMonkeyはONになるみたい。

使ってみた感想をざっと過剰書きであげてみると

<ul>
<li>レンダリングが結構向上しているのが体感でわかる。</li>
<li>Mac版FirefoxのFLAHの日本語入力問題が解決してるっぽい。</li>
<li>β1preでLDRを開いたらちゃんと表示されなかった。α2は大丈夫。</li>
<li>Ctrl+Tabがかっこいい。でもvimp使ってると関係ない話。</li>
</ul>

ざっとこんな感じ。レンダリングの向上がかなりうれしい。今のところβの方でLDRが表示できなかったこと以外特に問題は起きていない。まぁLDRが見れないのは致命的なのでとりあえずα2の方を使っていこうと思う。

TraceMonkeyに関しては、オン、オフそれぞれ試したけど普通に使っている分には違いがわからなかった。オフでも十分はやくなっている。ベンチマークをとったらもしかしたら違うのかもしれないけど。

なんにせよ、個人的には今回のα2とβ1preには非常に満足しているので、正式リリースが楽しみになってきた。

<a href="http://developer.mozilla.org/devnews/index.php/2008/09/05/firefox-31-alpha-2-now-available-for-download/">Mozilla開発者向け公式ブログの記事</a>
<a href="ftp://ftp.mozilla.org/pub/firefox/nightly/latest-trunk/">Firefox3.1β1pre</a>
<a href="https://wiki.mozilla.org/JavaScript:TraceMonkey#Playing_with_TraceMonkey">TraceMonkeyの有効化</a>