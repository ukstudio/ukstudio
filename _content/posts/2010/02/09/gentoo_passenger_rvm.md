---
aliases:
- /2010/02/09/gentoo_passenger_rvm
date: "2010-02-09"
title: Gentoo+Passenger+rvm
---
<h2>rvmのインストール</h2>
rvmのインストールはgithubからやった。(<a href='http://rvm.beginrescueend.com/install/'>rvm: Ruby Version Manager - Ways to install rvm.</a>)

使うバージョンは、1.8.7。

<code><pre>rvm install 1.8.7
rvm 1.8.7 --default</pre></code>

<h2>Passengerのインストール</h2>
Gentooだと、Passengerはmaskされてるっぽいので/etc/portage/package.keywordsにwww-apache/passenger追加して、emerge passengerする。

<h2>Apacheの設定</h2>
/etc/conf.d/apacheに"-D PASSENGER"追加。

/etc/apache/vhosts.d/にvirtualhost追加。

<pre><code>&lt;VirtualHost *:80&gt;
  ServerName hoge.example.jp
  DocumentRoot /path/rails/public
  RailsBaseURI /
  &lt;Directory /path/rails/public&gt;
    Options FollowSymLinks
    AllowOverride None
    Order allow,deny
    Allow from all
  &lt;/Directory&gt;
&lt;/VirtualHost&gt;</code></pre>

/etc/apache2/modules.d/30_mod_passenger.confを修正。

<code><pre>
PassengerRuby /home/ukstudio/.rvm/bin/ruby-1.8.7-p249
PassengerRoot /home/ukstudio/.rvm/gems/ruby-1.8.7-p249/gems/passenger-2.2.9/</pre></code>

あとはapacheを再起動すればOK。

なんか、rvmに--passengerオプションがあるのでそれを使うよう設定すれば、気軽にPassengerで使うrubyを返られる気がしなくもない。そこらへんはそのうちやる。