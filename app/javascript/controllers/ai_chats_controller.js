import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ['newUserMessage'];
  static values = { chatId: String }

  newUserMessageTargetConnected() {
    console.log('Ping')
  }
}
