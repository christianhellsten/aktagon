const MarkdownIt = require('markdown-it');
const markdownItTocAndAnchor = require('markdown-it-table-of-contents');
const markdownItAnchor = require('markdown-it-anchor');

const md = new MarkdownIt({
  linkify: true,
  langPrefix: 'highlight-',
})
  .use(markdownItTocAndAnchor, { includeLevel: [1, 2, 3] })
  .use(markdownItAnchor);

module.exports = {
  filters: {
    'markdown-it': function (text) {
      return md.render(text);
    },
  },
};
