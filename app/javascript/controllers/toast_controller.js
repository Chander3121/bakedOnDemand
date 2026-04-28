import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toast"]

  connect() {
    // show animation
    setTimeout(() => {
      this.toastTarget.classList.remove("opacity-0", "translate-y-5", "scale-95")
    }, 50)

    // hide after 2.5s
    setTimeout(() => {
      this.toastTarget.classList.add("opacity-0", "translate-y-5", "scale-95")
    }, 2500)
  }
}
