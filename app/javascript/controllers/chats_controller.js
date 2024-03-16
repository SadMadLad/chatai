import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chatTab"];

  activateChatTab(e) {
    const selectedId = e.detail.newFrame.dataset.id;
    this.chatTabTargets.forEach((target) => {
      target.dataset.id === `chat_${selectedId}`
          ? target.classList.add("bg-orange-500")
          : target.classList.remove("bg-orange-500")
    });
  }

  removeNotificationIcon(e) {
    const notificationIcon = e.currentTarget.querySelector('i');
    if (notificationIcon) {
      notificationIcon.remove();
    }
  }
}
