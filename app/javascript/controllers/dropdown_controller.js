import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dropdown"];
  static values = {
    show: { type: Boolean, default: false },
    otherToggleClasses: { type: Array, default: [] },
  };

  showValueChanged(show) {
    if (show) {
      this.dropdownTarget.classList.remove("w-0", "h-0");
      this.dropdownTarget.classList.add(
        "w-auto",
        "h-auto",
        ...this.otherToggleClassesValue,
      );
    } else {
      this.dropdownTarget.classList.remove(
        "w-auto",
        "h-auto",
        ...this.otherToggleClassesValue,
      );
      this.dropdownTarget.classList.add("w-0", "h-0");
    }
  }

  toggle() {
    this.showValue = !this.showValue;
  }
}
