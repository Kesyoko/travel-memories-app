import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = ["anime"]

  connect() {
    this.hide()
  }

  show() {
    this.animeTarget.classList.remove("hidden")
  }

  hide() {
    this.animeTarget.classList.add("hidden")
  }
}


