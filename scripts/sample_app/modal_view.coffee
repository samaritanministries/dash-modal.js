namespace("SampleApp")

class SampleApp.ModalView extends Backbone.View

  render: ->
    @$el.html('
      <div class="modal-header"><h2>Example Modal</h2></div>
      <div class="modal-content"><p>Example content in a modal for all the people to see. It is pretty cool huh? I love content. Especially stuff that does not make sense.</p></div>
      <div class="modal-footer">Footer content</div>
    ')
    @
