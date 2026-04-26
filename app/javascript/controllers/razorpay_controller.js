import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    key: String,
    amount: Number,
    orderId: String,
    orderInternalId: Number,
    csrfToken: String
  }

  connect() {
    if (this.initialized) return
    this.element.querySelector("button").disabled = true
    this.initialized = true

    this.initRazorpay()
  }

  initRazorpay() {
    if (!window.Razorpay) {
      setTimeout(() => this.initRazorpay(), 100)
      return
    }

    setTimeout(() => {
      this.rzp = new window.Razorpay({
        key: this.keyValue,
        amount: this.amountValue,
        currency: "INR",
        order_id: this.orderIdValue,

        handler: (response) => {
          fetch("/payment/verify", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "X-CSRF-Token": this.csrfTokenValue
            },
            body: JSON.stringify({
              order_id: this.orderInternalIdValue,
              razorpay_payment_id: response.razorpay_payment_id,
              razorpay_order_id: response.razorpay_order_id,
              razorpay_signature: response.razorpay_signature
            })
          }).then(() => {
            window.location.href = `/orders/${this.orderInternalIdValue}/success`
          })
        }
      })

      this.ready = true

      // 🔥 FIX: enable button here
      const btn = this.element.querySelector("button")
      if (btn) {
        btn.disabled = false
        btn.classList.remove("bg-gray-300", "cursor-not-allowed")
        btn.classList.add("bg-pink-500")
      }

    }, 50)
  }

  pay(event) {
    event.preventDefault()

    if (!this.ready || !this.rzp) {
      console.warn("Razorpay not ready yet")
      return
    }

    this.rzp.open()
  }
}