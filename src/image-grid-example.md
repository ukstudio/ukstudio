---
title: "画像を横に並べる例"
---

## 画像を2枚横に並べる方法

### 方法1: 通常のグリッド表示

画像の高さが異なっても、それぞれの高さを保ちながら横に並べます。

<div class="image-grid">
  <img src="/assets/images/sample1.jpg" alt="画像1">
  <img src="/assets/images/sample2.jpg" alt="画像2">
</div>

### 方法2: 同じ高さで表示

画像を300pxの高さで統一して表示します。

<div class="image-grid-equal">
  <img src="/assets/images/sample3.jpg" alt="画像3">
  <img src="/assets/images/sample4.jpg" alt="画像4">
</div>

### 使い方

1. **通常のグリッド**: `<div class="image-grid">`で画像を囲む
   - 画像の元の高さを保持
   - モバイルでは縦に並ぶ

2. **高さを揃える**: `<div class="image-grid-equal">`で画像を囲む
   - 高さ300pxで統一
   - 画像は自動的にトリミング（object-fit: cover）
   - モバイルでは縦に並ぶ

### 3枚以上並べたい場合

CSSをカスタマイズして、3列や4列のグリッドも作成できます。