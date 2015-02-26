(function(underscore) {
  'use strict';

  window.namespace = function(string) {
    var current = window,
        names = string.split('.'),
        name;

    while((name = names.shift())) {
      current[name] = current[name] || {};
      current = current[name];
    }

  };
}(window._));
