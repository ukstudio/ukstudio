const dayjs = require('dayjs')
dayjs.locale('ja')

module.exports = function(eleventyConfig) {
    const markdownIt = require('markdown-it');
    const markdownItOptions = {
        html: true,
        linkify: true
    };

    const md = markdownIt(markdownItOptions)
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

    eleventyConfig.addFilter("formatDate", (date,format) => {
      return dayjs(date).format(format)
    });
}
