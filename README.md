#dash-modal.js

#Setup
* install node/npm
* npm install
* bower install
* npm install testem -g

#Tests
Run ```testem```

#Usage
The scss/css and minified js files are in the dist/ directory.

Example:

```
new DashModal({
	view: SomeBackboneView(),
	modalSize: 'a-class-to-set-size',
	shouldAllowClose: true or false,
	onCloseCallback: function(){executes after close happens}
}).show()
```

The modal will apply classes to the ```body``` element to prevent scrolling, and expects a dom element of: ```<div data-id="modal-container"></div>```

MIT License
