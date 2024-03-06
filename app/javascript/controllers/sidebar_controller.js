import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tab", "sidebar", "controllerField"];
  static values = { show: Boolean };

  showValueChanged(showValue) {
    if(showValue) {
      this.tabTargets.forEach((tab) => {
        tab.classList.add("gap-5")
        tab.classList.remove("gap-20");
      });
      this.sidebarTarget.classList.add("w-60");
      this.sidebarTarget.classList.remove("md:w-20", "w-12");
    } else {
      this.tabTargets.forEach((tab) => {
        tab.classList.remove("gap-5")
        tab.classList.add("gap-20");
      })
      this.sidebarTarget.classList.add("md:w-20", "w-12");
      this.sidebarTarget.classList.remove("w-60");
    }
  }

  colorTab() {
    let src = this.controllerFieldTarget.value;

    this.tabTargets.forEach(tab => {
      if (tab.dataset.id === src) {
        tab.classList.add("border-primary-500", "border-l-4", "text-primary-500");
      } else {
        tab.classList.remove("border-primary-500", "border-l-4", "text-primary-500");
      }
    })
  }

  toggleSidebar() {
    this.showValue = !this.showValue;
  }
}
