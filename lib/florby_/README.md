# Florby

Florby is a static site generator that converts Markdown files to HTML. It's specifically designed for Digital Gardens.

## Features

- Markdown to HTML conversion
- Wiki-link notation support
- Automatic sitemap generation
- File change watching functionality
- Development server

## Installation

```bash
$ gem install florby
```

Or add to your Gemfile:

```ruby
gem 'florby'
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

### Server

To start the development server:

```bash
$ florby server
```

To start the development server with file watching (auto rebuild):

```bash
$ florby server --watch
```

### Watch

To watch for file changes and automatically rebuild:

```bash
$ florby watch
```

## Configuration

You can create a `config.rb` file in your project root as a configuration file.

```ruby
host 'https://ukstudio.jp'

copy_from '/assets'
copy_from 'robots.txt'
copy_from 'CNAME'
```

## License

See the [LICENSE](./LICENSE) file.

