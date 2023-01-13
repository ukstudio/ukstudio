const sitemap = require("@quasibit/eleventy-plugin-sitemap")

const emoji = require('markdown-it-emoji')

const debug = require('debug')('myapp')

const dayjs = require('dayjs')
const utc = require('dayjs/plugin/utc')
const timezone = require('dayjs/plugin/timezone')

dayjs.extend(utc)
dayjs.extend(timezone)
dayjs.tz.setDefault("Asia/Tokyo")

dayjs.locale('ja')

module.exports = function(eleventyConfig) {
  const markdownIt = require('markdown-it');
  const markdownItOptions = {
    html: true,
    linkify: true
  };

  const md = markdownIt(markdownItOptions)
    .use(emoji)
    .use(function(md) {
      // Recognize Mediawiki links ([[text]])
      md.linkify.add("[[", {
        validate: /^\s?([^\[\]\|\n\r]+)(\|[^\[\]\|\n\r]+)?\s?\]\]/,
        normalize: match => {
          const parts = match.raw.slice(2,-2).split("|");
          parts[0] = parts[0].replace(/.(md|markdown)\s?$/i, "");
          match.text = (parts[1] || parts[0]).trim();
          match.url = `/${parts[0].trim()}/`;
        }
      })
    })

  eleventyConfig.setLibrary('md', md);
  eleventyConfig.addPassthroughCopy('assets');
  eleventyConfig.addPassthroughCopy('CNAME');

  eleventyConfig.addCollection("notes", function (collection) {
    return collection.getFilteredByGlob(["notes/**/*.md", "index.md"]);
  });

  // https://boehs.org/node/11ty-aliases
  eleventyConfig.addCollection('redirects', function (collection) {
    let redirects = [];
    const notes = collection.getFilteredByGlob('notes/**/*.md')
    notes.forEach(function(note) {
      (note.data.aliases || []).forEach(alias => redirects.push([note.url, alias]))
    })
    return redirects
  });

  eleventyConfig.addFilter("formatDate", (date,format) => {
    return dayjs(date).tz().format(format)
  });

  eleventyConfig.addPlugin(sitemap, {
    sitemap: {
      lastModifiedProperty: "updated",
      hostname: "https://ukstudio.jp",
    },
  });
}
