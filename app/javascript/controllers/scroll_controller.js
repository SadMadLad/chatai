import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static target = ["scrollable"];
  static values = { scrollIntoView: { type: Boolean, default: false } };

  scrollableTargetConnected(scrollable) {
    if (this.scrollIntoViewValue) {
      scrollable.scrollIntoView(true, { behavior: 'smooth' })
    }
  }
}
