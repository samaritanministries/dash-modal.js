describe "Navigation.Modal", ->

  fakeView = (options)->
    new Fakes.View(options)

  beforeEach ->
    setFixtures('<div data-id="modal-container"></div>')
    @modalContainer = $("[data-id=modal-container]")

  isModalVisible = ->
    $("[data-id=modal-container]").find("[data-id=modal]").is(":visible")

  navigationModal = ->
    DashModal.Navigation.Modal

  describe "Showing a modal", ->

    it "populates the container with the view", ->
      navigationModal().push(view: fakeView())
      expect(@modalContainer.text()).toContain(Fakes.View.content)

    it "shows the modal", ->
      navigationModal().push(view: fakeView())
      expect(isModalVisible()).toBeTruthy()

  describe "Modal navigation", ->

    beforeEach ->
      @firstView = fakeView(content: "View One")
      @secondView = fakeView(content: "View Two")

    it "shows the first modal", ->
      navigationModal().push(view: @firstView)
      expect(@modalContainer.text()).toContain("View One")

    it "hides the only modal", ->
      onClose = jasmine.createSpy("On Close")
      navigationModal().push
        onCloseCallback: onClose
        view: @firstView
      navigationModal().pop()

      expect(@firstView.$el).toBeHidden()

    it "returns to the first modal", ->
      navigationModal().push(view: @firstView)
      navigationModal().push(view: @secondView)
      navigationModal().pop()

      expect(@modalContainer.text()).toContain("View One")

    it "retains bound events in a previous modal", ->
      button = $("<button></button>")
      spy = jasmine.createSpy("button click")
      $(button).click spy
      @firstView.$el.append(button)

      navigationModal().push(view: @firstView)
      navigationModal().push(view: @secondView)
      navigationModal().pop()

      button.click()
      expect(spy).toHaveBeenCalled()

    it "handles popping an empty stack", ->
      expect(-> navigationModal().pop()).not.toThrow()

    it "hides the modal when popping the last modal", ->
      navigationModal().push(view: @firstView)
      navigationModal().pop()
      expect(isModalVisible()).toBeFalsy()

    it "has a current modal with one on the stach", ->
      navigationModal().push(view: @firstView)
      expect(navigationModal().hasCurrent()).toBeTruthy()

    it "doesn't have a current modal when empty", ->
      expect(navigationModal().hasCurrent()).toBeFalsy()

    it "has have a current modal with more than one on the stack", ->
      navigationModal().push(view: @firstView)
      navigationModal().push(view: @secondView)
      expect(navigationModal().hasCurrent()).toBeTruthy()

    it "doesn't have a current modal after a pop", ->
      navigationModal().push(view: @firstView)
      navigationModal().pop()
      expect(navigationModal().hasCurrent()).toBeFalsy()

    it "empties the current modal", ->
      navigationModal().push(view: @firstView)
      navigationModal().empty()
      expect(isModalVisible()).toBeFalsy()

    it "empties the modal container", ->
      navigationModal().push(view: @firstView)
      navigationModal().empty()
      expect(@modalContainer).toBeEmpty()

    it "empties the modal when you close it", ->
      navigationModal().push(view: @firstView, hasXButton: true)
      navigationModal().push(view: @secondView, hasXButton: true)
      closeButton = @modalContainer.find("[data-id=close]")
      expect(closeButton).toExist()
      closeButton.click()

      expect(isModalVisible()).toBeFalsy()
      expect(navigationModal().hasCurrent()).toBeFalsy()

  describe "Getting the modal's state", ->

    it "has no previous modal when empty", ->
      expect(navigationModal().hasPrevious()).toBeFalsy()

    it "has no previous modal when there is only one view", ->
      navigationModal().push(view: fakeView())

      expect(navigationModal().hasPrevious()).toBeFalsy()

    it "has a previous modal when there are at least two views", ->
      navigationModal().push(view: fakeView())
      navigationModal().push(view: fakeView())

      expect(navigationModal().hasPrevious()).toBeTruthy()

    it "has no previous modal when the second to last one has been popped", ->
      navigationModal().push(view: fakeView())
      navigationModal().push(view: fakeView())
      navigationModal().pop()

      expect(navigationModal().hasPrevious()).toBeFalsy()

    it "has no previous modal when the entire stack has been emptied", ->
      navigationModal().push(view: fakeView())
      navigationModal().push(view: fakeView())
      navigationModal().empty()

      expect(navigationModal().hasPrevious()).toBeFalsy()
