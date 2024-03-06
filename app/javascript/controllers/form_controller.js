import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "errorField"];

  clear(e) {
    if (!e.detail.success) return;

    this.formTarget.reset();
    this.errorFieldTargets.forEach((errorField) => errorField.remove());
  }
}
