import Backbone from "backbone"
import EscapeKeyUp from "dash_modal/escape_key_up.js"
import NullEscapeKeyUp from "dash_modal/null_escape_key_up.js"
import template from "dash_modal/template.ejs"

export default class extends Backbone.View {

  initialize(options) {
    this.options = options
    this.escapeKeyUp = this.buildEscapeKeyUp()
    this.view = options.view
    this.container = options.container || $("[data-id=modal-container]")
  }

  events() {
    return {
      "click [data-id=modal]"           : "stopPropagation",
      "click [data-id=dash-overlay]"    : "outerCountainerClick",
      "click [data-id=close]"           : "hide"
    }
  }

  stopPropagation(event) {
    event.stopPropagation()
  }

  outerCountainerClick() {
    if(this.options.shouldCloseOnOverlay) {
      this.hide()
    }
  }

  show() {
    this.escapeKeyUp.respondWith(this.hide.bind(this))
    this.$el.html(template({ modalSize: this.options.modalSize }))
    if(!this.options.hasXButton) {
      this.removeCloseButton()
    }
    this.listenTo(this.view, "hideModal", this.hide.bind(this))
    this.$("[data-id=view-container]").html(this.modalHtml())
    $("body").addClass("prevent-scrolling")
    this.$("[data-id=modal]").addClass("in")
    this.container.html(this.el)
    this.$("[data-id=view-container]").focus()
    this.$el.show(function() {
      this.view.trigger("showModalComplete")
    }.bind(this))
    return this
  }

  hide() {
    this.escapeKeyUp.removeListeners()
    if(this.options.onCloseCallback) {
      this.options.onCloseCallback()
    }
    this.$("[data-id=modal]").removeClass("in")
    this.$el.hide()
    if(!this.options.preventScrollingOnClose) {
      $("body").removeClass("prevent-scrolling")
    }
  }

  isVisible() {
    return $("body").hasClass("prevent-scrolling")
  }

  modalHtml() {
    if(this.view.$el.is(":empty")) {
      return this.view.render().$el
    } else {
      return this.view.$el
    }
  }

  removeCloseButton() {
    this.$("[data-id=close]").remove()
  }

  buildEscapeKeyUp() {
    if(this.options.shouldCloseOnEscape) {
      return new EscapeKeyUp()
    } else {
      return new NullEscapeKeyUp()
    }
  }

}
