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

  tabTargetConnected(tab) {
    if (this.loading) return;

    this.toggleTabClasses(tab);
  }

  initialize() {
    this.loading = true;
  }

  connect() {
    this.loading = false;
  }

  toggleTabClasses(tab) {
    if(this.showValue) {
      tab.classList.add(...this.tabShowClassesValue);
      tab.classList.remove(...this.tabHideClassesValue);
    } else {
      tab.classList.remove(...this.tabShowClassesValue);
      tab.classList.add(...this.tabHideClassesValue);
    }
  }


  showValueChanged(showValue) {
    this.tabTargets.forEach((tab) => this.toggleTabClasses(tab))
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

  #toggleSidebarButtons(showValue) {
    if (!this.hasShowButtonTarget || !this.hasHideButtonTarget) return;

    if (showValue) {
      this.showButtonTarget.classList.remove(...this.sidebarToggleButtonClassesValue);
      this.hideButtonTarget.classList.add(...this.sidebarToggleButtonClassesValue);
    } else {
      this.showButtonTarget.classList.add(...this.sidebarToggleButtonClassesValue);
      this.hideButtonTarget.classList.remove(...this.sidebarToggleButtonClassesValue);
    }
  }

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

  toggleSidebar() {
    this.showValue = !this.showValue;
  }
}
