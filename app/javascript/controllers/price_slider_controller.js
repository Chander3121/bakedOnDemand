import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["min", "max", "minLabel", "maxLabel", "minInput", "maxInput"]

  update() {
    let min = parseInt(this.minTarget.value)
    let max = parseInt(this.maxTarget.value)

    if (min > max) {
      [min, max] = [max, min]
    }

    this.minLabelTarget.innerText = min
    this.maxLabelTarget.innerText = max

    this.minInputTarget.value = min
    this.maxInputTarget.value = max

    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.element.closest("form").requestSubmit()
    }, 400)
  }
}
