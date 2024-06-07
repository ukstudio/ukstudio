---
permalink: /rspec
created: 2024-06-07
updated: 2024-06-07
---
- [RSpec: Behaviour Driven Development for Ruby](https://rspec.info/)

2024年現在、[[Ruby]]のデファクトスタンダード的なテスティングフレームワーク。BDDと言ってはいるものの、BDD自体がややこしい言葉になっている今となってはあまりBDDとかは関係なく使っているユーザーが多いと思われる。

BDDについてはかなり昔に [[BDDについて自分なりにまとめてみた]] という記事を書いているのでそちらもどうぞ。

## Tips

以下Tipsというかメモ。

### let!とインスタンス変数を組み合わせるとき初期化タイミングに注意

```ruby
let!(:var) { @var }

before do
  @var = 1
end

it { expect(var).to eq 1 } #=> 失敗する。varが返す値はnil
```

`let!`は内部的には`before`と`let`の組み合せである。また、`before`は基本的に上から順に実行される。つまり、この場合`@var = 1`より前に`let!`による`@var`への参照が発生するが、値は設定されていないため`nil`が設定される。

## 参考情報

- [willnet/rspec\-style\-guide: 可読性の高いテストコードを書くためのお作法集](https://github.com/willnet/rspec-style-guide)
- [RSpec では context 間の違いを表現するときにのみ let を使う \- id:onk のはてなブログ](https://onk.hatenablog.jp/entry/2023/02/26/221616)
- [Rails Developers Meetup 2017 で RSpec しぐさについて話した \- onk\.ninja](https://blog.onk.ninja/2017/12/13/rspec_shigusa)