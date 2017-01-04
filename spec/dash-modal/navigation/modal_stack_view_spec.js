import FakeView from "fakes/view.js"
import FakeModalPushingView from "fakes/modal_pushing_view.js"
import ModalStackView from "dash_modal/navigation/modal_stack_view.js"

describe("ModalStackView", () => {

  var fakeView = (options) => {
    return new FakeView(options)
  }

  var firstView, secondView, view

  beforeEach(() => {
    firstView = fakeView({content: "View One"})
    secondView = fakeView({content: "View Two"})
    view = new ModalStackView()
    view.render()
    setFixtures(view.$el)
  })

  describe("Pushing a view", () => {

    it("shows the view", () => {
      view.push(firstView)
      expect(firstView.$el).toBeVisible()
    })

    it("fails when it pushes another view while being pushed", () => {
      expect(() => {
        view.push(new FakeModalPushingView({modalStackView: view}))
      }).toThrow("Attempting to push a modal view while push is in progress")
    })
  })
  describe("Pushing two views", () => {

    it("shows the second view", () => {
      view.push(firstView)
      view.push(secondView)
      expect(secondView.$el).toBeVisible()
    })

    it("hides the first view", () => {
      view.push(firstView)
      view.push(secondView)
      expect(firstView.$el).toBeHidden()
    })

  })

  describe("Popping a view", () => {

    it("removes the last view", () => {

      view.pop()

      expect(view.$el.text()).not.toContain("View Two")
    })

    it("shows the previous view", () => {
      view.push(firstView)
      view.push(secondView)

      view.pop()

      expect(firstView.$el).toBeVisible()
    })

  })
})
