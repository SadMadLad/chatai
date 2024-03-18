import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static target = ["scrollable", "scrollContainer"];
  static values = {
    scrollableIntoView: { type: Boolean, default: false },
    scrollContainerToBottom: { type: Boolean, default: false },
  };

  scrollContainerTargetConnected(scrollContainer) {
    if (!this.scrollContainerToBottomValue) return;

    scrollContainer.scrollIntoView({ block: 'end' });
  }

  scrollableTargetConnected(scrollable) {
    if (!this.scrollableIntoViewValue) return;

    scrollable.scrollIntoView(true)
  }
}
