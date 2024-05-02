import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dialog", "closeButton"];

  /**
   * Triggered when the dialog target is connected.
   */
  dialogTargetConnected() {
    this.dialogTarget.showModal();
  }

  /**
   * Removes the dialog element - usually when clicked on close or its outside.
   * @param {object} e - The event object.
   */
  removeDialog(e) {
    if (e.target === this.dialogTarget || e.target === this.closeButtonTarget) {
      this.dialogTarget.remove();
    }
  }
}
