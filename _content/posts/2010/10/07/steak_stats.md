---
aliases:
- /2010/10/07/steak_stats
date: "2010-10-07"
title: steakのspec/acceptanceをrake statsに反映させる
---
<strong>どうやらsteakで対応してるみたいです(コメント欄参照)。steakのgroupに:developmentを追加すればrake statsの結果にAcceptance specsと表示されます。</strong>

結論から言うとrakeファイルを追加して以下のように書けばOK。(Rails.root/lib/tasks/statistics.rakeとかね)
<script src="http://gist.github.com/613641.js?file=statistics.rake"></script>
task名がstatsetupなのはrspec-rails/lib/rspec/tasks/rspec.rakeでそうなっている為。cucumberでも同じ要領で大丈夫なはず。rake statsを実行するとちゃんと計算されている。
<a href="http://ukstudio.jp/wp-content/uploads/2010/10/steak_stats.jpg"><img src="http://ukstudio.jp/wp-content/uploads/2010/10/steak_stats.jpg" alt="" title="steak_stats" width="531" height="240" class="alignnone size-full wp-image-719" /></a>