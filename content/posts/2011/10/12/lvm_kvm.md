---
aliases:
- /2011/10/12/lvm_kvm
date: "2011-10-12"
title: LVMを使っているKVMのディスクイメージの容量を追加する
---
KVMのディスクイメージの容量を増やしたのでメモ。

<h2>イメージファイルの拡張</h2>
まずはイメージのフォーマットを確認する。qemu-imgのinfoでわかる。

<pre>$ qemu-img info vm.img</pre>

今回はqcow2になっていたのでrawに変換する。

<pre>$ qemu-img convert -f qcow2 vm.img -O raw vm.raw</pre>

ddのseekを使って末尾に領域を追加する。10GBのイメージに5GB追加するならこんな感じ。

<pre>$ dd if=/dev/zero ov=vm.raw bs=1G count=5 seek=10</pre>

フォーマットを元に戻す。

<pre>$ qemu-img convert -f raw vm.raw -O qcow2 vm.img</pre>

<h2>仮想マシンのパーティションの修正</h2>
その後、イメージを立ち上げてパーティションを修正する。今回のパーティションは/dev/hda1がboot、/dev/hda2がlvmになっていたので/dev/hda2の方を修正する。

<pre>$ fdisk /dev/hda
> d
> 2 # /dev/hda2を一旦削除
> n
> p
> 2
> Enter
> Enter # /dev/hda2を作りなおす。デフォルトでサイズが拡大するはず。
> t
> 2
> 8e # /dev/hda2のパーティションタイプをLVMにする
> w
> q # 書きこんで終了
$ reboot
</pre>

<h2>ボリュームの追加</h2>
<pre>$ vgextend VolGroup00 /dev/sda2
$ lvextend -L +5GB /dev/VolGroup00/LogVol00
$ resize2fs /dev/VolGroup00/LogVol00
</pre>

思い出しながら書いてるから細かいところで違うかもしれないけど、だいたいこんな感じで容量の追加が完了。