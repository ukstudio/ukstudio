---
title: GentooでCDをリッピングして聞く
date: 2012-09-11
aliases:
- /2012/09/11/ripping_cd_on_gentoo
---
メモ

CDをwavで一旦取り込んでflacに変換。
<pre>
$ sudo emerge cdrtools
$ sudo emerge flac
$ cdda2wav -H -B
$ find . -name "*.wav" -print0 | xargs -0 flac
</pre>


<pre>
# /etc/security/limits.conf
@audio - rtprio 99
@audio - memlock unlimited
@audio - nice -10
</pre>

<pre>
# /etc/portage/package.use
media-sound/aqualung alsa cdda cddb ffmpeg flac mp3 oss wavpack jack
media-sound/jack-audio-connection-kit alsa
</pre>

<pre>
# mplayer で聞く
$ mplayer *
# aqualung & jackで聞く
$ sudo emerge aqualung
$ sudo emerge jack-audio-connection-kit
$ jackd -R -d alsa
$ aqualung -o jack --auto
</pre>

正直、JACKで何が変わってるのかよーわからん。