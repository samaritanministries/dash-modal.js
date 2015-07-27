namespace('DashModal')

class DashModal.View extends Backbone.View
  template: DashModalJST['scripts/dash-modal/template.ejs']

  initialize: (@options) ->
    @view = @options.view
    @escapeKeyUp = @buildEscapeKeyUp()
    @container = @options.container ? $('[data-id=modal-container]')

  events:
    'click [data-id=modal-inner]' : 'stopPropagation'
    'click [data-id=modal]'       : 'outerCountainerClick'
    'click [data-id=close]'       : 'hide'

  stopPropagation: (event) ->
    event.stopPropagation()

  outerCountainerClick: ->
    @hide() if @options.shouldCloseOnOverlay

  show: ->
    @escapeKeyUp.respondWith(@hide)
    @$el.html(@template({ modalSize: @options.modalSize }))
    @removeCloseButton() unless @options.hasXButton
    @listenTo(@view, 'hideModal', @hide)
    @$('[data-id=view-container]').html(@view.render().$el)
    $('body').addClass('prevent-scrolling')
    @$('[data-id=modal]').addClass('in')
    @container.html(@el)
    @

  hide: =>
    @escapeKeyUp.removeListeners()
    @options.onCloseCallback?()
    @$('[data-id=modal]').removeClass('in')
    setTimeout( => @$el.hide()
    150)
    $('body').removeClass('prevent-scrolling')

  isVisible: ->
    $('body').attr('class') == 'prevent-scrolling'

  removeCloseButton: ->
    @$('[data-id=close]').remove()

  buildEscapeKeyUp: ->
    if @options.shouldCloseOnEscape
      new DashModal.EscapeKeyUp()
    else
      new DashModal.NullEscapeKeyUp()
