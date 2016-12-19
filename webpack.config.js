var webpack = require("webpack");
var path = require("path")

const PROJECT_ROOT = path.resolve(__dirname)

module.exports = {
  entry: [
    "./scripts/dash-modal/load_jquery.js",
    "./bower_components/underscore/underscore.js",
    "./bower_components/backbone/backbone.js",
    "./scripts/namespace.js",
    "./scripts/dash-modal/templates.js",
    "./scripts/dash-modal/escape_key_up.js",
    "./scripts/dash-modal/null_escape_key_up.js",
    "./scripts/dash-modal/view.js",

    "./scripts/dash-modal/navigation/modal_stack_view.js",
    "./scripts/dash-modal/navigation/modal.js",

    "./scripts/sample_app/show_modal.js",
    "./scripts/sample_app/push_modal_view.coffee",
    "./scripts/sample_app/modal_view.coffee",
    "./scripts/sample_app/main.coffee",

    "./scripts/dash-modal/bar.js",
    "./scripts/dash-modal/foo.js",
    "./scripts/dash-modal/foo_view.coffee",
    "./scripts/dash-modal/foo.coffee"
  ],
  output: {
    path: "./dist",
    filename: "new-modal.js"
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
