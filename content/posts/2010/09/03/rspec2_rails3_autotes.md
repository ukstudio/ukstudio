---
title: RSpec2+Rails3+autotest環境の構築
date: 2010-09-03
aliases:
- /2010/09/03/rspec2_rails3_autotes
---
9月からやる仕事がめでたく、Rails3.0 + Ruby1.9.2のお仕事なので色々と環境構築。とりあえず自動テストまわりやりました。

一応、環境を他と切り分けるために、rvmでアプリ用にgemsetを用意。アプリごとに簡単に環境を構築できるrvmマジ便利。

<pre>
gem install bundler --pre
gem install rails
</pre>

まずは、bundlerとrailsをインストール。次は適当なアプリを作って必要なgemのインストールなどを行う。テストはRSpecで書くので、-TをつけてTest/Unitは使わないようにする。

<pre>
rails new demo -T
</pre>

次に必要なgemをGemfileに記述。rspecとかを「テストだけだから」と思って、gropu :testにしたら、モデルを作成したときにTest/Unitのテストコードが作られたりしたので注意。githubの<a href='http://ja.wiki.github.com/rspec/rspec/autotest/'>Wiki</a>を見るとautotestのgemは不要そうなんだけど、実際ないとうまくautotestが動かなかた。

<script src="http://gist.github.com/563447.js?file=Gemfile"></script>

<pre>
bundle install
</pre>

あとはモデルを作って、テストが実行できればOK。

<pre>
rails g rspec:install
rails g model user
rake
autotest
</pre>

<h3>追記</h3>
Twitterで@conceal_rsさんから補足ありました。ありがとうございます!