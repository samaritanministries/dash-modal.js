namespace('DashModal')

class DashModal.View extends Backbone.View
  template: DashModalJST['scripts/dash-modal/template.ejs']

  initialize: (@options) ->
    @view = @options.view

  events:
    'click [data-id=modal-inner]' : 'stopPropagation'
    'click [data-id=modal]'       : 'outerCountainerClick'
    'click [data-id=close]'       : 'hide'

  stopPropagation: (event) ->
    event.stopPropagation()

  outerCountainerClick: ->
    if @options.shouldAllowClose
      @hide()

  show: ->
    @$el.html(@template({ modalSize: @options.modalSize }))
    @removeCloseButton() unless @options.shouldAllowClose
    @listenTo(@view, 'hideModal', @hide)
    @$('[data-id=view-container]').html(@view.render().$el)
    $('body').addClass('prevent-scrolling')
    @$('[data-id=modal]').addClass('in')
    $('[data-id=modal-container]').html(@el)
    @

  hide: ->
    @options.onCloseCallback?()
    @$('[data-id=modal]').removeClass('in')
    setTimeout( => @$el.hide()
    150)
    $('body').removeClass('prevent-scrolling')

  isVisible: ->
    $('body').attr('class') == 'prevent-scrolling'

  removeCloseButton: ->
    @$('[data-id=close]').remove()
