namespace("Fakes")

class Fakes.View extends Backbone.View

  @content = "Fake View Content"

  initialize: (options={}) ->
    @content = options.content || Fakes.View.content
    @options = options

  render: ->
    @$el.html(@content)
    @
