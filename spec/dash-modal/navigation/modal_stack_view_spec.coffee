import FakeView from "fakes/view.coffee"
import FakeModalPushingView from "fakes/modal_pushing_view.coffee"
import ModalStackView from "dash_modal/navigation/modal_stack_view.js"

describe "ModalStackView", ->

  fakeView = (options) ->
    new FakeView(options)

  beforeEach ->
    @firstView = fakeView(content: "View One")
    @secondView = fakeView(content: "View Two")
    @view = new ModalStackView()
    @view.render()
    setFixtures @view.$el

  describe "Pushing a view", ->

    it "shows the view", ->
      @view.push @firstView
      expect(@firstView.$el).toBeVisible()

    it "fails when it pushes another view while being pushed", ->
      expect( =>
        @view.push new FakeModalPushingView(modalStackView: @view)
      ).toThrow("Attempting to push a modal view while push is in progress")

  describe "Pushing two views", ->

    it "shows the second view", ->
      @view.push @firstView
      @view.push @secondView
      expect(@firstView.$el).toBeHidden()

    it "hides the first view", ->
      @view.push @firstView
      @view.push @secondView
      expect(@secondView.$el).toBeVisible()

  describe "Popping a view", ->

    it "removes the last view", ->
      @view.push @firstView
      @view.push @secondView

      @view.pop()

      expect(@view.$el.text()).not.toContain("View Two")

    it "shows the previous view", ->
      @view.push @firstView
      @view.push @secondView

      @view.pop()

      expect(@firstView.$el).toBeVisible()
