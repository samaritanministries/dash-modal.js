namespace("SampleApp")

class SampleApp.ShowModal extends Backbone.View

  initialize: (@options) ->

  events:
    "click [data-id=show-modal]": "showModal"

  showModal: ->
    modal = new DashModal.View
      view: new SampleApp.ModalView
      onCloseCallback: @onClose
      shouldAllowClose: @options.shouldAllowClose
      shouldCloseOnEscape: @options.shouldCloseOnEscape
    modal.show()

  onClose: ->
    console.log("On Close")
