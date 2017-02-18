---
title: CentOS 5.4(EC2)にApache+PassengerでRails環境作る
---
後々、また参照する気がするので記録しておく。この手の環境構築系のドキュメントってWikiかなんかにみんなで情報集めたらそこそこ便利そうな気がするのだけどどうだろう。

<h2>Ruby、RubyGemsのインストール</h2>
yumでRubyをインストールしようとすると、1.8.5が入ってしまうので仕方なくソースからインストール。

<code><pre>
$ cd /usr/local/src
$ sudo wget ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p249.tar.gz
$ sudo tar zxvf ruby-1.8.7-p249.tar.gz
$ cd ruby-1.8.7-p249
$ sudo ./configure
$ sudo make
$ sudo make install
</pre></code>

<code><pre>
$ cd /usr/local/src
$ sudo wget http://rubyforge.org/frs/download.php/69365/rubygems-1.3.6.tgz
$ sudo tar zxvf rubygems-1.3.6
$ cd rubygems-1.3.6
$ sudo ruby setup.rb
</pre></code>

この時点で一応RubyGemsもインストール出来てはいるけれど、実際に使おうとするとエラーが発生する。どうやらzlibが入っていなかった模様。

<code><pre>
$ sudo yum install zlib-devel
$ cd /usr/local/src/ruby-1.8.7-p249/ext/zlib
$ sudo extconf.rb --with-zlib-include=/usr/include --with-zlib-lib=/usr/lib
$ sudo make
$ sudo make install
</pre></code>
<h2>MySQLのインストール</h2>
こっちはyumからサクッとインストール。

<code><pre>
$ sudo yum install mysql mysql-server mysql-devel
$ sudo /etc/initd.mysqld start
</pre></code>

my.cnfの設定は/usr/share/mysql/以下からコピーしてきたりとか適当に。ユーザの設定とかも適当に。

<h2>Apache+Passenger</h2>
まずはApacheをサクッとインストール。

<code><pre>
$ sudo yum install httpd-devel
</pre></code>

そしてPassengerのインストール。

<code><pre>
$ sudo gem install passenger
$ sudo passenger-install-apache2-module
</pre></code>

ここでまたしてもエラー。どうやらOpenSSLが入っていないとかなんとか。
<code><pre>
$ sudo yum install openssl-devel
$ cd /usr/local/src/ruby-1.8.7-p249/ext/openssl
$ sudo ruby extconf.rb
$ sudo make
$ sudo make install
</pre></code>

これで無事Passengerがインストール出来る。

<code><pre>
$ sudo passenger-install-apache2-module
</pre></code>

最低限のPassengerの設定。この設定の内容はpassenger-install-apache2-moduleを実行した時に表示されているので確認しておくこと。

<code><pre>
$ sudo vi /etc/httpd/conf.d/passenger.conf
LoadModule passenger_module /usr/local/lib/ruby/gems/1.8/gems/passenger-2.2.11/ext/apache2/mod_passenger.so
PassengerRoot /usr/local/lib/ruby/gems/1.8/gems/passenger-2.2.11
PassengerRuby /usr/local/bin/ruby
</pre></code>

あとはhttpd.confのDocumentRootをRailsのpublicディレクトリにすればOK。
<code><pre>
$ sudo vi /etc/httpd/conf/httpd.conf
DocumentRoot /path/to/rails/public
</pre></code>

本当に最低限だけどとりあえずこれでPassengerでRailsを動かすことが出来るはず。ApacheやMySQLの自動起動はchkconfigを設定すればよい。Passengerの細かい設定は<a href='http://www.modrails.com/documentation/Users%20guide.html'>Passenger users guid</a>を参考に。
