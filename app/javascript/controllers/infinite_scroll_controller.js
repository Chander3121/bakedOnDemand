import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String }

  connect() {
    this.observer = new IntersectionObserver((entries) => {
      if (entries[0].isIntersecting) {
        this.loadMore()
      }
    })

    this.observer.observe(this.element)
  }

  disconnect() {
    if (this.observer) this.observer.disconnect()
  }

  loadMore() {
    this.observer.disconnect()

    fetch(this.urlValue, {
      headers: { Accept: "text/vnd.turbo-stream.html" }
    })
  }
}
