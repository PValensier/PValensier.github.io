const typeset = require('typeset');

module.exports = function (eleventyConfig) {
  eleventyConfig.addFilter("typeset", typeset);
  eleventyConfig.addPassthroughCopy({
    "src/img": "img",
    "src/css": "css",
    "src/fonts": "fonts",
  });
  return {
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
    dir: {
      data: "data",
      layouts: "layouts",
      output: "_site"
    }
  }
};