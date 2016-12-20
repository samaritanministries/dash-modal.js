import FakeView from "fakes/view.coffee"

export default class extends Backbone.View

  initialize: (options) ->
    @modalStackView = options.modalStackView

  render: ->
    @modalStackView.push(new FakeView())
    @
