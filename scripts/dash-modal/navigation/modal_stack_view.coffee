namespace("DashModal.Navigation")

class DashModal.Navigation.ModalStackView extends Backbone.View

  initialize: ->
    @isPushInProgress = false

  push: (view) ->
    throw "Attempting to push a modal view while push is in progress." if @isPushInProgress
    @isPushInProgress = true
    @modalViews().hide()
    view.render() if !@isRendered(view)
    @$el.append(view.$el)
    @isPushInProgress = false

  pop: ->
    @modalViews().last().remove()
    @modalViews().last().show()

  childCount: ->
    @modalViews().length

  modalViews: ->
    @$el.children()

  isRendered: (view) ->
    !view.$el.is(":empty")
