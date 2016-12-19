import DashModalView from "dash_modal/view.js"

namespace("DashModal.Navigation")

window.DashModal.Navigation.Modal = {

  hasPrevious: function() {
    return DashModal.Navigation.Modal.wrapperView.childCount() > 1
  },

  hasCurrent: function() {
    return DashModal.Navigation.Modal.wrapperView.childCount() > 0
  },

  push: function(options) {
    DashModal.Navigation.Modal.wrapperView.push(options.view)
    options.view = DashModal.Navigation.Modal.wrapperView
    DashModal.Navigation.Modal._show(options)
  },

  pop: function() {
    DashModal.Navigation.Modal.wrapperView.pop()
    if(!DashModal.Navigation.Modal.hasCurrent()) {
      DashModal.Navigation.Modal.empty()
    }
  },

  empty: function() {
    if(DashModal.Navigation.Modal._currentModal) {
      DashModal.Navigation.Modal._currentModal.hide()
    }
    $("[data-id=modal-container]").empty()
    DashModal.Navigation.Modal.wrapperView = new DashModal.Navigation.ModalStackView()
    DashModal.Navigation.Modal._currentModal = null
  },

  _show: function(options) {
    options.onCloseCallback = DashModal.Navigation.Modal._initialize
    if(!DashModal.Navigation.Modal._currentModal) {
      DashModal.Navigation.Modal._currentModal = new DashModalView(options).show()
    }
  },

  _initialize: function() {
    DashModal.Navigation.Modal.wrapperView = new DashModal.Navigation.ModalStackView()
    DashModal.Navigation.Modal._currentModal = null
  }

}
