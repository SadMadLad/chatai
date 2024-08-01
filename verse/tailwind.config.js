/** @type {import('tailwindcss').Config} */

const defaultTheme = require("tailwindcss/defaultTheme");
const colors = require("tailwindcss/colors");
const containerQueries = require("@tailwindcss/container-queries");

export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx,vue}"],
  theme: {
    colors: {
      primary: colors.fuchsia,
      secondary: colors.pink,
      ...colors,
    },
    extend: {
      fontFamily: {
        sans: ["Inter", ...defaultTheme.fontFamily.sans],
        serif: ["Yeseva One", ...defaultTheme.fontFamily.serif],
        cursive: ["Playwrite IT Moderna", ...defaultTheme.fontFamily.serif],
      },
    },
  },
  plugins: [containerQueries],
};
