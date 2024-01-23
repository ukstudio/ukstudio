---
aliases:
- /2014/09/21/rspec_power_assert
date: "2014-09-21"
title: RSpecでPower Assertをやるには
---

RubyKaigi 2014でpower assertの話を聞いてrspecでどうにかならんかちょっと考えてみました。まず結論だけ書くとrspecでpower assertを使いたければ以下の様に書けばOK。

```ruby
require 'rspec'
require 'minitest'
require 'minitest-power_assert'

module Minitest
  module Assertions
    prepend  Minitest::PowerAssert::Assertions
  end
end

RSpec.configure do |config|
  config.expect_with :minitest
end

describe 'Test' do
  it 'test' do
    assert { 1.to_s.class == 1.to_i.class }
  end
end
```

これを

```shell
$ rspec --color -rpower_assert power_assert.rb
```

で実行するとこんな感じ。power_assertは事前にrequireした方が情報量がちょっと増える。

```
Failures:

  1) Test test
     Failure/Error: assert { 1.to_s.class == 1.to_i.class }
     Minitest::Assertion:

           assert { 1.to_s.class == 1.to_i.class }
                      |    |     |    |    |
                      |    |     |    |    Fixnum
                      |    |     |    1
                      |    |     false
                      |    String
                      "1"
```

## letとsubject

power_assertの0.1.3だとdefined_methodで定義されたメソッドの値が取れていないらしく、letやsubjectの値が表示されない。現時点でのmasterの0.1.4devだと修正されているとのことなのでちゃんと表示される。

```ruby
describe 'Test' do
  let(:klass) { 1.to_s.class }
  it 'test' do
    assert { klass == 1.to_i.class }
  end
end
```

これを実行すると

```
Failures:

  1) Test test
     Failure/Error: assert { klass == 1.to_i.class }
     Minitest::Assertion:

           assert { klass == 1.to_i.class }
                    |     |    |    |
                    |     |    |    Fixnum
                    |     |    1
                    |     false
                    String
```

こんな感じ。subjectも大体おなじ。

## expectとマッチャ

この方法はMinitestのadapterとminitest-power_assertを使うようにしているので無理。

ちなみに [rspec で 手軽に power_assert 出力できるようにする](https://gist.github.com/mizoR/3cf068eeae033bd5db5a) の方法でexpectを使ってみると

```ruby
require 'rspec/core'
require 'power_assert'

module RSpec
  module PowerAssert
    def power_assert(&block)
      ::PowerAssert.start(block) do |pa|
        begin
          pa.yield
        rescue RSpec::Expectations::ExpectationNotMetError => e
          e.message << "\nPowerAssert:\n#{pa.message_proc.call}"
          raise e
        end
      end
    end
  end
end

class RSpec::Core::ExampleGroup
  include RSpec::PowerAssert
end

describe 'Test' do
  it 'test' do
    power_assert {
      expect(1.to_s.class).to eq(1.to_i.class)
    }
  end
end
```

これは

```
       PowerAssert:
             expect(1.to_s.class).to eq(1.to_i.class)
             |        |    |      |  |    |    |
             |        |    |      |  |    |    Fixnum
             |        |    |      |  |    1
             |        |    |      |  #<RSpec::Matchers::BuiltIn::Eq:0x007f0850c91d78 @expected=Fixnum, @actual=String>
             |        |    |      nil
             |        |    String
             |        "1"
             #<RSpec::Expectations::ExpectationTarget:0x007f0850caa170 @target=String>

```

こうなってしまう。この場合、expectの@targetにStringという結果が入っているのでそれを取り出すようにして、eqの方も@expectedに期待するものがはいってるのでそれを取りだすようにすればいいのかなぁ。

もしくはexpectとeqの中の値さえわかれば良いといえば良いのでいっそ値をださなくてもいいのかも? 例えばこんな感じ。

```
       PowerAssert:
             expect(1.to_s.class).to eq(1.to_i.class)
                      |    |              |    |
                      |    |              |    Fixnum
                      |    |              1
                      |    |
                      |    |
                      |    String
                     "1"


```

別の例としてbe_falseyだとこんな感じ。

```
     Failure/Error: expect(nil.to_s.to_i).to be_falsey
       expected: falsey value
            got: 0
       PowerAssert:
             expect(nil.to_s.to_i).to be_falsey
             |          |    |     |  |
             |          |    |     |  #<RSpec::Matchers::BuiltIn::BeFalsey:0x007fa84b53bb00 @actual=0>
             |          |    |     nil
             |          |    0
             |          ""
             #<RSpec::Expectations::ExpectationTarget:0x007fa84b3e02b0 @target=0>
```

これに関していうとbe_falseyにはfalseが欲しいという情報がない。be_falseyを見れば求めてるものはわかるって話かもしれないけど… 更に言うとRSpec3でComposable Matcherが入ったりとか、以前からあるCustom Matcherとかがあったりして、それら全部対応するのは厳しいなーという感じ(そもそも対応できるのかもよくわからない…)

そもそもの話をするとそういったマッチャというか、たくさんあるassertion methodを使い分けしたくないからpower assertをつかうわけで別にマッチャとか使わなくていいのではという気持ちがある。

なのでexpectとかカスタムマッチャとかは(power assertを使う部分では)諦めてassertですませるのがよさそうかなと個人的には思う。

```ruby
config.expect_with :minitest
config.expect_with :rspec
```

spec_helper.rbにminitestもrspecも両方使うよう書けばpower_assertを使いたいところと、rspecを使いたいところで分けることができるのでどうしてもマッチャを使いたいところは素直にマッチャを書いてpower assertは諦めるしかない。

今あるテスト資産をそのまんまpower assert対応にはできないのが悲しいところではあるけれども、このassertを使う方法でもexpectation部分以外はrspecの機能そのまま使えるのでそこまで悪くはないかなと思う。

まだpower_assert gemの実装を理解できていないので、もしかしたらうまいことやれるかもしれないけどとりあえずここでギブアップ…