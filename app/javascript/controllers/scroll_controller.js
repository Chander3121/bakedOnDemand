import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["header"]

  connect() {
    this.element.addEventListener("scroll", this.handleScroll.bind(this))
  }

  handleScroll() {
    if (this.element.scrollTop > 10) {
      this.headerTarget.classList.add("shadow-md")
    } else {
      this.headerTarget.classList.remove("shadow-md")
    }
  }
}
