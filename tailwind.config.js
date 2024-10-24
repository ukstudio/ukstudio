const defaultTheme = require('tailwindcss/defaultTheme')

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./_build/**/*.html"],
  theme: {
    extend: {
      fontFamily: {
        'sans': ['Helvetica Neue', 'Noto Sans CJK JP', 'Noto Sans JP', 'Segoe UI', 'sans-serif']
      },
    },
  },
  plugins: [],
}
