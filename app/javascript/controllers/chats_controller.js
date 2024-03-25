import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chatTab"];
  static values = {
    notificationQuery: { type: String, default: "" },
    toggleClasses: { type: Array, default: ["bg-gray-100"] },
  };

  chatTabTargetConnected(chatTab) {
    if (chatTab.dataset.notification === "0") return;

    if (window.innerWidth > 768) {
      chatTab.scrollIntoView({ block: "end", behavior: "smooth" });
    }
  }

  activateChatTab(e) {
    const selectedId = e.detail.newFrame.dataset.id;
    if (!selectedId || selectedId === "") return;

    this.chatTabTargets.forEach((target) => {
      target.dataset.id === `chat_${selectedId}`
        ? target.classList.add(...this.toggleClassesValue)
        : target.classList.remove(...this.toggleClassesValue);
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
