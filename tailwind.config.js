const defaultTheme = require('tailwindcss/defaultTheme')

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./_site/**/*.html"],
  theme: {
    extend: {
      fontFamily: {
        'sans': ['Noto Sans JP', 'Helvetica Neue', 'Arial', 'Hiragino Kaku Gothic ProN', 'Hiragino Sans', 'Meiryo', 'sans-serif', ...defaultTheme.fontFamily.sans]
      },
    },
  },
  plugins: [],
}
