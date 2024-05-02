import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["form", "errorField"];

  /**
   * Clears the form and removes error fields upon successful form submission.
   * @param {object} e - The event object.
   */
  clear(e) {
    if (!e.detail.success) return;

    this.formTarget.reset();
    this.errorFieldTargets.forEach((errorField) => errorField.remove());
  }
}
