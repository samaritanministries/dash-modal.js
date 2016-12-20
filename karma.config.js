var webpack = require("karma-webpack");
var webpackConfig = require("./webpack.config");

webpackConfig.entry = undefined
module.exports = function (config) {
  config.set({
    frameworks: [ "jasmine" ],
    files: [
      "bower_components/jquery/dist/jquery.js",
      "bower_components/jasmine-jquery/lib/jasmine-jquery.js",

      "scripts/dash-modal/load.js",

      "scripts/namespace.js",
      "scripts/sample_app/main.coffee",
      "spec/spec_helper.coffee",
      "spec/**/*_spec.js",
      "spec/**/*_spec.coffee"
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
