$ ->
  new SampleApp.ShowModal
    el: $("[data-id=show-modal-container-one]")
    shouldAllowClose: true
    shouldCloseOnEscape: false

  new SampleApp.ShowModal
    el: $("[data-id=show-modal-container-two]")
    shouldAllowClose: true
    shouldCloseOnEscape: true
