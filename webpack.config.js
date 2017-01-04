var webpack = require("webpack");
var path = require("path")

const PROJECT_ROOT = path.resolve(__dirname)

module.exports = {
  entry: {
    "dist/dash-modal.js": "./scripts/dash-modal/load.js",
    ".tmp/sample_app.js": "./scripts/sample_app/main.js",
    ".tmp/dash-modal-with-dashing.css": "./styles/dash-modal-with-dashing.scss"
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
        loader: "babel",
        test: /\.js$/
      }, {
        include: [
          path.join(PROJECT_ROOT, "scripts"),
          path.join(PROJECT_ROOT, "spec")
        ],
        loader: "ejs-compiled",
        test: /\.ejs$/
      },
      {
        include: path.join(PROJECT_ROOT, "styles"),
        loader: "style!css!sass",
        test: /\.scss$/
      }
    ]
  },
  plugins: [
    new webpack.ProvidePlugin({
      _: "underscore",
      $: "jquery"
    }),
    new webpack.ResolverPlugin(
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin(".bower.json", ["main"])
    )
  ],
  resolve: {
    alias: {
      "dash_modal": path.join(PROJECT_ROOT, "scripts", "dash-modal"),
      "fakes": path.join(PROJECT_ROOT, "spec", "fakes"),
      "sample_app": path.join(PROJECT_ROOT, "scripts", "sample_app"),
      "scripts": path.join(PROJECT_ROOT, "scripts")
    }, modulesDirectories: [
      path.join(PROJECT_ROOT, "node_modules"),
      path.join(PROJECT_ROOT, "bower_components")
    ]
  }
}
