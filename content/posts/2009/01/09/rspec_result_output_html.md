---
aliases:
- /2009/01/09/rspec_result_output_html
date: "2009-01-09"
title: RSpecの結果をHTMLで出力する方法
---

RSpecにはオプション-hがあるので、そこでフォーマットを指定してやればいい。以下、Railsの例。

<pre lang="bash">
RAILS_ROOT$ spec spec -f h:spec/spec_report.html
</pre>

これで、specディレクトリにspec_report.htmlが出力される。
