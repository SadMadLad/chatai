import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from '@rails/request.js'

export default class extends Controller {
  static targets = ['newAssistantMessage', 'form', 'submitButton', 'spinner'];
  static values = {
    chatId: String,
    loading: { type: Boolean, default: false }
  }

  formTargetConnected(form) {
    form.inert = this.loadingValue
  }

  submitButtonTargetConnected(button) {
    button.disabled = this.loadingValue
  }

  newAssistantMessageTargetConnected() {
    this.loadingValue = false;
  }

  loadingValueChanged() {
    if (!this.hasFormTarget || !this.hasSpinnerTarget) return;

    this.formTarget.inert = this.loadingValue;
    this.submitButtonTarget.disabled = this.loadingValue;

    if (this.loadingValue) {
      this.spinnerTarget.classList.remove('hidden')
    } else {
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

      request.perform()
    } else {
        this.loadingValue = false;
    }
  }
}
