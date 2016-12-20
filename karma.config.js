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
      "scripts/sample_app/show_modal.js",
      "scripts/sample_app/push_modal_view.coffee",
      "scripts/sample_app/modal_view.coffee",
      "scripts/sample_app/main.coffee",
      "spec/spec_helper.coffee",
      "spec/dash-modal/navigation/modal_spec.js",
      "spec/dash-modal/navigation/modal_stack_view_spec.coffee",
      "spec/dash-modal/escape_key_up_spec.coffee",
      "spec/dash-modal/view_spec.coffee",
      "spec/dash-modal/null_escape_key_up_spec.coffee"
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
