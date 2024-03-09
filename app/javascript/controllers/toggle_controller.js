import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["toggleable"];
  static values = { toggledId: String };

  toggledIdValueChanged(value) {
    const formNodeNames = ['INPUT', 'FORM', 'TEXTAREA']

    this.toggleableTargets.forEach((toggleable) => {
      if (toggleable.dataset.toggleId === value) {
        toggleable.classList.remove('hidden');
        if (formNodeNames.some(name => toggleable.nodeName === name)) {
          toggleable.disabled = false
        }
      } else {
        toggleable.classList.add('hidden');
        if (formNodeNames.some(name => toggleable.nodeName === name)) {
          toggleable.disabled = true
        }
      }
    })
  }

  toggle(e) {
    this.toggledIdValue = e.currentTarget.dataset?.toggleId || e.currentTarget.value;
  }
}
