import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static target = ["scrollable", "scrollContainer"];
  static values = {
    scrollableIntoView: { type: Boolean, default: false },
    scrollContainerToBottom: { type: Boolean, default: false },
  };

  /**
   * Triggered when the scroll container target is connected.
   * Scrolls the container to the bottom if configured to do so.
   * @param {HTMLElement} scrollContainer - The connected scroll container element.
   */
  scrollContainerTargetConnected(scrollContainer) {
    if (!this.scrollContainerToBottomValue) return;

    scrollContainer.scrollIntoView({ block: "end" });
  }

  /**
   * Triggered when the scrollable target is connected.
   * Scrolls the scrollable element into view if configured to do so.
   * @param {HTMLElement} scrollable - The connected scrollable element.
   */
  scrollableTargetConnected(scrollable) {
    if (!this.scrollableIntoViewValue) return;

    scrollable.scrollIntoView(true);
  }
}
