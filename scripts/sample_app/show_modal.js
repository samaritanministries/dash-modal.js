namespace("SampleApp")

window.SampleApp.ShowModal = class extends Backbone.View {

  initialize(options) {
    this.options = options
  }

  events() {
    return {"click [data-id=show-modal]": "showModal"}
  }

  showModal() {
    modal = new DashModal.View({
      view: new SampleApp.ModalView(),
      onCloseCallback: this.onClose,
      hasXButton: this.options.hasXButton,
      shouldCloseOnEscape: this.options.shouldCloseOnEscape,
      shouldCloseOnOverlay: this.options.shouldCloseOnOverlay,
      container: this.options.container
    })
    modal.show()
  }

  onClose() {
    console.log("On Close")
  }

}
