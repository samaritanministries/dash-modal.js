namespace("DashModal.Navigation")

class DashModal.Navigation.Modal

  @hasPrevious: ->
    @wrapperView.childCount() > 1

  @hasCurrent: ->
    @wrapperView.childCount() > 0

  @push: (options) ->
    @wrapperView.push(options.view)
    options.view = @wrapperView
    @_show(options)

  @pop: ->
    @wrapperView.pop()
    @empty() if @wrapperView.childCount() == 0

  @empty: ->
    @_currentModal?.hide()
    $("[data-id=modal-container]").empty()
    @wrapperView = new DashModal.Navigation.ModalStackView()
    @_currentModal = null

  @_show: (options) ->
    options.onCloseCallback = @_initialize
    @_currentModal ||= new DashModal.View(options).show()

  @_initialize: =>
    @wrapperView = new DashModal.Navigation.ModalStackView()
    @_currentModal = null
