const defaultTheme = require('tailwindcss/defaultTheme')

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./_site/**/*.html"],
  theme: {
    extend: {
      fontFamily: {
        'sans': ['Helvetica Neue', 'Arial', 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', 'Meiryo', 'sans-serif', ...defaultTheme.fontFamily.sans]
      }
    },
  },
  plugins: [],
}
