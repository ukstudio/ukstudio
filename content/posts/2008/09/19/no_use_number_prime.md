---
title: 数字を使わずに素数判定
date: 2008-09-19
aliases:
- /2008/09/19/no_use_number_prime
---
86のSkypeチャットで話題になったのでちょこちょこっと書いた。普通にループして比較するだけお。もっといい方法あるんだろうけど、とりあえずはよしとする。

<pre lang="ruby">
class Integer
  def prime?
    return false if self.zero? || self == [[]].size
    ([[],[]].size...self).each do |i|
      return false if (self%i).zero?
    end
    true
  end
end
</pre>

suztomoのやつ。
<a href="http://d.hatena.ne.jp/suztomo/20080918/1221746629">http://d.hatena.ne.jp/suztomo/20080918/1221746629</a>