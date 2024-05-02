import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  /**
   * Removes the flash message after a delay upon connection.
   */
  connect() {
    setTimeout(() => this.element.remove(), 3000);
  }
}
