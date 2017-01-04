import EscapeKeyUp, {ESCAPE_KEY_CODE} from "dash_modal/escape_key_up.js"

describe("EscapeKeyUp", () => {

  describe("Listening to key up events", () => {

    var keyUpEvent = () => {
      return new EscapeKeyUp()
    }

    var pressEscape = () => {
      var event = jQuery.Event('keyup')
      var enterKeyCode = ESCAPE_KEY_CODE
      event.keyCode = enterKeyCode
      $(document).trigger(event)
    }

    it("exposes the key code", () => {
      expect(ESCAPE_KEY_CODE).toEqual(27)
    })

    it("triggers the callback on ESCAPE", () => {
      var _keyUpEvent = keyUpEvent()

      var callback = jasmine.createSpy("On ESCAPE callback")
      _keyUpEvent.respondWith(callback)

      pressEscape()

      expect(callback).toHaveBeenCalled()
    })

    it("does not trigger the callback until ESCAPE has been pressed", () => {
      var _keyUpEvent = keyUpEvent()

      var callback = jasmine.createSpy("On ESCAPE callback")
      _keyUpEvent.respondWith(callback)

      expect(callback).not.toHaveBeenCalled()
    })

    it("does not impact other keyup listeners", () => {
      var _keyUpEvent = keyUpEvent()

      var preExistingCallBack = jasmine.createSpy("On ESCAPE callback")
      $(document).bind("keyup", preExistingCallBack)
      _keyUpEvent.respondWith(() => {})
      _keyUpEvent.removeListeners()

      pressEscape()

      expect(preExistingCallBack).toHaveBeenCalled()
    })

    it("can stop listening without having triggered", () => {
      var _keyUpEvent = keyUpEvent()

      var callback = jasmine.createSpy("On ESCAPE callback")
      _keyUpEvent.respondWith(callback)

      _keyUpEvent.removeListeners()

      pressEscape()
      expect(callback).not.toHaveBeenCalled()
    })

  })

})
