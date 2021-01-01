---
aliases:
- /2008/06/30/song_for_autotest
date: "2008-06-30"
title: autotestの結果をMacのsayコマンドで通知する
---
かなりネタなエントリー。

Macにはsayコマンドと言うものがあって、入力した英単語とかをしゃべらせることができる。詳細はMacの手書き説明書さんが最近エントリー書いているのでそちらを見てくださいな。

<a href="http://veadardiary.blog29.fc2.com/blog-entry-1645.html">Macが歌いだす！？ | Macの手書き説明書</a>

んで、今回はそのsayコマンドを使って、autotestの結果をしゃべらせよう!というネタ企画。実用性はほぼ皆無。

まずは~/.autotestを修正。最下行に以下を追記する。既にgrowlの通知などの設定がある場合はそこにsayコマンドの実行文を追記すればOK。

<pre lang="ruby">
module Autotest::Growl
  Autotest.add_hook :ran_command do |at|
    results = [at.results].flatten.flatten.join("\n")
    output = results.slice(/(\d+)\s+examples?,\s*(\d+)\s+failures?(,\s*(\d+)\s+not implemented)?/)
    if output
      if $~[2].to_i > 0
        `say -v bad faild`
      else
        `say -v good success!`
      end
    end
  end
end
</pre>

`で括っている2箇所でsayコマンドを実行している。失敗したときはbadな声で、成功したときはgoodな声で結果を通知する。他にも色んな声があるらしいので、そこらへんは好みで。

<pre lang="bash">
ls /System/Library/Speech/Voices
</pre>

とすると声の一覧がでるっぽい。