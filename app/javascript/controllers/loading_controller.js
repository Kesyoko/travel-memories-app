import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"

export default class extends Controller {
  static targets = ["anime"]

  connect() {
    this.hide()
  }
  // 追加時と再表示の時にアニメーションを表示
  show() {
    this.animeTarget.classList.remove("hidden")
  }
  // ↑の動作終了したら再度アニメーションを隠す
  hide() {
    this.animeTarget.classList.add("hidden")
  }
}
