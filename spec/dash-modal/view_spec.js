import Backbone from "backbone"
import EscapeKeyUp, {ESCAPE_KEY_CODE} from "dash_modal/escape_key_up.js"
import DashModalView from "dash_modal/view.js"

describe("DashModalView", () => {
  class TestView extends Backbone.View {
    initialize(options) {
      this.options = options
    }

    render() {
      this.$el.html(this.options.template)
      return this
    }
  }

  var buildView = (template) => {
    return new TestView({template: template})
  }

  var modalView = (options) => {
    return new DashModalView({
      view: options.view || buildView(),
      modalSize: options.modalSize || "modalSize",
      hasXButton: options.hasXButton,
      onCloseCallback: options.onCloseCallback,
      shouldCloseOnOverlay: options.shouldCloseOnOverlay,
      shouldCloseOnEscape:  options.shouldCloseOnEscape,
      preventScrollingOnClose: options.preventScrollingOnClose,
      router: options.router || new Backbone.Router()
    })
  }

  var assertHidden = (modal) => {
    expect(modal.$el).toContainElement("[data-id=modal]")
    expect(modal.$el).not.toContainElement(".in")
  }

  var assertVisible = (modal) => {
    expect(modal.$el).toContainElement("[data-id=modal].in")
  }

  var assertRemoved = (modal) => {
    expect($("body")).not.toContainElement("[data-id=modal]")
  }

  it("can hide itself", () => {
    var template = "<div>Hello</div>"
    var modal = modalView({view: buildView(template)}).show()
    assertVisible(modal)

    modal.hide()

    assertHidden(modal)
  })

  it("can remove itself", () => {
    var template = "<div>Hello</div>"
    var modal = modalView({view: buildView(template)}).show()

    assertVisible(modal)
    modal.remove()
    assertRemoved(modal)
  })

  it("knows when it is visible", () => {
    var template = "<div>Hello</div>"
    var view = buildView(template)
    var modal = modalView({view: view}).show()

    expect(modal.isVisible()).toBeTruthy()
  })

  it("knows when it is not visible", () => {
    var template = "<div>Hello</div>"
    var view = buildView(template)
    var modal = modalView({view: view}).show()
    modal.hide()

    expect(modal.isVisible()).toBeFalsy()
    modal.show()
    expect(modal.isVisible()).toBeTruthy()
  })

  it("hides when the overlay is clicked when shouldCloseOnOverlay is true", () => {
    var modal = modalView({shouldCloseOnOverlay: true})
    modal.show()

    assertVisible(modal)

    modal.$("[data-id=dash-overlay]").trigger("click")

    assertHidden(modal)
  })

  it("does NOT hide when overlay is clicked when shouldCloseOnOverlay is undefined", () => {
    var modal = modalView({router: "router"})
    modal.show()

    assertVisible(modal)

    modal.$("[data-id=dash-overlay]").trigger("click")
    assertVisible(modal)
  })

  it("does NOT hide when .modal-inner is clicked", () => {
    var template = "<div>Hello</div>"
    var modal = modalView({view: buildView(template)}).show()

    assertVisible(modal)

    modal.$("[data-id=modal]").trigger("click")
    assertVisible(modal)
  })

  it("when hasXButton is true, 'X' button to click is available to close", () => {
    var modal = modalView({hasXButton: true})
    modal.show()

    assertVisible(modal)

    modal.$("[data-id=close]").click()

    assertHidden(modal)
  })

  it("removes 'X', when hasXButton is false", () => {
    var modal = modalView({hasXButton: false})
    modal.show()

    expect(modal.$("[data-id=close]")).not.toExist()
  })

  it("takes an onCloseCallback and calls it on close click", () => {
    var callback = jasmine.createSpy("afterCloseCallback")
    var modal = modalView({
      hasXButton: true,
      onCloseCallback: callback
    })
    modal.show()

    modal.$("[data-id=close]").click()

    expect(callback).toHaveBeenCalled()
  })

  it("also calls it on overlay click", () => {
    var callback = jasmine.createSpy("afterCloseCallback")
    var modal = modalView({
      onCloseCallback: callback,
      shouldCloseOnOverlay: true
    })
    modal.show()

    modal.$("[data-id=dash-overlay]").click()

    expect(callback).toHaveBeenCalled()
  })

  it("does not re-render a view that is already rendered", () => {
    setFixtures("<div data-id=modal-container></div>")
    var template = "<input data-id='foo' type='text' value='Original'/>"
    var viewWithInput = buildView(template).render()
    viewWithInput.$("[data-id=foo]").val("Udpated")

    var modal = modalView({view: viewWithInput}).show()

    assertVisible(modal)
    expect($("[data-id=modal-container]").find("[data-id=foo]").val()).toEqual("Udpated")
  })

  it("can be shown a second time", () => {
    setFixtures("<div data-id=modal-container></div>")
    var view = buildView("Some Content").render()

    var modal = modalView({view: view})
    modal.show()
    modal.hide()
    modal.show()

    expect(modal.$el).toBeVisible()
  })

  it("adds a class to prevent scrolling when shown", () => {
    var template = "<div>Hello</div>"
    var modal = modalView({view: buildView(template)}).show()

    expect($("body")).toHaveClass("prevent-scrolling")
  })

  it("removes the prevent scrolling class when hidden", () => {
    var template = "<div>Hello</div>"
    var modal = modalView({view: buildView(template)}).show()

    modal.hide()

    expect($("body")).not.toHaveClass("prevent-scrolling")
  })

  it("does not remove prevent scrolling class with a preventScrollingOnClose option", () => {
    var template = "<div>Hello</div>"
    var modal = modalView({
      preventScrollingOnClose: true,
      view: buildView(template)
    }).show()

    modal.hide()

    expect($("body")).toHaveClass("prevent-scrolling")
  })

  describe("Listening for key events", () => {

    var pressEscape = () => {
      var event = jQuery.Event("keyup")
      enterKeyCode = ESCAPE_KEY_CODE
      event.keyCode = enterKeyCode
      $(document).trigger(event)
    }

    it("closes on ESC", () => {
      var modal = modalView({shouldCloseOnEscape: true})
      modal.show()

      pressEscape()

      assertHidden(modal)
    })

    it("removes the listener on hide", () => {
      var modal = modalView({shouldCloseOnEscape: true})
      modal.show()
      var removeListenersSpy = spyOn(modal.escapeKeyUp, "removeListeners")

      pressEscape()

      expect(removeListenersSpy).toHaveBeenCalled()
    })

    it("does not close on escape when configured not to", () => {
      var modal = modalView({shouldCloseOnEscape: false})
      modal.show()

      pressEscape()

      assertVisible(modal)
    })
  })

  describe("Showing a modal", () => {

    it("renders a view inside of a modal in the global modal-container", () => {
      setFixtures("<div data-id=modal-container></div>")
      var template = "<div>Hello</div>"

      var modal = modalView({view: buildView(template)}).show()

      expect($("[data-id=modal-container]").html()).toContain(template)
      assertVisible(modal)
    })

    it("sets up a listener for hiding on the passed in view", () => {
      var template = "<div>Hello</div>"
      var view = buildView(template)
      var modal = modalView({view: view}).show()

      assertVisible(modal)
      view.trigger("hideModal")
      assertHidden(modal)
    })

    it("appends the view modalSize class to modal container", () => {
      var template = "<div>Good Bye</div>"

      var modal = modalView({
        view: buildView(template),
        modalSize: "test-size"
      }).show()

      expect(modal.$("[data-id=modal]")).toBeMatchedBy(".test-size")
    })

    it("renders the view and modal inside a custom modal container when one is passed in", () => {
      setFixtures("<div data-id=custom-modal-container></div>")
      var template = "<div>Hello</div>"

      var modal = new DashModalView({
        container: $("[data-id=custom-modal-container]"),
        modalSize: "modalSize",
        view: buildView(template)
      })

      modal.show()

      expect($("[data-id=custom-modal-container]").html()).toContain(template)
    })

    it("moves focus to the view container to prevent iframe/ios scrolling issue", () => {
      setFixtures("<div data-id='modal-container'></div>")
      var template = "<div>Hello</div>"

      var modal = modalView({view: buildView(template)}).show()

      expect(modal.$("[data-id=view-container]").prop("tabindex")).toBeGreaterThan(0)
      expect(modal.$("[data-id=view-container]")).toBeFocused()
    })
  })
})
