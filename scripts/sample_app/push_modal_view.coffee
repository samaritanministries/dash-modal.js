export default class PushModalView extends Backbone.View

  initialize: (@options) ->
    @depth = @options.depth || 0

  events:
    "click [data-action=empty-modal]": "emptyModal"
    "click [data-action=pop-modal]": "popModal"
    "click [data-id=push-modal]": "pushModal"

  render: ->
    @$el.html('
      <div class="modal-header"><h2>Example Navigation Modal</h2></div>
      <div class="modal-content">
      <p><div data-id="depth"></div><button data-action="pop-modal">Back</button></p>
      <p><button data-id="push-modal">Push</button></p>
      <p><button data-action="empty-modal">Empty</button></p>
      </div>
      <div class="modal-footer">Footer content</div>
    ')
    @$("[data-id=depth]").html("Depth: #{@depth}")
    @

  emptyModal: ->
    DashModal.Navigation.Modal.empty()

  popModal: ->
    DashModal.Navigation.Modal.pop()

  pushModal: ->
    DashModal.Navigation.Modal.push
      view: new PushModalView(depth: @depth + 1)
      hasXButton: @options.hasXButton
      shouldCloseOnEscape: @options.shouldCloseOnEscape
      shouldCloseOnOverlay: @options.shouldCloseOnOverlay
