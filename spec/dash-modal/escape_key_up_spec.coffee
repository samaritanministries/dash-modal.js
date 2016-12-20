import EscapeKeyUp, {ESCAPE_KEY_CODE} from "dash_modal/escape_key_up.js"

describe "EscapeKeyUp", ->

  describe "Listening to key up events", ->

    keyUpEvent = ->
      new EscapeKeyUp()

    pressEscape = () ->
      event = jQuery.Event('keyup')
      enterKeyCode = ESCAPE_KEY_CODE
      event.keyCode = enterKeyCode
      $(document).trigger(event)

    it "exposes the key code", ->
      expect(ESCAPE_KEY_CODE).toEqual(27)

    it "triggers the callback on ESCAPE", ->
      _keyUpEvent = keyUpEvent()

      callback = jasmine.createSpy("On ESCAPE callback")
      _keyUpEvent.respondWith(callback)

      pressEscape()

      expect(callback).toHaveBeenCalled()

    it "does not trigger the callback until ESCAPE has been pressed", ->
      _keyUpEvent = keyUpEvent()

      callback = jasmine.createSpy("On ESCAPE callback")
      _keyUpEvent.respondWith(callback)

      expect(callback).not.toHaveBeenCalled()

    it "does not impact other keyup listeners", ->
      _keyUpEvent = keyUpEvent()

      preExistingCallBack = jasmine.createSpy("On ESCAPE callback")
      $(document).bind 'keyup', preExistingCallBack
      _keyUpEvent.respondWith(->)
      _keyUpEvent.removeListeners()

      pressEscape()

      expect(preExistingCallBack).toHaveBeenCalled()

    it "can stop listening without having triggered", ->
      _keyUpEvent = keyUpEvent()

      callback = jasmine.createSpy("On ESCAPE callback")
      _keyUpEvent.respondWith(callback)

      _keyUpEvent.removeListeners()

      pressEscape()
      expect(callback).not.toHaveBeenCalled()
