#dash-modal.js
[![Build Status](https://travis-ci.org/samaritanministries/dash-modal.js.svg?branch=master)](https://travis-ci.org/samaritanministries/dash-modal.js)

####This is the modal for the Dash platform.

# Releasing a New Version

Steps to release a new version:

1. Update the [change log](/CHANGELOG.md).
2. Run `./bower_deploy.sh`

#Setup
* install node/npm
* npm install
* bower install
* npm install testem -g

#Tests
Run ```testem```

For more documentation, visit our [documentation site](http://developers.samaritanministries.org/developers/dash-modal.js/)

#HTML Template Usage

Your HTML template should include the following HTML structure:

```
  <div class="modal-header"><h2>This is a modal title</h2></div>
  <div class="modal-content"><p>Some really cool modal content!</p></div>
  <div class="modal-header"><button>Do stuff</button></div>
```

#Running the sample

1. `grunt build:dist`
1. `open app/index.html`

#License
MIT License
