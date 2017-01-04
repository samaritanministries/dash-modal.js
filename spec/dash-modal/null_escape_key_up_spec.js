import NullEscapeKeyUp from "dash_modal/null_escape_key_up.js"

describe("NullEscapeKeyUp", () => {

  it("implements respondWith", () => {
    expect(new NullEscapeKeyUp().respondWith).not.toThrow()
  })

  it("implements removeListeners", () => {
    expect(new NullEscapeKeyUp().removeListeners).not.toThrow()
  })

})
