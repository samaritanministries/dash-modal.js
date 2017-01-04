import Backbone from "backbone"
import template from "sample_app/push_modal_template.ejs"

export default class PushModalView extends Backbone.View {

  initialize(options) {
    this.options = options
    this.depth = options.depth || 0
  }

  events() {
    return {
      "click [data-action=empty-modal]": "emptyModal",
      "click [data-action=pop-modal]": "popModal",
      "click [data-id=push-modal]": "pushModal"
    }
  }

  render() {
    this.$el.html(template())
    this.$("[data-id=depth]").html(`Depth: ${this.depth}`)
    return this
  }

  emptyModal() {
    DashModal.Navigation.Modal.empty()
  }

  popModal() {
    DashModal.Navigation.Modal.pop()
  }

  pushModal() {
    DashModal.Navigation.Modal.push({
      view: new PushModalView({depth: this.depth + 1}),
      hasXButton: this.options.hasXButton,
      shouldCloseOnEscape: this.options.shouldCloseOnEscape,
      shouldCloseOnOverlay: this.options.shouldCloseOnOverlay
    })
  }

}
