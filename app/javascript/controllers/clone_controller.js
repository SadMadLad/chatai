import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toBeCloned", "cloneContainer"];
  static value = { promptOnClone: { type: Boolean, default: false } };

  cloneTargetToContainer() {
    this.cloneContainerTarget.append(this.toBeClonedTarget.cloneNode(true));
  }

  removeCloneTarget(e) {
    if (this.toBeClonedTargets.length <= 1) return;

    e.target.parentElement.remove();
  }
}
