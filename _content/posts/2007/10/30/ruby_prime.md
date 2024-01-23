---
aliases:
- /2007/10/30/ruby_prime
date: "2007-10-30"
title: Rubyで素数を求めるプログラムを書いた
---
引数に入れた値までの素数を配列で返すRubyのクラスを書いてみた。アルゴリズムは<a href="http://ja.wikipedia.org/wiki/%E3%82%A8%E3%83%A9%E3%83%88%E3%82%B9%E3%83%86%E3%83%8D%E3%82%B9%E3%81%AE%E7%AF%A9">エラトステネスの篩</a>を使用。
<strong>generate_prime.rb</strong>
<pre lang="ruby">
class GeneratePrime
  def generate_prime(max_num)
    if max_num < 2 then return nil
    elsif max_num == 2 then return 2 end

    search_list = (2..max_num).to_a # 探索リスト
    prime_list = Array.new          # 素数リスト

    # 素数の探索
    begin
      prime_list << search_list[0]
      search_list.each_index{|i|
        if search_list[i] % prime_list[-1] == 0 then
          search_list.delete_at(i)  # 素数リストに加えた数の全ての倍数を削除
        end
      }
    end while search_list[-1] > (prime_list[-1] * prime_list[-1])

    # 素数リスト及び、探索リストに最後まで残っていた数が素数
    return prime_list.concat(search_list)
  end
end</pre>
<strong>generate_prime_test.rb</strong>
<pre lang="ruby">
require 'test/unit'
require 'generate_prime'

class TestGeneratePrime < Test::Unit::TestCase
  def setup
    @prime = GeneratePrime.new
  end
  def test_generate_prime
    assert_equal(nil, @prime.generate_prime(1))
    assert_equal([2,3,5,7], @prime.generate_prime(10))
    assert_equal([2,3,5,7,11,13,17,19,23,29], @prime.generate_prime(30))
  end
end</pre>
<strong>テスト結果</strong>
</pre><pre>
% ruby generate_prime_test.rb
Loaded suite generate_prime_test
Started
.
Finished in 0.000454 seconds.

1 tests, 3 assertions, 0 failures, 0 errors</pre>
テストが不十分な気もするけど多分大丈夫なはず。・・・多分。