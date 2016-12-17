namespace("Foo")

class Foo.View extends Backbone.View

  template: DashModalJST["scripts/dash-modal/foo.ejs"]

  render: ->
    @$el.html(this.template({
      header: "Hello world"
    }))
    @
