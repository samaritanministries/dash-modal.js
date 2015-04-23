describe 'DashModal.View', ->
  class TestView extends Backbone.View
    initialize: (@options) ->

    render: ->
      @$el.html(@options.template)
      @

  view = (template) ->
    _v =  new TestView({template: template})
    _v

  modal = (view, modalSize, router = new Backbone.Router()) ->
    _m = new DashModal.View
      view: view
      modalSize: modalSize
      router: router
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

    modal(view(template)).show()

    expect($('[data-id=modal-container]').html()).toContain(modalHtml)

  it 'is visible on show', ->
    template = '<div>Hello</div>'
    _m = modal(view(template)).show()
    assertVisible(_m)

  it 'can hide itself', ->
    template = '<div>Hello</div>'
    _m = modal(view(template)).show()

    assertVisible(_m)
    _m.hide()
    assertHidden(_m)

  it 'can remove itself', ->
    template = '<div>Hello</div>'
    _m = modal(view(template)).show()

    assertVisible(_m)
    _m.remove()
    assertRemoved(_m)

  it 'sets up a listener for hiding on the passed in view', ->
    template = '<div>Hello</div>'
    _v = view(template)
    _m = modal(_v).show()

    assertVisible(_m)
    _v.trigger('hideModal')
    assertHidden(_m)

  it 'knows when it is visible', ->
    template = '<div>Hello</div>'
    _v = view(template)
    _m = modal(_v).show()

    expect(_m.isVisible()).toBeTruthy()

  it 'knows when it is not visible', ->
    template = '<div>Hello</div>'
    _v = view(template)
    _m = modal(_v).show()
    _m.hide()

    expect(_m.isVisible()).toBeFalsy()
    _m.show()
    expect(_m.isVisible()).toBeTruthy()

  it 'hides when the overlay (.modal) is clicked when shouldCloseOnOverlay is true', ->
    _m = new DashModal.View
      view: view()
      modalSize: 'modalSize'
      shouldCloseOnOverlay: true
      router: "router"
    _m.show()

    assertVisible(_m)

    _m.$('[data-id=modal]').trigger('click')

    assertHidden(_m)

  it 'does NOT hide when overlay (.modal) is clicked when shouldCloseOnOverlay is undefined', ->
    _m = new DashModal.View
      view: view()
      modalSize: 'modalSize'
      router: "router"
    _m.show()

    assertVisible(_m)

    _m.$('[data-id=modal]').trigger('click')
    assertVisible(_m)

  it 'does NOT hide when .modal-inner is clicked', ->
    template = '<div>Hello</div>'
    _m = modal(view(template)).show()

    assertVisible(_m)

    _m.$('[data-id=modal-inner]').trigger('click')
    assertVisible(_m)

  it 'renders appends the view modalSize class to modal container', ->
    template = '<div>Good Bye</div>'
    _m = modal(view(template), 'test-size').show()
    expect(_m.$('[data-id=modal]')).toBeMatchedBy('.test-size')

  it 'when shouldCloseOnX is true, "X" button to click is available to close', ->
    _m = new DashModal.View
      view: view()
      modalSize: 'modalSize'
      shouldCloseOnX: true
      router: "router"
    _m.show()

    assertVisible(_m)

    _m.$('[data-id=close]').click()

    assertHidden(_m)

  it 'removes "X", when shouldCloseOnX is false', ->
    _m = new DashModal.View
      view: view()
      modalSize: 'modalSize'
      shouldCloseOnX: false
      router: "router"
    _m.show()

    expect(_m.$('[data-id=close]')).not.toExist()

  it 'takes an onCloseCallback and calls it on close click', ->
    callback = jasmine.createSpy('afterCloseCallback')
    _m = new DashModal.View
      view: view()
      modalSize: 'modalSize'
      shouldCloseOnX: true
      router: "router"
      onCloseCallback: callback
    _m.show()


    _m.$('[data-id=close]').click()

    expect(callback).toHaveBeenCalled()

  it 'also calls it on overlay click', ->
    callback = jasmine.createSpy('afterCloseCallback')
    _m = new DashModal.View
      view: view()
      modalSize: 'modalSize'
      shouldCloseOnOverlay: true
      router: "router"
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
      _m = new DashModal.View
        view: view()
        modalSize: 'modalSize'
        shouldCloseOnEscape: true
        router: "router"
      _m.show()

      pressEscape()

      assertHidden(_m)

    it 'removes the listener on hide', ->
      _m = new DashModal.View
        view: view()
        modalSize: 'modalSize'
        shouldCloseOnEscape: true
        router: "router"
      _m.show()

      removeListenersSpy = spyOn(_m.escapeKeyUp, "removeListeners")

      pressEscape()

      expect(removeListenersSpy).toHaveBeenCalled()

    it 'does not close on escape when configured not to', ->
      _m = new DashModal.View
        view: view()
        modalSize: 'modalSize'
        shouldCloseOnEscape: false
        router: "router"
      _m.show()

      pressEscape()

      assertVisible(_m)
