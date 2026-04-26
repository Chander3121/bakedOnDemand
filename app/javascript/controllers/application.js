import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }


document.addEventListener("click", function (e) {
  if (e.target.classList.contains("removeVariant")) {
    e.target.closest(".variant-item").remove()
  }
})


document.addEventListener("change", function (e) {
  if (e.target.id === "imageInput") {

    const preview = document.getElementById("imagePreview")
    preview.innerHTML = ""

    Array.from(e.target.files).forEach(file => {
      const reader = new FileReader()

      reader.onload = function (event) {
        const wrapper = document.createElement("div")
        wrapper.className = "relative group"

        const img = document.createElement("img")
        img.src = event.target.result
        img.className = "w-full h-24 object-cover rounded-lg"

        wrapper.appendChild(img)
        preview.appendChild(wrapper)

        const remove = document.createElement("button")
		remove.innerText = "✕"
		remove.className = "absolute top-1 right-1 bg-black/50 text-white text-xs px-1 rounded hidden group-hover:block"

		remove.onclick = () => wrapper.remove()
		wrapper.appendChild(remove)
      }

      reader.readAsDataURL(file)
    })
  }
})
