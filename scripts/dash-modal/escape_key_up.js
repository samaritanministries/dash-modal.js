namespace("DashModal")

window.DashModal.EscapeKeyUp = class {

  constructor() {
    this._handleKeyup = this.handleKeyup.bind(this)
  }

  respondWith(callback) {
    this.callback = callback
    $(document).bind("keyup", this._handleKeyup)
  }

  removeListeners() {
    $(document).unbind("keyup", this._handleKeyup)
  }

  handleKeyup(event) {
    if (event.keyCode == DashModal.EscapeKeyUp.ESCAPE_KEY_CODE) {
      this.callback()
    }
  }

}

DashModal.EscapeKeyUp.ESCAPE_KEY_CODE = 27
