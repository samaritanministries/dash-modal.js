export default class extends Backbone.View {

  initialize(options={}) {
    this.content = options.content
  }

  render() {
    this.$el.html(this.content)
    return this
  }

}
