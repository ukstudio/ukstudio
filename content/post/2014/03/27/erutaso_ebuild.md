---
title: lsと間違えてerutasoを打ってしまうGentoo/Funtooユーザーのみなさまへ

tags: ebuild,gentoo,funtoo
date: 2014-03-27
---

[ebuild](https://github.com/ukstudio/ukstudio-overlay/tree/master/app-shells/erutaso/)を作ってみましたのでご活用ください。初めてのebuildなので不具合・不都合あればpull-reqを。ukstudioというoverlayを作りましたのでそこからインストールできるはずです。

[https://github.com/ukstudio/ukstudio-overlay](https://github.com/ukstudio/ukstudio-overlay)

```shell
curl https://raw.github.com/ukstudio/ukstudio-overlay/master/profiles/layman.xml > /etc/layman/overlays/ukstudio-overlay.xml
layman -f -a ukstudio

emerge erutaso
which erutaso #=> /usr/bin/erutaso

erutaso
```

## See also

[https://twitter.com/sgymtic/status/448832543039574016](https://twitter.com/sgymtic/status/448832543039574016)