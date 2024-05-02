import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toBeCloned", "cloneContainer"];
  static values = { promptOnClone: { type: Boolean, default: false } };

  /**
   * Clones the target element and appends it to the container.
   */
  cloneTargetToContainer() {
    this.cloneContainerTarget.append(this.toBeClonedTarget.cloneNode(true));
  }

  /**
   * Removes the cloned target element.
   * @param {object} e - The event object.
   */
  removeCloneTarget(e) {
    if (this.toBeClonedTargets.length <= 1) return;

    e.target.parentElement.remove();
  }
}
