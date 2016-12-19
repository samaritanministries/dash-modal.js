# import Baz from "dash_modal/baz.js"
#
# describe "Foo", ->
#   it "imports Baz", ->
#     expect(Baz).toEqual(baz: "123")
#
#   it "has underscore", ->
#     doubled = _.map [1, 2, 3], (number) ->
#       number * 2
#     expect(doubled).toEqual([2, 4, 6])
#
#   it "renders a view", ->
#     view = new Foo.View()
#
#     view.render()
#
#     expect(view.$el.text()).toContain("Hello world")
#
#   it "loads the templates", ->
#     expect(DashModalJST).toBeDefined()
#     template = DashModalJST["scripts/dash-modal/foo.ejs"]
#     expect(template).toBeDefined()
#     expect(template(header: "Hello")).toContain("Hello")
