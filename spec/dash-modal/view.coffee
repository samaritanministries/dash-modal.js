describe 'DashModal.View', ->
  class TestView extends Backbone.View
    initialize: (@options) ->

    render: ->
      @$el.html(@options.template)
      @

  view = (template) ->
    _v =  new TestView({template: template})
    _v

  modal = (view, modalSize, shouldAllowClose, closeOnEscape, onCloseCallback, router = new Backbone.Router()) ->
    _m = new DashModal.View
      view: view
      modalSize: modalSize
      shouldAllowClose: shouldAllowClose
      onCloseCallback: onCloseCallback
      closeOnEscape: closeOnEscape
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

  it 'hides when .modal is clicked when shouldAllowClose is true', ->
    template = '<div>Hello</div>'
    _m = modal(view(template), 'test', true).show()

    assertVisible(_m)

    _m.$('[data-id=modal]').trigger('click')
    assertHidden(_m)

  it 'does NOT hide when .modal is clicked when shouldAllowClose is undefined', ->
    template = '<div>Hello</div>'
    _m = modal(view(template), 'test').show()

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

  it 'when shouldAllowClose is passed in, "X" button to click is available to close', ->
    template = '<div>Hello</div>'
    _m = modal(view(template), 'test', true).show()

    assertVisible(_m)

    _m.$('[data-id=close]').click()

    assertHidden(_m)

  it 'removes "X", when shouldAllowClose is false', ->
    template = '<div>Hello</div>'
    _m = modal(view(template), 'test', false).show()

    expect(_m.$('[data-id=close]')).not.toExist()

  it 'takes an onCloseCallback and calls it on close click', ->
    template = '<div>Hello</div>'
    callback = jasmine.createSpy('afterCloseCallback')
    _m = modal(view(template), 'test', true, false, callback).show()

    _m.$('[data-id=close]').click()

    expect(callback).toHaveBeenCalled()

  it 'also calls it on overlay click', ->
    template = '<div>Hello</div>'
    callback = jasmine.createSpy('afterCloseCallback')
    _m = modal(view(template), 'test', true, false, callback).show()

    _m.$('[data-id=modal]').click()

    expect(callback).toHaveBeenCalled()

  describe "Listening for key events", ->

    pressEscape = () ->
      event = jQuery.Event('keyup')
      enterKeyCode = DashModal.EscapeKeyUp.ESCAPE_KEY_CODE
      event.keyCode = enterKeyCode
      $(document).trigger(event)

    it 'closes on ESC', ->
      template = '<div>Hello</div>'
      _m = modal(view(template), 'test', true, true).show()

      pressEscape()

      assertHidden(_m)

    it 'removes the listener on hide', ->
      template = '<div>Hello</div>'
      _m = modal(view(template), 'test', true, true).show()

      removeListenersSpy = spyOn(_m.escapeKeyUp, "removeListeners")

      pressEscape()

      expect(removeListenersSpy).toHaveBeenCalled()

    it 'does not close on escape when configured not to', ->
      template = '<div>Hello</div>'
      _m = modal(view(template), 'test', true, false).show()

      pressEscape()

      assertVisible(_m)
