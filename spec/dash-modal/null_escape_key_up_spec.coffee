import NullEscapeKeyUp from "dash_modal/null_escape_key_up.js"

describe "NullEscapeKeyUp", ->

  nullObject = ->
    new NullEscapeKeyUp()

  it "implements respondWith", ->
    expect(nullObject().respondWith).not.toThrow()

  it "implements removeListeners", ->
    expect(nullObject().removeListeners).not.toThrow()
