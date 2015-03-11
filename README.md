#dash-modal.js
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

#Usage
Via bower: ```bower install dash-modal.js```

The scss/css and minified js files are in the dist/ directory.

#####_This depends on Backbone being required.  It is not packaged together._

###DOM requirements
In order for the modal to show, it is expecting a dom element of: ```<div data-id="modal-container"></div>``` to exist on the page.  Putting it as the first element below the body is an easy and global way to set the modal's foothold.

The modal will apply classes to the ```body``` element to prevent scrolling when opened.

###Configurations
Example:

```
new DashModal({
  view: new SomeBackboneView(),
  modalSize: 'a-class-to-set-size',
  shouldAllowClose: true or false,
  shouldCloseOnEscape: true or false,
  onCloseCallback: function(){executes after close happens}
}).show()
```

view (Backbone.View): takes a backbone view.  It will render, and put the view's el into a modal container.

modalSize (string): the name of the css class that will be applied to the modal to set the dimensions

shouldAllowClose (bool): Allows the modal to be closed when the black overlay is clicked.  Passing in false will also remove the built-in "X" close button the modal would otherwise render

onCloseCallback (func): A function that gets executed after the modal is closed

After creating the DashModal, you must invoke ```show``` for it to populate the DOM and become visible.

###Events

If you have a use case where you want to close the modal after an action is taken on the view you pass in to be rendered, using Backbone's listenTo is useful.

The modal will listen for the view to trigger the "hideModal" event, and will hide the modal if triggered.

```
//assuming "this" is a backbone view that has been passed into the modal

this.trigger('hideModal')
```

#License
MIT License
