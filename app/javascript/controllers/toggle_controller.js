import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleable"];
  static values = { toggledId: string };

  /**
   * Handles changes in the 'toggledId' value.
   * Toggles visibility and enables/disables elements based on the value.
   * @param {string} value - The new value of 'toggledId'.
   */
  toggledIdValueChanged(value) {
    const formNodeNames = ["INPUT", "FORM", "TEXTAREA"];

    this.toggleableTargets.forEach((toggleable) => {
      if (toggleable.dataset.toggleId === value) {
        toggleable.classList.remove("hidden");
        if (formNodeNames.some((name) => toggleable.nodeName === name)) {
          toggleable.disabled = false;
        }
      } else {
        toggleable.classList.add("hidden");
        if (formNodeNames.some((name) => toggleable.nodeName === name)) {
          toggleable.disabled = true;
        }
      }
    });
  }

  /**
   * Toggles the 'toggledId' value based on the event target's data attribute or value.
   * @param {object} e - The event object.
   */
  toggle(e) {
    this.toggledIdValue =
      e.currentTarget.dataset?.toggleId || e.currentTarget.value;
  }
}
