export default class extends Backbone.View

  @content = "Fake View Content"

  initialize: (options={}) ->
    @content = options.content || "Fake View Content"
    @options = options

  render: ->
    @$el.html(@content)
    @
