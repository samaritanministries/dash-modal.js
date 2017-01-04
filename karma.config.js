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
      "scripts/sample_app/main.js",
      "spec/spec_helper.js",
      {pattern: "spec/**/*_spec.js", watched: false, included: true, served: true},
      {pattern: "spec/**/*_spec.coffee", watched: false, included: true, served: true}
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
    webpack: webpackConfig,
    webpackMiddleware: {
      noInfo: true,
      stats: {
        chunks: false
      }
    },
  });
};
