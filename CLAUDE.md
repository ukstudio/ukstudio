# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## コマンド

### ビルド
```bash
florby build
```

### 開発サーバー
```bash
florby server          # 通常のサーバー起動
florby server --watch  # ファイル監視機能付きで起動
```

### ファイル監視
```bash
florby watch  # ファイル変更を検知して自動ビルド
```

### デプロイ
```bash
npm run deploy  # GitHubページへのデプロイ
```

## アーキテクチャ概要

このプロジェクトは、Markdownファイルから静的サイトを生成するDigital Garden専用の静的サイトジェネレータ「Florby」を使用しています。

### 主要ディレクトリ構造
- `src/` - Markdownファイル、アセット、スタイルシートなどのソースファイル
- `_build/` - 生成されたHTMLファイル（Florbyによって自動生成）
- `lib/florby/` - Florbyジェネレータ本体（Gem形式）
- `layouts/` - HTMLレイアウトテンプレート（ERB形式）

### Florbyの主要コンポーネント
- `Builder` - MarkdownからHTMLへの変換とサイト生成
- `Server` - 開発サーバー機能
- `Watcher` - ファイル変更の監視と自動ビルド
- `Renderer` - Markdown処理とWikiリンク記法のサポート
- `Config` - 設定ファイル（config.rb）の読み込み

### 設定
`config.rb`で以下の設定が可能:
- `host` - サイトのホストURL
- `copy_from` - ビルド時にコピーするファイル/ディレクトリの指定