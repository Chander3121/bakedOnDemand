import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  static targets = ["window", "input"]

  toggle() {
    this.windowTarget.classList.toggle("hidden")
  }

  async sendMessage(event) {
    event.preventDefault()

    const message = this.inputTarget.value

    if (!message.trim()) return

    // 🔥 Add user message
    this.addMessage(message, "user")

    this.inputTarget.value = ""

    // 🔥 API request
    const response = await fetch("/ai_chats", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token":
          document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({
        message: message
      })
    })

    const data = await response.json()

    // 🔥 Add AI response
    this.addMessage(
      data.message,
      "ai",
      data.products
    )
  }

  addMessage(message, type, products = []) {

    const messagesContainer =
      this.windowTarget.querySelector(".messages")

    const wrapper = document.createElement("div")

    wrapper.className =
      type === "user"
        ? "flex justify-end"
        : "flex gap-2"

    wrapper.innerHTML =
      type === "user"
        ? `
          <div class="bg-pink-500 text-white
                      p-3 rounded-2xl rounded-br-sm
                      max-w-[80%]">
            ${message}
          </div>
        `
        : `
          <div class="w-8 h-8 rounded-full bg-pink-500
                      text-white flex items-center
                      justify-center text-sm">
            AI
          </div>

          <div>

            <div class="bg-white p-3 rounded-2xl
                        rounded-tl-sm shadow-sm
                        max-w-[80%] mb-3">

              ${message}

            </div>

            ${
              products.length > 0
                ? `
                  <div class="grid gap-3 ml-10">

                    ${products.map(product => `

                      <a href="/products/${product.id}"
                         class="bg-white rounded-2xl p-3
                                shadow-sm border flex gap-3
                                hover:shadow-md transition">

                        <img
                          src="${product.image}"
                          class="w-20 h-20 rounded-xl object-cover">

                        <div class="flex-1">

                          <h4 class="font-semibold text-sm">
                            ${product.name}
                          </h4>

                          <div class="flex items-center gap-2 mt-1">

                            <span class="text-green-600 font-bold">
                              ₹${product.price}
                            </span>

                            <span class="text-xs bg-green-600
                                         text-white px-2 py-0.5 rounded-full">

                              ⭐ ${product.rating}

                            </span>

                          </div>

                          <div class="mt-2">

                            <span class="text-xs text-pink-500 font-medium">
                              View Product →
                            </span>

                          </div>

                        </div>

                      </a>

                    `).join("")}

                  </div>
                `
                : ""
            }

          </div>
        `

    messagesContainer.appendChild(wrapper)

    messagesContainer.scrollTop =
      messagesContainer.scrollHeight
  }
}
