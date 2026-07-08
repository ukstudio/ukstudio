# Florby

Florby is a static site generator that converts Markdown files to HTML. It's specifically designed for Digital Gardens.

## Features

- Markdown to HTML conversion (CommonMark)
- Wiki-link notation: `[[title]]` and `[[title|label]]`, with automatic backlinks
- Tag pages generated from front matter `tags`
- Draft pages excluded from builds by default
- Atom feed (`/feed.xml`) and sitemap (`/sitemap.xml`) generation
- Alias redirect pages for moved URLs
- Development server with file watching

## Installation

Add to your Gemfile:

```ruby
gem 'florby', path: './lib/florby'
```

And then execute:

```bash
$ bundle install
```

## Usage

### Build

To generate HTML files from Markdown:

```bash
$ florby build
```

To include pages marked as `draft: true`:

```bash
$ florby build --drafts
```

### Server

To start the development server (builds once on startup, serves on port 8081):

```bash
$ florby server
```

To rebuild automatically on file changes, preview drafts, or change the port:

```bash
$ florby server --watch
$ florby server --watch --drafts
$ florby server --port 3000
```

### Watch

To watch for file changes and automatically rebuild without serving:

```bash
$ florby watch
```

## Configuration

You can create a `config.rb` file in your project root as a configuration file.

```ruby
host 'https://ukstudio.jp'          # required
title 'ukstudio'                    # used in feed and OGP
description 'A personal site'       # used in feed
author 'Yuki Akamatsu'              # used in feed
og_image 'https://example.com/og.png'

copy_from '/assets'
copy_from 'robots.txt'
copy_from 'CNAME'

# defaults: source_dir 'src', output_dir '_build', layouts_dir 'layouts'
```

## Front matter

```yaml
---
title: My note          # defaults to the file name
permalink: /my-note/    # defaults to /<title>/
created: 2024-01-01     # defaults to the file's birthtime
updated: 2024-06-01     # defaults to the file's mtime
tags: [Ruby]            # generates /tags/Ruby/ (requires layouts/tag.erb)
draft: true             # excluded from builds unless --drafts
aliases:
  - /old-url/           # writes a redirect page at /old-url/
exclude_from_collections: true  # hidden from listings, feed and backlink sources
layout: default         # ERB layout name in layouts/
description: Summary    # defaults to an excerpt of the body
---
```

## Layouts

Layouts are ERB templates in `layouts/`. They can use:

- `page` — the current page
- `site` — all pages, `site.backlinks(page)`, `site.tags`
- `config` — the loaded configuration
- `content` — the current page's HTML (`content(other_page)` renders another page)
- `h(text)` — HTML escape helper

`layouts/tag.erb` additionally receives `tag` and `pages`.

## Testing

```bash
$ bundle exec rake test
```

## License

See the [LICENSE](./LICENSE) file.
