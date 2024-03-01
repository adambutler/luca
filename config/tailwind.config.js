const defaultTheme = require("tailwindcss/defaultTheme");

module.exports = {
  content: [
    "./public/*.html",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/views/**/*.{erb,haml,html,slim}",
    "./app/components/**/*.{erb,haml,html,slim,rb}",
    "./lookbook/previews/**/*.{erb,haml,html,slim}",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
  safelist: [
    // Badges
    {
      pattern: /bg-(emerald|yellow|blue)-(300)/,
    },
    {
      pattern: /text-(emerald|yellow|blue)-(800)/,
    },
    // Buttons
    {
      pattern: /bg-(purple|blue|slate|red)-(600)/,
    },
    {
      pattern: /bg-(purple|blue|slate|red)-(700)/,
      variants: ["hover"],
    },
  ],
};
