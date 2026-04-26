import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  toggle(event) {
    const btn = event.currentTarget
    const tagId = btn.dataset.tagId
    const container = document.getElementById("tagInputs")

    const existing = container.querySelector(`input[value="${tagId}"]`)

    if (existing) {
      // ❌ remove
      existing.remove()
      btn.classList.remove("bg-pink-500", "text-white", "border-pink-500")
      btn.classList.add("bg-gray-100", "text-gray-700")
    } else {
      // ✅ add
      const input = document.createElement("input")
      input.type = "hidden"
      input.name = "product[tag_ids][]"
      input.value = tagId
      container.appendChild(input)

      btn.classList.remove("bg-gray-100", "text-gray-700")
      btn.classList.add("bg-pink-500", "text-white", "border-pink-500")
    }
  }
}
