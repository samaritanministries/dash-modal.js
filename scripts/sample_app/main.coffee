$ ->
  new SampleApp.ShowModal
    el: $("[data-id=show-modal-container-one]")
    shouldCloseOnX: true

  new SampleApp.ShowModal
    el: $("[data-id=show-modal-container-two]")
    shouldCloseOnOverlay: true

  new SampleApp.ShowModal
    el: $("[data-id=show-modal-container-three]")
    shouldCloseOnEscape: true

  new SampleApp.ShowModal
    el: $("[data-id=show-modal-container-four]")
    shouldCloseOnEscape: true
    shouldCloseOnOverlay: true
    shouldCloseOnX: true
