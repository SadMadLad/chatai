import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from '@rails/request.js'

export default class extends Controller {
  static targets = ['newUserMessage', 'form', 'spinner'];
  static values = {
    chatId: String,
    loading: { type: Boolean, default: false }
  }

  loadingValueChanged(loading) {
    if (!this.hasFormTarget || !this.hasSpinnerTarget) return;

    if (loading) {
      this.formTarget.inert = true;
      this.spinnerTarget.classList.remove('hidden')
    } else {
      this.formTarget.inert = false;
      this.spinnerTarget.classList.add('hidden');
    }
  }

  submitStart() {
    this.loadingValue = true;
  }

  submitEnd(e) {
    if (!this.chatIdValue || this.chatIdValue === '') return;

    if (e.detail.success) {
      const request = new FetchRequest('post', `/chats/${this.chatIdValue}/autocomplete`, { responseKind: 'turbo-stream' })
      const response = request.perform()

      if (response.ok) this.loadingValue = false
    }

  }
}
