import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.remove()
    }, 2000)
  }
}
