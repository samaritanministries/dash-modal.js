namespace("DashModal")

class DashModal.EscapeKeyUp

  @ESCAPE_KEY_CODE = 27

  respondWith: (callback) ->
    @callback = callback
    $(document).bind 'keyup', @handleKeyup

  removeListeners: () ->
    $(document).unbind 'keyup', @handleKeyup

  handleKeyup: (event) =>
    if event.keyCode == DashModal.EscapeKeyUp.ESCAPE_KEY_CODE
      @callback()
