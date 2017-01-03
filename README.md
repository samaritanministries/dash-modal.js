# Dash Modal

[![Build Status](https://travis-ci.org/samaritanministries/dash-modal.js.svg?branch=master)](https://travis-ci.org/samaritanministries/dash-modal.js)
version badge

This is the modal for the Dash platform. It provides a basic modal as well as a Navigation Modal. Play around the sample app for examples.

## Installation

Dash Modal is delivered as a [bower](bower.io) component.

1. Install bower
  ```bash
  npm install -g bower
  ```

  >Note: Bower requires node, npm and git.

2. Create a `bower.json` file
  ```bash
  bower init
  ```

3. Install the dash-modal.js bower component and save it to your `bower.json` file
  ```bash
  bower install dash-modal.js --save
  ```

## Usage

For more documentation, visit our [documentation site](http://developers.samaritanministries.org/developers/dash-modal.js/)

Your HTML template should include the following HTML structure:

```
  <div class="modal-header"><h2>This is a modal title</h2></div>
  <div class="modal-content"><p>Some really cool modal content!</p></div>
  <div class="modal-footer"><button>Do stuff</button></div>
```

## Project Setup

### Dependencies

* install node/npm
* npm install
* bower install

### Running the Tests

For a single run of the tests:
`npm test`

To run the tests with a watcher:
`npm run karma`

### Running the Demo

1. `npm run webpack`
2. Open `app/index.html`

## Releasing a New Version

1. Update [the changelog](CHANGELOG.md)
2. Commit your changes
3. Run `./bower_deploy.sh`

## License

[MIT License](LICENSE.md)
