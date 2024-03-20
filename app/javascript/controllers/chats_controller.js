import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chatTab"];
  static values = {
    notificationQuery: { type: String, default: "" },
  };

  chatTabTargetConnected(chatTab) {
    if (chatTab.dataset.notification === "0") return;

    chatTab.scrollIntoView({ block: 'end', behavior: "smooth" })
  }

  activateChatTab(e) {
    const selectedId = e.detail.newFrame.dataset.id;
    this.chatTabTargets.forEach((target) => {
      target.dataset.id === `chat_${selectedId}`
        ? target.classList.add("bg-gray-100")
        : target.classList.remove("bg-gray-100");
    });
  }

  removeNotificationIcon(e) {
    if (this.notificationQueryValue === "") return;

    const notificationElement = e.currentTarget.querySelector(
      this.notificationQueryValue,
    );

    if (notificationElement) {
      notificationElement.remove();
    }
  }
}
