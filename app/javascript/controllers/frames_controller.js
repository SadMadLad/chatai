import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  /**
   * Appends the new incoming element from the frame.
   * @param {object} e - The event object. e.newFrame is the new appended/incoming frame.
   */
  morphChildren(e) {
    e.target.replaceWith(...e.detail.newFrame.childNodes);
  }
}
