namespace("SampleApp")

class SampleApp.ShowModal extends Backbone.View

  initialize: (@options) ->

  events:
    "click [data-id=show-modal]": "showModal"

  showModal: ->
    modal = new DashModal.View
      view: new SampleApp.ModalView
      onCloseCallback: @onClose
      hasXButton: @options.hasXButton
      shouldCloseOnEscape: @options.shouldCloseOnEscape
      shouldCloseOnOverlay: @options.shouldCloseOnOverlay
    modal.show()

  onClose: ->
    console.log("On Close")
