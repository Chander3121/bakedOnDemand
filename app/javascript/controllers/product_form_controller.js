import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["variants"]

  connect() {
    this.variantIndex = this.variantsTarget.children.length
  }

  addVariant() {
    const template = `
      <div class="variant-item grid grid-cols-4 gap-3 mb-3">
        <input type="text" name="product[product_variants_attributes][${this.variantIndex}][size]" placeholder="Size" class="border px-2 py-1 rounded text-sm"/>
        <input type="number" name="product[product_variants_attributes][${this.variantIndex}][price]" placeholder="Price" class="border px-2 py-1 rounded text-sm"/>
        <input type="number" name="product[product_variants_attributes][${this.variantIndex}][stock]" placeholder="Stock" class="border px-2 py-1 rounded text-sm"/>
        <button type="button" class="removeVariant text-red-500 text-sm">Remove</button>
      </div>
    `

    this.variantsTarget.insertAdjacentHTML("beforeend", template)
    this.variantIndex++
  }
}
