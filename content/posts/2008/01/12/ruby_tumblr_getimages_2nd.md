---
aliases:
- /2008/01/12/ruby_tumblr_getimages_2nd
date: "2008-01-12"
title: Tumblrの全画像を取得するRubyスクリプト改
---
<a href="http://uk-studio.net/2008/01/11/ruby_tumblr_getimages/">Tumblrの全画像を取得するRubyスクリプトを書いた・・・けど</a>

上のエントリーのコードを書き直した。これで10kb未満の画像でも問題ないはず。それとTumblrのIDを引数で与えるようにも修正した。独自ドメインのやつには対応してないです。ごめんなさい。

あとこっそり<a href="http://coderepos.org/share/browser/lang/ruby/misc/tumblr_getimages.rb">CodeReposにCommitした</a>ので、煮るなり焼くなりお好きにどうぞ。

<pre lang="ruby">
require 'open-uri'
require 'rexml/document'
require 'FileUtils'

if ARGV.size != 1
  puts "Usage: #{$0} [id] "
  exit
end

id = ARGV[0]

res = open(url)
doc = REXML::Document.new(res.read)
total = REXML::XPath.first(doc, "/tumblr/posts").attributes['total'].to_i

0.step(total, 50){|n|
  image_list = []
  res = open(url + "&start=#{n}")
  doc = REXML::Document.new(res.read)
  data = REXML::XPath.match(doc, "/tumblr/posts/post")
  data.each{|i| image_list < < i.elements['photo-url'].text }

  image_list.each{|image_url|
    open(image_url) do |image|
      open(image_url.split(/\//).last, "w") do |local_image|
        local_image.write(image.read)
      end
    end
  }
}
</pre></pre>