import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.classList.add("bump")

    setTimeout(() => {
      this.element.classList.remove("bump")
    }, 300)
  }
}
