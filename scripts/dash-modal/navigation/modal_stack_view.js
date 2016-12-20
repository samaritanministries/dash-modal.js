export default class extends Backbone.View {

  initialize() {
    this.isPushInProgress = false
  }

  push(view) {
    if(this.isPushInProgress) {
      throw("Attempting to push a modal view while push is in progress")
    }
    this.isPushInProgress = true
    this.modalViews().hide()
    if(!this.isRendered(view)) {
      view.render()
    }
    this.$el.append(view.$el)
    this.isPushInProgress = false
  }

  pop() {
    this.modalViews().last().remove()
    this.modalViews().last().show()
  }

  childCount() {
    return this.modalViews().length
  }

  modalViews() {
    return this.$el.children()
  }

  isRendered(view) {
    return !view.$el.is(":empty")
  }

}
