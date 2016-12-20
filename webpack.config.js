var webpack = require("webpack");
var path = require("path")

const PROJECT_ROOT = path.resolve(__dirname)

module.exports = {
  entry: {
    "dist/new-modal.js": [
      "./scripts/dash-modal/load_jquery.js",
      "./bower_components/underscore/underscore.js",
      "./bower_components/backbone/backbone.js",
      "./scripts/namespace.js",
      "./scripts/dash-modal/templates.js",
      "./scripts/dash-modal/load.js",
    ],
    ".tmp/sample_app.js": [
      "./scripts/namespace.js",
      "./scripts/sample_app/show_modal.js",
      "./scripts/sample_app/push_modal_view.coffee",
      "./scripts/sample_app/modal_view.coffee",
      "./scripts/sample_app/main.coffee",
    ]
  },
  output: {
    filename: "[name]"
  },
  module: {
    loaders:[
      {
        include: [
          path.join(PROJECT_ROOT, "scripts"),
          path.join(PROJECT_ROOT, "spec")
        ],
        loader: "babel-loader",
        test: /\.js$/
      }, {
        include: [
          path.join(PROJECT_ROOT, "scripts"),
          path.join(PROJECT_ROOT, "spec")
        ],
        loader: "babel!coffee",
        test: /\.coffee$/
      }, {
        include: [
          path.join(PROJECT_ROOT, "scripts"),
          path.join(PROJECT_ROOT, "spec")
        ],
        loader: "ejs-compiled",
        test: /\.ejs$/
      }
    ]
  },
  plugins: [
    new webpack.ProvidePlugin({
      _: "underscore"
    }),
    new webpack.ResolverPlugin(
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin(".bower.json", ["main"])
    )
  ],
  resolve: {
    alias: {
      "dash_modal": path.join(PROJECT_ROOT, "scripts", "dash-modal"),
      "fakes": path.join(PROJECT_ROOT, "spec", "fakes")
    }, modulesDirectories: [
      path.join(PROJECT_ROOT, "node_modules"),
      path.join(PROJECT_ROOT, "bower_components")
    ]
  }
}
