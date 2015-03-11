describe "DashModal.NullEscapeKeyUp", ->

  nullObject = ->
    new DashModal.NullEscapeKeyUp()

  it "implements respondWith", ->
    expect(nullObject().respondWith).not.toThrow()

  it "implements removeListeners", ->
    expect(nullObject().removeListeners).not.toThrow()
