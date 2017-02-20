---
title: Macでgem install mysqlをする方法
date: 2008-11-27
aliases:
- /2008/11/27/mac_gem_install_mysql
---
Rails2.2からmysqlのアダプタが付属していないので各個人でインストールする必要があります。gemで入れようとするとエラーがでると思うので以下のように対応してください。

<pre lang="bash">
$ sudo gem install mysql
$ cd /opt/local/lib/ruby/gems/1.8/gems/mysql-2.7/
$ sudo ruby extconf.rb --with-mysql-config=/opt/local/lib/mysql5/bin/mysql_config
$ sudo make
$ sudo make install
</pre>

パスに関しては、人によって違うかもしれませんが適宜読み替えてください。

追記

<pre lang="bash">
$ sudo gem install mysql -- --with-mysql-config=/opt/local/lib/mysql5/bin/mysql_config
</pre>

これでも大丈夫らしい。