describe 'DashModal.View', ->
  class TestView extends Backbone.View
    initialize: (@options) ->

    render: ->
      @$el.html(@options.template)
      @

  buildView = (template) ->
    new TestView({template: template})

  modalView = (options) ->
    modal = new DashModal.View
      view:                 options.view ?= buildView()
      modalSize:            options.modalSize ?= 'modalSize'
      hasXButton:           options.hasXButton
      onCloseCallback:      options.onCloseCallback
      shouldCloseOnOverlay: options.shouldCloseOnOverlay
      shouldCloseOnEscape:  options.shouldCloseOnEscape
      preventScrollingOnClose: options.preventScrollingOnClose
      router:               options.router ?= new Backbone.Router()
    modal

  assertHidden = (modal) ->
    expect(modal.$el).toContainElement('[data-id=modal]')
    expect(modal.$el).not.toContainElement('.in')

  assertVisible = (modal) ->
    expect(modal.$el).toContainElement('[data-id=modal].in')

  assertRemoved = (modal) ->
    expect($('body')).not.toContainElement('[data-id=modal]')

  it 'can hide itself', ->
    template = '<div>Hello</div>'
    modal = modalView(view: buildView(template)).show()

    assertVisible(modal)
    modal.hide()
    assertHidden(modal)

  it 'can remove itself', ->
    template = '<div>Hello</div>'
    modal = modalView(view: buildView(template)).show()

    assertVisible(modal)
    modal.remove()
    assertRemoved(modal)

  it 'knows when it is visible', ->
    template = '<div>Hello</div>'
    view = buildView(template)
    modal = modalView(view: view).show()

    expect(modal.isVisible()).toBeTruthy()

  it 'knows when it is not visible', ->
    template = '<div>Hello</div>'
    view = buildView(template)
    modal = modalView(view: view).show()
    modal.hide()

    expect(modal.isVisible()).toBeFalsy()
    modal.show()
    expect(modal.isVisible()).toBeTruthy()

  it 'hides when the overlay is clicked when shouldCloseOnOverlay is true', ->
    modal = modalView
      shouldCloseOnOverlay: true
    modal.show()

    assertVisible(modal)

    modal.$('[data-id=dash-overlay]').trigger('click')

    assertHidden(modal)

  it 'does NOT hide when overlay is clicked when shouldCloseOnOverlay is undefined', ->
    modal = modalView
      router: "router"
    modal.show()

    assertVisible(modal)

    modal.$('[data-id=dash-overlay]').trigger('click')
    assertVisible(modal)

  it 'does NOT hide when .modal-inner is clicked', ->
    template = '<div>Hello</div>'
    modal = modalView(view: buildView(template)).show()

    assertVisible(modal)

    modal.$('[data-id=modal]').trigger('click')
    assertVisible(modal)

  it 'when hasXButton is true, "X" button to click is available to close', ->
    modal = modalView
      hasXButton: true
    modal.show()

    assertVisible(modal)

    modal.$('[data-id=close]').click()

    assertHidden(modal)

  it 'removes "X", when hasXButton is false', ->
    modal = modalView
      hasXButton: false
    modal.show()

    expect(modal.$('[data-id=close]')).not.toExist()

  it 'takes an onCloseCallback and calls it on close click', ->
    callback = jasmine.createSpy('afterCloseCallback')
    modal = modalView
      hasXButton: true
      onCloseCallback: callback
    modal.show()

    modal.$('[data-id=close]').click()

    expect(callback).toHaveBeenCalled()

  it 'also calls it on overlay click', ->
    callback = jasmine.createSpy('afterCloseCallback')
    modal = modalView
      shouldCloseOnOverlay: true
      onCloseCallback: callback
    modal.show()

    modal.$('[data-id=dash-overlay]').click()

    expect(callback).toHaveBeenCalled()

  it 'does not re-render a view that is already rendered', ->
    setFixtures('<div data-id=modal-container></div>')
    template = '<input data-id="foo" type="text" value="Original"/>'
    viewWithInput = buildView(template).render()
    viewWithInput.$("[data-id=foo]").val("Udpated")

    modal = modalView(view: viewWithInput).show()

    assertVisible(modal)
    expect($("[data-id=modal-container]").find("[data-id=foo]").val()).toEqual("Udpated")

  it "can be shown a second time", ->
    setFixtures('<div data-id=modal-container></div>')
    view = buildView('Some Content').render()

    modal = modalView(view: view)
    modal.show()
    modal.hide()
    modal.show()

    expect(modal.$el).toBeVisible()

  it 'adds a class to prevent scrolling when shown', ->
    template = '<div>Hello</div>'
    modal = modalView(view: buildView(template)).show()

    expect($('body')).toHaveClass('prevent-scrolling')

  it 'removes the prevent scrolling class when hidden', ->
    template = '<div>Hello</div>'
    modal = modalView(view: buildView(template)).show()

    modal.hide()

    expect($('body')).not.toHaveClass('prevent-scrolling')

  it 'does not remove prevent scrolling class with a preventScrollingOnClose option', ->
    template = '<div>Hello</div>'
    modal = modalView(
      view: buildView(template)
      preventScrollingOnClose: true
    ).show()

    modal.hide()

    expect($('body')).toHaveClass('prevent-scrolling')

  describe "Listening for key events", ->

    pressEscape = () ->
      event = jQuery.Event('keyup')
      enterKeyCode = DashModal.EscapeKeyUp.ESCAPE_KEY_CODE
      event.keyCode = enterKeyCode
      $(document).trigger(event)

    it 'closes on ESC', ->
      modal = modalView
        shouldCloseOnEscape: true
      modal.show()

      pressEscape()

      assertHidden(modal)

    it 'removes the listener on hide', ->
      modal = modalView
        shouldCloseOnEscape: true
      modal.show()
      removeListenersSpy = spyOn(modal.escapeKeyUp, "removeListeners")

      pressEscape()

      expect(removeListenersSpy).toHaveBeenCalled()

    it 'does not close on escape when configured not to', ->
      modal = modalView
        shouldCloseOnEscape: false
      modal.show()

      pressEscape()

      assertVisible(modal)

  describe 'Showing a modal', ->

    it 'renders a view inside of a modal in the global modal-container', ->
      setFixtures('<div data-id=modal-container></div>')
      template = '<div>Hello</div>'

      modal = modalView(view: buildView(template)).show()

      expect($('[data-id=modal-container]').html()).toContain(template)
      assertVisible(modal)

    it 'sets up a listener for hiding on the passed in view', ->
      template = '<div>Hello</div>'
      view = buildView(template)
      modal = modalView(view: view).show()

      assertVisible(modal)
      view.trigger('hideModal')
      assertHidden(modal)

    it 'appends the view modalSize class to modal container', ->
      template = '<div>Good Bye</div>'
      modal = modalView(view: buildView(template), modalSize: 'test-size').show()
      expect(modal.$('[data-id=modal]')).toBeMatchedBy('.test-size')

    it 'renders the view and modal inside a custom modal container when one is passed in', ->
      setFixtures('<div data-id=custom-modal-container></div>')
      template = '<div>Hello</div>'

      modal = new DashModal.View
        view:                 buildView(template)
        modalSize:            'modalSize'
        router:               new Backbone.Router()
        container:            $('[data-id=custom-modal-container]')

      modal.show()

      expect($('[data-id=custom-modal-container]').html()).toContain(template)

    it 'moves focus to the view container to prevent iframe/ios scrolling issue', ->
      focusSpy = spyOn($.fn, 'focus')
      template = '<div>Hello</div>'

      modal = modalView(view: buildView(template)).show()

      expect(modal.$('[data-id=view-container]').prop('tabindex')).toBeGreaterThan(0)
      expect(focusSpy).toHaveBeenCalled()

