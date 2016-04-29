exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js"
    },
    stylesheets: {
      joinTo: "css/app.css"
    },
    templates: {
      joinTo: "js/app.js"
    }
  },

  conventions: {
    assets: /^(web\/static\/assets)/
  },

  paths: {
    watched: [
      "web/static",
      "test/static"
    ],

    public: "priv/static"
  },

  plugins: {
    babel: {
      ignore: [/web\/static\/vendor/]
    },
    postcss: {
      processors: [
        require("autoprefixer")
      ],
    },
    sass: {
      options: {
        includePaths: [
          "node_modules/bourbon/app/assets/stylesheets",
          "node_modules/bourbon-neat/app/assets/stylesheets",
          "node_modules/normalize.css",
          "node_modules/trix/dist",
        ]
      },
    },
  },

  modules: {
    autoRequire: {
      "js/app.js": ["web/static/js/app"]
    }
  },

  npm: {
    enabled: true,
    globals: {$: 'jquery', jQuery: 'jquery'},
  }
};
