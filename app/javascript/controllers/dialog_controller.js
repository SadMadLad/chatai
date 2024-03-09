import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dialog", "closeButton"];

  dialogTargetConnected() {
    this.dialogTarget.showModal();
  }

  removeDialog(e) {
    if (e.target === this.dialogTarget || e.target === this.closeButtonTarget) {
      this.dialogTarget.remove()
    }
  }
}
