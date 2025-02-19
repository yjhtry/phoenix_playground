// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration

const plugin = require("tailwindcss/plugin")
const fs = require("fs")
const path = require("path")

module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/phoenix_playground_web.ex",
    "../lib/phoenix_playground_web/**/*.*ex"
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: [
          // "system-ui",
          "-apple-system",
          // "BlinkMacSystemFont",
          "Segoe UI",
          "Roboto",
          "Helvetica Neue",
          "Arial",
          "Noto Sans",
          "sans-serif",
          "Apple Color Emoji",
          "Segoe UI Emoji",
          "Segoe UI Symbol",
          "Noto Color Emoji",
        ],
      },
      fontSize: {
        xs: '0.75rem',
        sm: '0.875rem',
        base: '1rem',
        lg: '1.125rem',
        xl: '1.25rem',
        '2xl': '1.5rem',
        '3xl': '1.875rem',
        '4xl': '2.25rem',
        '5xl': '3rem',
        '6xl': '4rem',
      },
      colors: {
        transparent: 'transparent',
        white: '#ffffff',
        black: '#000000',
        brand: "#FD4F00",
        gray: {
          '50': '#f9fafb',
          '100': '#f4f5f7',
          '200': '#e5e7eb',
          // '200': '#ebecf0',
          '300': '#d2d6dc',
          '400': '#9fa6b2',
          '500': '#6b7280',
          '600': '#4b5563',
          '700': '#374151',
          '800': '#252f3f',
          '900': '#161e2e',
        },
        'cool-gray': {
          '50': '#f8fafc',
          '100': '#f1f5f9',
          '200': '#e2e8f0',
          '300': '#cfd8e3',
          '400': '#97a6ba',
          '500': '#64748b',
          '600': '#475569',
          '700': '#364152',
          '800': '#27303f',
          '900': '#1a202e',
        },
        red: {
          '50': '#fdf2f2',
          '100': '#fde8e8',
          '200': '#fbd5d5',
          '300': '#f8b4b4',
          '400': '#f98080',
          '500': '#f05252',
          '600': '#e02424',
          '700': '#c81e1e',
          '800': '#9b1c1c',
          '900': '#771d1d',
        },
        orange: {
          '50': '#fff8f1',
          '100': '#feecdc',
          '200': '#fcd9bd',
          '300': '#fdba8c',
          '400': '#ff8a4c',
          '500': '#ff5a1f',
          '600': '#d03801',
          '700': '#b43403',
          '800': '#8a2c0d',
          '900': '#73230d',
        },
        yellow: {
          '50': '#fdfdea',
          '100': '#fdf6b2',
          '200': '#fce96a',
          '300': '#faca15',
          '400': '#e3a008',
          '500': '#c27803',
          '600': '#9f580a',
          '700': '#8e4b10',
          '800': '#723b13',
          '900': '#633112',
        },
        green: {
          '50': '#f3faf7',
          '100': '#def7ec',
          '200': '#bcf0da',
          '300': '#84e1bc',
          '400': '#31c48d',
          '500': '#0e9f6e',
          '600': '#057a55',
          '700': '#046c4e',
          '800': '#03543f',
          '900': '#014737',
        },
        teal: {
          '50': '#edfafa',
          '100': '#d5f5f6',
          '200': '#afecef',
          '300': '#7edce2',
          '400': '#16bdca',
          '500': '#0694a2',
          '600': '#047481',
          '700': '#036672',
          '800': '#05505c',
          '900': '#014451',
        },
        blue: {
          '50': '#ebf5ff',
          '100': '#e1effe',
          '200': '#c3ddfd',
          '300': '#a4cafe',
          '400': '#76a9fa',
          '500': '#3f83f8',
          '600': '#1c64f2',
          '700': '#1a56db',
          '800': '#1e429f',
          '900': '#233876',
        },
        indigo: {
          '50': '#f0f5ff',
          '100': '#e5edff',
          '200': '#cddbfe',
          '300': '#b4c6fc',
          '400': '#8da2fb',
          '500': '#6875f5',
          '600': '#5850ec',
          '700': '#5145cd',
          '800': '#42389d',
          '900': '#362f78',
        },
        purple: {
          '50': '#f6f5ff',
          '100': '#edebfe',
          '200': '#dcd7fe',
          '300': '#cabffd',
          '400': '#ac94fa',
          '500': '#9061f9',
          '600': '#7e3af2',
          '700': '#6c2bd9',
          '800': '#5521b5',
          '900': '#4a1d96',
        },
        pink: {
          '50': '#fdf2f8',
          '100': '#fce8f3',
          '200': '#fad1e8',
          '300': '#f8b4d9',
          '400': '#f17eb8',
          '500': '#e74694',
          '600': '#d61f69',
          '700': '#bf125d',
          '800': '#99154b',
          '900': '#751a3d',
        },
      }
    }
  },
  plugins: [
    require("@tailwindcss/forms"),
    // Allows prefixing tailwind classes with LiveView classes to add rules
    // only when LiveView classes are applied, for example:
    //
    //     <div class="phx-click-loading:animate-ping">
    //
    plugin(({ addVariant }) => addVariant("phx-click-loading", [".phx-click-loading&", ".phx-click-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-submit-loading", [".phx-submit-loading&", ".phx-submit-loading &"])),
    plugin(({ addVariant }) => addVariant("phx-change-loading", [".phx-change-loading&", ".phx-change-loading &"])),

    // Embeds Heroicons (https://heroicons.com) into your app.css bundle
    // See your `CoreComponents.icon/1` for more information.
    //
    plugin(function ({ matchComponents, theme }) {
      let iconsDir = path.join(__dirname, "../deps/heroicons/optimized")
      let values = {}
      let icons = [
        ["", "/24/outline"],
        ["-solid", "/24/solid"],
        ["-mini", "/20/solid"],
        ["-micro", "/16/solid"]
      ]
      icons.forEach(([suffix, dir]) => {
        fs.readdirSync(path.join(iconsDir, dir)).forEach(file => {
          let name = path.basename(file, ".svg") + suffix
          values[name] = { name, fullPath: path.join(iconsDir, dir, file) }
        })
      })
      matchComponents({
        "hero": ({ name, fullPath }) => {
          let content = fs.readFileSync(fullPath).toString().replace(/\r?\n|\r/g, "")
          let size = theme("spacing.6")
          if (name.endsWith("-mini")) {
            size = theme("spacing.5")
          } else if (name.endsWith("-micro")) {
            size = theme("spacing.4")
          }
          return {
            [`--hero-${name}`]: `url('data:image/svg+xml;utf8,${content}')`,
            "-webkit-mask": `var(--hero-${name})`,
            "mask": `var(--hero-${name})`,
            "mask-repeat": "no-repeat",
            "background-color": "currentColor",
            "vertical-align": "middle",
            "display": "inline-block",
            "width": size,
            "height": size
          }
        }
      }, { values })
    })
  ]
}
