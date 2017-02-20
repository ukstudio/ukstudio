---
title: 後置記法での計算
date: 2007-11-29
aliases:
- /2007/11/29/ruby_rpn
---
<a href="http://ja.wikipedia.org/wiki/逆ポーランド記法">後置記法</a>の文字列を計算するようStringクラスを拡張してみた。
<strong>rpn.rb</strong>
<pre lang="ruby">
class String
  def rpn
    @expr = self.split(" ")
    stack = Array.new

    @expr.each {|i|
      if i == "+" || i == "-" || i == "*" || i == "/"
        stack = calc(i, stack)
      else
        stack < < i
      end
    }

    return stack[0]
  end

  private
  def calc(operator, stack)
    return Array(stack[1..-1].inject(stack[0].to_i){|result, i|
      reslut = result.__send__(operator, i.to_i)
    })
  end
end
</pre>
</pre><pre lang="ruby">
require 'rpn.rb'
"2 8 +".rpn #=> 10
"4 6 -".rpn #=> -2
"81 9 /".rpn #=> 9
"4 3 *".rpn => 12
"3 7 + 10 20 + 2 * 10 + 80 -".rpn
#=>10
</pre>
入力は文字列で返り値が数値なのが違和感あるかもしれないけど、String#hexもそんな感じだし別にいいかなと。

最初はモジュールにして、それをStringクラスにincludeしようとか思ってたんだけど、モジュールにするとselfで自身の文字列を取得する方法がわからなくて断念。モジュールのselfだとモジュール自身を指しちゃうんだよね。

あとはcalcメソッドの中がなんか汚いのも気になるなぁ。

全然関係ないけど、後置記法よりSchemeみたいな前置記法の方がわかりやすいと思った。