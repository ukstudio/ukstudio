# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## コマンド

### ビルド
```bash
bundle exec florby build            # サイトを _build/ に生成
bundle exec florby build --drafts   # draft: true のページも含める
```

### 開発サーバー
```bash
bundle exec florby server                    # 起動時に1回ビルドして :8081 で配信
bundle exec florby server --watch            # ファイル監視つき（変更で自動リビルド）
bundle exec florby server --watch --drafts   # 下書きプレビュー
bundle exec florby server --port 3000        # ポート変更
```

### ファイル監視
```bash
bundle exec florby watch  # ファイル変更を検知して自動ビルド
```

### テスト（florby本体）
```bash
cd lib/florby && bundle exec rake test
```

### CSS（Tailwind v4）
```bash
npm run css  # assets/styles.css → src/assets/stylesheets/styles.css を再生成
```
Tailwind v4 のCSSファースト設定を使用。設定はすべて `assets/styles.css` 内（`@theme` / `@source`）にあり、`tailwind.config.js` は存在しない。スキャン対象は `layouts/` と `src/**/*.md`（ソース側）なので、classを変えたら「npm run css → ビルド」の順で1回ずつでよい。

### デプロイ
```bash
npm run deploy  # CSS再生成 → ビルド → gh-pages で GitHub Pages へ
```

## アーキテクチャ概要

Markdownファイルから静的サイトを生成するDigital Garden専用ジェネレータ「Florby」を使用。Florby本体は `lib/florby/` にローカルgemとして置かれ、ルートの Gemfile から `path: './lib/florby'` で参照される。

### 主要ディレクトリ構造
- `src/` - Markdownファイル、アセットなどのソースファイル
- `_build/` - 生成されたHTMLファイル（Florbyによって自動生成、コミットしない）
- `lib/florby/` - Florbyジェネレータ本体（Gem形式、minitestのテストつき）
- `layouts/` - HTMLレイアウトテンプレート（ERB形式）
- `config.rb` - サイト設定

### Florbyの主要コンポーネント（lib/florby/lib/florby/）
- `Builder` - ビルドのオーケストレーション。全ドキュメントをメモリ上でレンダリングしてから書き出すため、ビルド失敗時に既存の `_build` は壊れない
- `Site` - 全ページの読み込み、ファイル名/タイトルでの検索、バックリンクグラフ、タグ索引
- `Page` - 1つのMarkdownファイル（イミュータブル）。frontmatterの解釈を担当
- `WikiLink` - `[[タイトル]]` / `[[タイトル|ラベル]]` 記法。コードブロック内は置換しない
- `MarkdownRenderer` - Commonmarker によるHTML変換とWikiリンク解決
- `Template` - ERBレイアウト描画。テンプレートからは `page` / `site` / `config` / `content` / `h`（エスケープ）が使える
- `Artifacts::{AtomFeed,Sitemap,AliasPage,TagPage}` - feed.xml / sitemap.xml / リダイレクトページ / タグページの生成
- `Server` / `Watcher` - 開発サーバーとポーリング式ファイル監視（ビルド失敗でも監視は継続）

### 設定（config.rb）
- `host` - サイトのホストURL（必須）
- `title` / `description` / `author` - サイト情報。feedやOGPで使用
- `og_image` - デフォルトのOGP画像URL
- `copy_from` - ビルド時に `src/` からコピーするファイル/ディレクトリ
- `source_dir` / `output_dir` / `layouts_dir` - 既定は `src` / `_build` / `layouts`

### frontmatter リファレンス
- `title` - ページタイトル（省略時はファイル名）
- `permalink` - URL（省略時は `/タイトル/`）
- `created` / `updated` - 日付（省略時はファイルのタイムスタンプ）
- `tags` - タグの配列。`/tags/<タグ>/` の一覧ページが生成される（layouts/tag.erb）
- `draft: true` - ビルドから除外（`--drafts` 指定時のみ出力）
- `aliases` - 旧URLの配列。meta refreshのリダイレクトページを生成
- `exclude_from_collections` - 一覧・feed・バックリンク元から除外（index.mdで使用）
- `layout` - レイアウト名（省略時は `default`）
- `description` - メタ説明文（省略時は本文冒頭から自動抜粋）
