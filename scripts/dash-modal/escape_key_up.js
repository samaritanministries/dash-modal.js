export const ESCAPE_KEY_CODE = 27

export default class {

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
    if (event.keyCode == ESCAPE_KEY_CODE) {
      this.callback()
    }
  }

}
