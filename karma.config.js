var webpack = require("karma-webpack");
var webpackConfig = require("./webpack.config");

webpackConfig.entry = undefined
module.exports = function (config) {
  config.set({
    frameworks: [ "jasmine" ],
    files: [
      "bower_components/underscore/underscore.js",
      "bower_components/jquery/dist/jquery.js",
      "bower_components/backbone/backbone.js",

      "scripts/namespace.js",
      "scripts/dash-modal/templates.js",
      "scripts/dash-modal/foo.js",
      "scripts/dash-modal/foo_view.coffee",
      "spec/dash-modal/foo_spec.coffee"
    ],
    plugins: [
      "karma-jasmine",
      "karma-phantomjs-launcher",
      "karma-spec-reporter",
      webpack
    ],
    browsers: [ "PhantomJS" ],
    preprocessors: {
      "spec/**/*.js": ["webpack"],
      "scripts/**/*.js": ["webpack"],
      "spec/**/*.coffee": ["webpack"],
      "scripts/**/*.coffee": ["webpack"]
    },
    logLevel: config.LOG_INFO,
    reporters: ["spec"],
    singleRun: false,
    phantomjsLauncher: {
      exitOnResourceError: true
    },
    webpack: webpackConfig
  });
};
