import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "tab",
    "sidebar",
    "controllerField",
    "showButton",
    "hideButton",
    "hideable",
  ];
  static values = {
    show: { type: Boolean, default: true },
    tabShowClasses: { type: Array, default: ["gap-5"] },
    tabHideClasses: { type: Array, default: ["gap-20"] },
    sidebarShowClasses: { type: Array, default: ["w-60"] },
    sidebarHideClasses: { type: Array, default: ["md:w-20", "w-12"] },
    sidebarToggleButtonClasses: { type: Array, default: ["hidden", "md:block"] }
  };

  /**
   * Triggered when the tab target is connected.
   * Toggles classes based on the 'show' value.
   * @param {HTMLElement} tab - The connected tab element.
   */
  tabTargetConnected(tab) {
    if (this.loading) return;

    this.#toggleTabClasses(tab);
  }

  /**
   * Triggered when the hideable target is connected.
   * Shows or hides the hideable element based on the 'show' value.
   * @param {HTMLElement} hideable - The connected hideable element.
   */
  hideableTargetConnected(hideable) {
    if (this.loading) return;

    this.showValue
      ? hideable.classList.remove("hidden")
      : hideable.classList.add("hidden");
  }

  /**
   * Initializes the controller. Sets the the loading flag to be true.
   */
  initialize() {
    this.loading = true;
  }

  /**
   * Triggered when the controller is connected.
   * Sets loading to false, indicating that the sidebar is successfully loaded.
   */
  connect() {
    this.loading = false;
  }

  /**
   * Toggles classes on the tab based on the 'show' value.
   * @param {HTMLElement} tab - The tab element.
   */
  #toggleTabClasses(tab) {
    if (this.showValue) {
      tab.classList.add(...this.tabShowClassesValue);
      tab.classList.remove(...this.tabHideClassesValue);
    } else {
      tab.classList.remove(...this.tabShowClassesValue);
      tab.classList.add(...this.tabHideClassesValue);
    }
  }

  /**
   * Handles changes in the 'show' value.
   * Toggles classes and visibility based on the 'show' value.
   * @param {boolean} showValue - The new value of 'show'.
   */
  showValueChanged(showValue) {
    this.tabTargets.forEach((tab) => this.#toggleTabClasses(tab));
    if (showValue) {
      this.sidebarTarget.classList.add(...this.sidebarShowClassesValue);
      this.sidebarTarget.classList.remove(...this.sidebarHideClassesValue);
      this.hideableTargets.forEach((hideable) =>
        hideable.classList.remove("hidden"),
      );
    } else {
      this.sidebarTarget.classList.add(...this.sidebarHideClassesValue);
      this.sidebarTarget.classList.remove(...this.sidebarShowClassesValue);
      this.hideableTargets.forEach((hideable) =>
        hideable.classList.add("hidden"),
      );
    }

    this.#toggleSidebarButtons(showValue);
  }

  /**
   * Toggles classes on the sidebar buttons based on the 'show' value.
   * @param {boolean} showValue - The current value of 'show'.
   */
  #toggleSidebarButtons(showValue) {
    if (!this.hasShowButtonTarget || !this.hasHideButtonTarget) return;

    if (showValue) {
      this.showButtonTarget.classList.remove(
        ...this.sidebarToggleButtonClassesValue,
      );
      this.hideButtonTarget.classList.add(
        ...this.sidebarToggleButtonClassesValue,
      );
    } else {
      this.showButtonTarget.classList.add(
        ...this.sidebarToggleButtonClassesValue,
      );
      this.hideButtonTarget.classList.remove(
        ...this.sidebarToggleButtonClassesValue,
      );
    }
  }

  /**
   * Colors the tab based on the value of the controller field.
   */
  colorTab() {
    const src = this.controllerFieldTarget.value;

    this.tabTargets.forEach((tab) => {
      if (tab.dataset.id === src) {
        tab.classList.add(
          "border-primary-500",
          "border-l-4",
          "text-primary-500",
        );
      } else {
        tab.classList.remove(
          "border-primary-500",
          "border-l-4",
          "text-primary-500",
        );
      }
    });
  }

  /**
   * Toggles the 'show' value.
   */
  toggleSidebar() {
    this.showValue = !this.showValue;
  }
}
