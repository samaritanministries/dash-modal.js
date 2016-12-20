import DashModalView from "dash_modal/view.js"
import ModalStackView from "dash_modal/navigation/modal_stack_view.js"

export default class {

  static hasPrevious() {
    return this._wrapperView().childCount() > 1
  }

  static hasCurrent() {
    return this._wrapperView().childCount() > 0
  }

  static push(options) {
    this._wrapperView().push(options.view)
    options.view = this._wrapperView()
    this._show(options)
  }

  static pop() {
    this._wrapperView().pop()
    if(!this.hasCurrent()) {
      this.empty()
    }
  }

  static empty() {
    if(this._currentModal()) {
      this._currentModal().hide()
    }
    $("[data-id=modal-container]").empty()
    this._initialize()
  }

  static _show(options) {
    options.onCloseCallback = this._initialize.bind(this)
    if(!this._currentModal()) {
      this._setCurrentModal(new DashModalView(options).show())
    }
  }

  static _initialize() {
    this._setWrapperView(new ModalStackView())
    this._setCurrentModal(null)
  }

  static _wrapperView() {
    return DashModal.Navigation.Modal.wrapperView
  }

  static _setWrapperView(wrapperView) {
    DashModal.Navigation.Modal.wrapperView = wrapperView
  }

  static _currentModal() {
    return  DashModal.Navigation.Modal.currentModal
  }

  static _setCurrentModal(currentModal) {
    DashModal.Navigation.Modal.currentModal = currentModal
  }

}
