describe 'DashModal.View', ->
  class TestView extends Backbone.View
    initialize: (@options) ->

    render: ->
      @$el.html(@options.template)
      @

  view = (template) ->
    _v =  new TestView({template: template})
    _v

  modalView = (options) ->
    _m = new DashModal.View
      view:                 options.view ?= view()
      modalSize:            options.modalSize ?= 'modalSize'
      hasXButton:           options.hasXButton
      onCloseCallback:      options.onCloseCallback
      shouldCloseOnOverlay: options.shouldCloseOnOverlay
      shouldCloseOnEscape:  options.shouldCloseOnEscape
      router:               options.router ?= new Backbone.Router()
    _m

  assertHidden = (_modal) ->
    expect(_modal.$el).toContainElement('[data-id=modal]')
    expect(_modal.$el).not.toContainElement('.in')

  assertVisible = (_modal) ->
    expect(_modal.$el).toContainElement('[data-id=modal].in')

  assertRemoved = (_modal) ->
    expect($('body')).not.toContainElement('[data-id=modal]')

  it 'renders a view inside of a modal in the global modal-container', ->
    setFixtures('<div data-id=modal-container></div>')
    template = '<div>Hello</div>'
    modalHtml = '<div data-id="view-container"><div><div>Hello</div></div></div>'

    modalView(view: view(template)).show()

    expect($('[data-id=modal-container]').html()).toContain(modalHtml)

  it 'is visible on show', ->
    template = '<div>Hello</div>'
    _m = modalView(view: view(template)).show()
    assertVisible(_m)

  it 'can hide itself', ->
    template = '<div>Hello</div>'
    _m = modalView(view: view(template)).show()

    assertVisible(_m)
    _m.hide()
    assertHidden(_m)

  it 'can remove itself', ->
    template = '<div>Hello</div>'
    _m = modalView(view: view(template)).show()

    assertVisible(_m)
    _m.remove()
    assertRemoved(_m)

  it 'sets up a listener for hiding on the passed in view', ->
    template = '<div>Hello</div>'
    _v = view(template)
    _m = modalView(view: _v).show()

    assertVisible(_m)
    _v.trigger('hideModal')
    assertHidden(_m)

  it 'knows when it is visible', ->
    template = '<div>Hello</div>'
    _v = view(template)
    _m = modalView(view: _v).show()

    expect(_m.isVisible()).toBeTruthy()

  it 'knows when it is not visible', ->
    template = '<div>Hello</div>'
    _v = view(template)
    _m = modalView(view: _v).show()
    _m.hide()

    expect(_m.isVisible()).toBeFalsy()
    _m.show()
    expect(_m.isVisible()).toBeTruthy()

  it 'hides when the overlay (.modal) is clicked when shouldCloseOnOverlay is true', ->
    _m = modalView
      shouldCloseOnOverlay: true
    _m.show()

    assertVisible(_m)

    _m.$('[data-id=modal]').trigger('click')

    assertHidden(_m)

  it 'does NOT hide when overlay (.modal) is clicked when shouldCloseOnOverlay is undefined', ->
    _m = modalView
      router: "router"
    _m.show()

    assertVisible(_m)

    _m.$('[data-id=modal]').trigger('click')
    assertVisible(_m)

  it 'does NOT hide when .modal-inner is clicked', ->
    template = '<div>Hello</div>'
    _m = modalView(view: view(template)).show()

    assertVisible(_m)

    _m.$('[data-id=modal-inner]').trigger('click')
    assertVisible(_m)

  it 'renders appends the view modalSize class to modal container', ->
    template = '<div>Good Bye</div>'
    _m = modalView(view: view(template), modalSize: 'test-size').show()
    expect(_m.$('[data-id=modal]')).toBeMatchedBy('.test-size')

  it 'renders the view to a custom modal container', ->
    setFixtures('<div data-id=custom-modal-container></div>')
    template = '<div>Hello</div>'
    modalHtml = '<div data-id="view-container"><div><div>Hello</div></div></div>'

    _m = new DashModal.View
      view:                 view(template)
      modalSize:            'modalSize'
      router:               new Backbone.Router()
      container:            $('[data-id=custom-modal-container]')

    _m.show()

    expect($('[data-id=custom-modal-container]').html()).toContain(modalHtml)

  it 'when hasXButton is true, "X" button to click is available to close', ->
    _m = modalView
      hasXButton: true
    _m.show()

    assertVisible(_m)

    _m.$('[data-id=close]').click()

    assertHidden(_m)

  it 'removes "X", when hasXButton is false', ->
    _m = modalView
      hasXButton: false
    _m.show()

    expect(_m.$('[data-id=close]')).not.toExist()

  it 'takes an onCloseCallback and calls it on close click', ->
    callback = jasmine.createSpy('afterCloseCallback')
    _m = modalView
      hasXButton: true
      onCloseCallback: callback
    _m.show()


    _m.$('[data-id=close]').click()

    expect(callback).toHaveBeenCalled()

  it 'also calls it on overlay click', ->
    callback = jasmine.createSpy('afterCloseCallback')
    _m = modalView
      shouldCloseOnOverlay: true
      onCloseCallback: callback
    _m.show()

    _m.$('[data-id=modal]').click()

    expect(callback).toHaveBeenCalled()

  describe "Listening for key events", ->

    pressEscape = () ->
      event = jQuery.Event('keyup')
      enterKeyCode = DashModal.EscapeKeyUp.ESCAPE_KEY_CODE
      event.keyCode = enterKeyCode
      $(document).trigger(event)

    it 'closes on ESC', ->
      _m = modalView
        shouldCloseOnEscape: true
      _m.show()

      pressEscape()

      assertHidden(_m)

    it 'removes the listener on hide', ->
      _m = modalView
        shouldCloseOnEscape: true
      _m.show()
      removeListenersSpy = spyOn(_m.escapeKeyUp, "removeListeners")

      pressEscape()

      expect(removeListenersSpy).toHaveBeenCalled()

    it 'does not close on escape when configured not to', ->
      _m = modalView
        shouldCloseOnEscape: false
      _m.show()

      pressEscape()

      assertVisible(_m)
