describe("Navigation.Modal", function() {
//
  var fakeView = function(options) {
    return new Fakes.View(options)
  }
//
  var modalContainer

  beforeEach(function() {
    fixtures = setFixtures("<div data-id='modal-container'></div>")
    this.modalContainer = fixtures.find("[data-id=modal-container]")
  })

  var isModalVisible = function() {
    return $("[data-id=modal-container]").find("[data-id=modal]").is(":visible")
  }

  var navigationModal = function() {
    return DashModal.Navigation.Modal
  }

  describe("Showing a modal", function() {

    it("populates the container with the view", function() {
      navigationModal().push({view: fakeView()})
      expect(this.modalContainer.text()).toContain(Fakes.View.content)
    })

    it("shows the modal", function() {
      navigationModal().push({view: fakeView()})
      expect(isModalVisible()).toBeTruthy()
    })

  })

  describe("Modal navigation", function() {

    var firstView, secondView

    beforeEach(function() {
      this.firstView = fakeView({content: "View One"})
      this.secondView = fakeView({content: "View Two"})
    })

    it("shows the first modal", function() {
      navigationModal().push({view: this.firstView})
      expect(this.modalContainer.text()).toContain("View One")
    })

    it("hides the only modal", function() {
      navigationModal().push({view: this.firstView})

      navigationModal().pop()

      expect(this.firstView.$el).toBeHidden()
    })

    it("returns to the first modal", function() {
      navigationModal().push({view: this.firstView})
      navigationModal().push({view: this.secondView})
      navigationModal().pop()

      expect(this.modalContainer.text()).toContain("View One")
    })

    it("retains bound events in a previous modal", function() {
      button = $("<button></button>")
      spy = jasmine.createSpy("button click")
      $(button).click(spy)
      this.firstView.$el.append(button)

      navigationModal().push({view: this.firstView})
      navigationModal().push({view: this.secondView})
      navigationModal().pop()

      button.click()
      expect(spy).toHaveBeenCalled()
    })

    it("handles popping an empty stack", function() {
      expect(function() {
        navigationModal().pop()
      }).not.toThrow()
    })

    it("hides the modal when popping the last modal", function() {
      navigationModal().push({view: this.firstView})
      navigationModal().pop()
      expect(isModalVisible()).toBeFalsy()
    })

    it("has a current modal with one on the stack", function() {
      navigationModal().push({view: this.firstView})
      expect(navigationModal().hasCurrent()).toBeTruthy()
    })

    it("doesn't have a current modal when empty", function() {
      expect(navigationModal().hasCurrent()).toBeFalsy()
    })

    it("has have a current modal with more than one on the stack", function() {
      navigationModal().push({view: this.firstView})
      navigationModal().push({view: this.secondView})
      expect(navigationModal().hasCurrent()).toBeTruthy()
    })

    it("doesn't have a current modal after a pop", function() {
      navigationModal().push({view: this.firstView})
      navigationModal().pop()
      expect(navigationModal().hasCurrent()).toBeFalsy()
    })

    it("empties the current modal", function() {
      navigationModal().push({view: this.firstView})
      navigationModal().empty()
      expect(isModalVisible()).toBeFalsy()
    })

    it("empties the modal container", function() {
      navigationModal().push({view: this.firstView})
      navigationModal().empty()
      expect(this.modalContainer).toBeEmpty()
    })

    it("empties the modal when you close it", function() {
      navigationModal().push({view: this.firstView, hasXButton: true})
      navigationModal().push({view: this.secondView, hasXButton: true})
      var closeButton = this.modalContainer.find("[data-id=close]")
      expect(closeButton).toExist()
      closeButton.click()

      expect(isModalVisible()).toBeFalsy()
      expect(navigationModal().hasCurrent()).toBeFalsy()
    })
  })

  describe("Getting the modal's state", function() {

    it("has no previous modal when empty", function() {
      expect(navigationModal().hasPrevious()).toBeFalsy()
    })

    it("has no previous modal when there is only one view", function() {
      navigationModal().push({view: fakeView()})

      expect(navigationModal().hasPrevious()).toBeFalsy()
    })

    it("has a previous modal when there are at least two views", function() {
      navigationModal().push({view: fakeView()})
      navigationModal().push({view: fakeView()})

      expect(navigationModal().hasPrevious()).toBeTruthy()
    })

    it("has no previous modal when the second to last one has been popped", function() {
      navigationModal().push({view: fakeView()})
      navigationModal().push({view: fakeView()})
      navigationModal().pop()

      expect(navigationModal().hasPrevious()).toBeFalsy()
    })

    it("has no previous modal when the entire stack has been emptied", function() {
      navigationModal().push({view: fakeView()})
      navigationModal().push({view: fakeView()})
      navigationModal().empty()

      expect(navigationModal().hasPrevious()).toBeFalsy()
    })
  })
})
