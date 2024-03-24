import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['newUserMessage'];
  static values = { chatId: String }

  async newUserMessageTargetConnected() {
    if (!this.chatIdValue || this.chatIdValue === '') return;

    const autocompletion = await fetch(`http://localhost:8000/chats/${this.chatIdValue}/autocomplete`, { method: 'post' })
    console.log(autocompletion)
  }
}
