import Backbone from "backbone"
import FakeView from "fakes/view.js"

export default class extends Backbone.View {

  initialize(options) {
    this.modalStackView = options.modalStackView
  }

  render() {
    this.modalStackView.push(new FakeView())
    return this
  }

}
