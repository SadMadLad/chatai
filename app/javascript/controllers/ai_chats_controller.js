import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from "@rails/request.js";

export default class extends Controller {
  static targets = ["newAssistantMessage", "form", "submitButton", "spinner"];
  static validChatStatuses = ["AwaitingUserReply", "Processing"];
  static values = { chatId: String, chatStatus: String };

  formTargetConnected(form) {
    form.inert = this.#isProcessing();
  }

  submitButtonTargetConnected(button) {
    button.disabled = this.#isProcessing();
  }

  newAssistantMessageTargetConnected() {
    this.chatStatusValue = "AwaitingUserReply";
  }

  chatStatusValueChanged() {
    if (!this.hasFormTarget || !this.hasSpinnerTarget) return;

    this.formTarget.inert = this.#isProcessing();
    this.submitButtonTarget.disabled = this.#isProcessing();

    if (this.#isProcessing()) {
      this.spinnerTarget.classList.remove("hidden");
    } else {
      this.spinnerTarget.classList.add("hidden");
    }
  }

  submitStart() {
    this.chatStatusValue = "Processing";
  }

  submitEnd(e) {
    if (!this.chatIdValue || this.chatIdValue === "") return;
    if (e.detail.success) {
      const request = new FetchRequest(
        "post",
        `/chats/${this.chatIdValue}/autocomplete`,
        { responseKind: "turbo-stream" },
      );

      request.perform();
    } else {
      this.chatStatusValue = "AwaitingUserReply"
    }
  }

  #isProcessing() {
    return this.chatStatusValue === "Processing";
  }
}
