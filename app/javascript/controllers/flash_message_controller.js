import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]
  connect() {
    setTimeout(() => {
      this.messageTargets.forEach(message => {
        message.classList.add("opacity-none")
      });
    }, 2000)
  }
}
