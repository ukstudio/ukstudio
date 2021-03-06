---
aliases:
- /2011/01/23/bought_galaxy_tab
date: "2011-01-23"
title: Galaxy Tabを購入した
---
HT-03AからGalaxy Tabに機種変した。と言っても電話はこれしか持っておらず、さすがにGalaxy Tabで通話するのは不便なので機種変した後SIMを抜いてHT-03Aに戻した。Galaxy TabはWi-Fiメインで使う予定。今のところ外でGalaxy Tabからネットに繋ぐことはあまり考えてない。とは言え繋げるにこしたことはないので、今持っているイーモバをPocketWiFiにするか、b-mobileを契約するかぐらいのことは検討している。

<h2>Galaxy Tabを購入した目的</h2>
Galaxy Tabを購入した最大の目的は電子書籍。本については基本的に紙で読みたい派なのでちょっと前は「別に電子書籍とかいいや」と思っていたけど、仕事中に「あの本に書いてあった気がする。けど手元にない」みたいなことは結構良くあるので、その辺りのメリットを考慮して踏み切った。

仕事中にという限定で言えば別に端末を買わずともPCにデータを入れておけばいいだけだ。にも関わらず端末を買ったのは本の大きさが原因で読む機会を減らしている物があること。例えば通勤中とかで本を読むのだけど、ある一定以上の大きさになると鞄から出すのが億劫になったり、そもそも鞄に入らないことが多い為。

あともう1つの理由は、PCはやはりじっくり本を読むにはあまり適していないため。つまりは電子書籍買ったり自炊するんだったら、読み終わった本をデータとして持ち歩くだけでなく、最初から読むことも考えたかった。

<h3>電子書籍としてのGalaxy Tabの評価</h3>
評価と言っても他の端末を使っていないのであまり比較したものは言えないけど、僕からすると「必要十分」と言ったところ。PDFやepubのデータで読んでいるけど速度的には十分。流石に紙の本みたいにあるキーワードを探しながらペラペラめくるというのは厳しい。ただ、せっかくのデジタルなのでそこらへんは検索でカバーしたいところ。

ちなみにPDFを読む為に使っているアプリはezPDF Readerと言うアプリ。有料だけど$1ぐらいだったと思うので問題ない。このアプリを使っている理由はブックマーク機能と文壇合わせ機能があること。Adobe Readerで読んでいる時はPDFの余白が結構邪魔で、端末のサイズが小さめのこともあって拡大を適宜調節するのがちょっと面倒だった。ezPDF Readerの文壇合わせは文章のブロックごとに余白を詰めてくれるので拡大をわざわざする必要がない。この機能が今のところezPDF Reader以外見当らなかったのでこれを使用している。

端末のサイズ的には電車内で片手持ちをするならこのサイズが限界と言ったところか(人にもよるし女性だと辛いかもしれない)。逆に単純に電子書籍端末として考えると少し小さい気もする。この辺のバランスは人によって違うだろうから何とも言えない。個人的には満足してるし、現状販売されている端末の中だとこのサイズがベストだったと思う。

<h2>Galaxy Tabを買って最初にやったこと</h2>
<h3>root権の取得</h3>
Galaxy Tabでrootを取得するには<a href="http://forum.xda-developers.com/showthread.php?t=833953">[APP] z4root - xda-developers</a>からz4rootのapkを取得してインストールすればいい(要会員登録)。インストールや使い方の詳細は検索すれば出てくると思うので割愛するが、とても簡単にroot化できる。root化は自己責任で。

<h3>システムフォントをTakaoフォントに</h3>
個人的にTakaoフォントが気に入っているのでGalaxy TabのシステムフォントをTakaoフォントにすることにした。手順はちょっと面倒だが以下の通り。ちなみにパソコンがUbuntu 10.10前提の話。

まずは、Android SDKを用意してadbコマンドを使えるようにする。Galaxy TabはそのままだとDeviceとして認識されないので/etc/udev/rules.d/51.andorid.rulesにlsusbからidVendorとidProductというパラメータを記述しなければならない。この辺はDev Phoneと同じ問題っぽいので詳しくはDev Phoneについて検索するといいかも。

<pre>SUBSYSTEM='usb', ATTRS{idVendor}=="04e8", ATTRS{idProduct}=="681c", MODE=="0666"</pre>

ファイルを保存したら<code>sudo service udev restart</code>してやる。

これだけでもまだadbで繋ぐには不十分でadbのserverをsudoで立ち上げてやらないといけない。

<pre>
$ adb kill-server
$ sudo adb start-server
$ adb devices # ここでdeviceが?????とかじゃなくちゃんと表示されていればOK
</pre>

adb shellで無事端末につなげたらフォントを書き換える為にsuしなくてはならない。suするとGalaxy Tab側でx4rootのアプリがrootを許可するかポップアップを出しているので許可してやる。システムフォントは/system/fonts以下に入っている。日本語フォントはDroidSansJapanese.ttfで、英語はDroidSans.ttfとDroidSans-Bold.ttf。他にもあるかもしれないけど今回書き換えたのはこの3つ。ちゃんとバックアップ取っておくこと。ハードリセットしても元には戻らない。

/system以下がread onlyになっていたら再マウントする必要がある。最初にmountを叩いてどのデバイスがsystemにマウントされているか確認して再マウントしよう。

<pre>
# mount
# mount -o remount,rw /dev/block/stl9 /system
</pre>

インストールするフォントはadbからpushするなり、USB接続してコピペするなりして転送する。僕は一旦/sdcardに置いてから、busyboxのcpで/system/fontsに移した(mvだとうまく出来なかったので)。busyboxはマーケットからインストールすることが出来る。日本語のフォントはサイズが大きいのでrenameしたものを3つ用意するよりは1つ置いてシンボリックリンクを貼るといい。リンク先は必ずsystem以下に置こう。/sdcard以下だとUSB接続した時とかにリンクが切れて、フォントを見つけられなくなったGalaxy Tabが延々と再起動を繰り返したりしてリセットせざるを得なくなる。

<pre>
# busybox cp /sdcard/TakaoGothic.ttf /system/fonts/
# cd /system/fonts
# ln -s TakaoGothic.ttf DroidSansJapanese.ttf
</pre>

これで端末の方でフォントを「標準フォント」に変更すればOK。

<h2>全体的な使用感</h2>
これもまた比較する端末がHT-03Aになるので何とも言えないけど、少なくともそこそこ快適に動作する。特にもたつきもないので、HT-03Aが余計に苦痛に感じられる程。画面サイズはTwitterやFacebook、Gmailなどのアプリを使うには非常に快適で、ブラウザでPCサイトも拡大・縮小がピンチイン・ピンチアウトでラクなのでそこそこ快適。ネットする程度ならPC起動する必要がないぐらい。ニコニコ動画はブラウザでもアプリでも見れてない。ブラウザはFlashがうまくうごいてない気がする。アプリはローディングが遅い(最初に全部読み込もうとしてるっぽい)から挫折しただけでもしかしたらちゃんと見れるかもしれない。

そんな感じでGalaxy Tabは非常に満足している。今はちょうどキャンペーン中で4万しないぐらいで購入できた。値段的には割引価格後で個人的にはちょうどいいかなぁって感じ。もし買うなら今だし、買わないならせっかくなら他のタブレットが販売されるのを待った方がいいかもしれない。