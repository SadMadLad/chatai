import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["chatTab"];
  static values = {
    notificationQuery: { type: string, default: "" },
    toggleClasses: { type: Array, default: ["bg-gray-100"] },
  };

  /**
   * Triggered when the chat tab target is connected. Scroll that chatTab into view when it newly appears
   * - usually when a new message comes in for the chat.
   * @param {HTMLElement} chatTab - The connected chat tab element.
   */
  chatTabTargetConnected(chatTab) {
    if (chatTab.dataset.notification === "0") return;

    if (window.innerWidth > 768) {
      chatTab.scrollIntoView({ block: "end", behavior: "smooth" });
    }
  }

  /**
   * Activates the classes of the chatTab when it is selected.
   * @param {object} e - The event object.
   */
  activateChatTab(e) {
    const selectedId = e.detail.newFrame.dataset.id;
    if (!selectedId || selectedId === "") return;

    this.chatTabTargets.forEach((target) => {
      target.dataset.id === `chat_${selectedId}`
        ? target.classList.add(...this.toggleClassesValue)
        : target.classList.remove(...this.toggleClassesValue);
    });
  }

  /**
   * Removes the notification icon.
   * @param {object} e - The event object.
   */
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
