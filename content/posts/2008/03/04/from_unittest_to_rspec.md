---
aliases:
- /2008/03/04/from_unittest_to_rspec
date: "2008-03-04"
title: test/unitで書いたテストにRSpecでテストを追記する方法
---
10分ぐらい調べて試してみただけだけど。

<pre lang="ruby">
require 'rubygems'
require 'test/unit'
require 'spec'

class TestArray < Test::Unit::TestCase

  # test/unit
  def test_1
    assert_equal(0, Array.new.size)
  end

  # rspec
  describe Array, "when empty" do
    before do
      @empty_array = []
    end

    it "should be empty" do
      @empty_array.should be_empty
    end

    it "should size 0" do
      @empty_array.size.should == 0
    end

    after do
      @empty_array = nil
    end
  end
end
</pre>

<pre lang="bash">
$ ruby test.rb
....

Finished in 0.007974 seconds

4 examples, 0 failures
</pre>

RSpecの方のテストはるびまの角谷さんの<a href="http://jp.rubyist.net/magazine/?0021-Rspec">記事</a>から拝借しました。

spceをrequireして、クラスに書きこんでいけばよさそう。仕事だとtest/unitで書いてしまったテストも多いだろうから、test/unitからRSpecに移行するのにいいかもしれない。