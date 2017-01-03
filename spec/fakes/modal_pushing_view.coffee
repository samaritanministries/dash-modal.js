import Backbone from "backbone"
import FakeView from "fakes/view.js"

export default class extends Backbone.View

  initialize: (options) ->
    @modalStackView = options.modalStackView

  render: ->
    @modalStackView.push(new FakeView())
    @
