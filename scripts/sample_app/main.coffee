$ ->
  DashModal.Navigation.Modal.empty()

  new SampleApp.ShowModal
    el: $("[data-id=show-modal-container-one]")
    hasXButton: true

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
    hasXButton: true

  new SampleApp.ShowModal
    el: $("[data-id=show-modal-container-five]")
    hasXButton: true
    container: $('[data-id=custom-modal-container]')

  new SampleApp.PushModalView
    el: $("[data-id=push-navigation-modal-container]")
    hasXButton: true
