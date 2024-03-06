import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chatTab"];

  activateChatTab(e) {
    const selectedId = e.detail.newFrame.dataset.id;
    this.chatTabTargets.forEach((target) => {
      if (target.dataset.id === `chat_${selectedId}`)
        target.classList.add("bg-orange-500");
      else {
        target.classList.remove("bg-orange-500");
      }
    });
  }
}
