import ShowModalView from "sample_app/show_modal.js"

describe("ShowModalView", () => {

  describe("Showing the modal", () => {
    it("creates a DashModal View", () => {
      buildModalViewSpy = spyOn(DashModal, "View").and.returnValue({show: () => {}})
      view = new ShowModalView({}).render()

      view.showModal()

      expect(buildModalViewSpy).toHaveBeenCalled();
    });
  });

});
