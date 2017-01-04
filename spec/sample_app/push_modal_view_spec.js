import PushModalView from "sample_app/push_modal_view.js"

describe("PushModalView", () => {
  describe("Rendering the view", () => {
    it("has a button to empty the modal", () => {
      let view = new PushModalView({})

      view.render()

      expect(view.$("[data-action=empty-modal]")).toExist()
    });

    it("shows the depth", () => {
      let view = new PushModalView({depth: 123})

      view.render()

      expect(view.$("[data-id=depth]").text()).toEqual("Depth: 123")
    });
  });
});
