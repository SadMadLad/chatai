import { Controller } from "@hotwired/stimulus";
import { FetchRequest } from "@rails/request.js";

export default class extends Controller {
  static targets = ["newAssistantMessage", "form", "submitButton", "spinner"];
  static validChatStatuses = ["AwaitingUserReply", "Processing"];
  static values = { chatId: String, chatStatus: String };

  /**
   * Triggered when the form target is connected. Disable the form if chat is in processing.
   * @param {HTMLElement} form - The connected form element.
   */
  formTargetConnected(form) {
    form.inert = this.#isProcessing();
  }

  /**
   * Triggered when the submit button target is connected. Disable the button if chat is in processing.
   * @param {HTMLElement} button - The connected submit button element.
   */
  submitButtonTargetConnected(button) {
    button.disabled = this.#isProcessing();
  }

  /**
   * Triggered when the new assistant message comes in. Sets the status of chat to AwaitingUserReply.
   */
  newAssistantMessageTargetConnected() {
    this.chatStatusValue = "AwaitingUserReply";
  }

  /**
   * Triggered when the chat status value changes. Disable the form if chat is in processing status.
   */
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

  /**
   * Signals the start of form submission.
   */
  submitStart() {
    this.chatStatusValue = "Processing";
  }

  /**
   * Signals the end of form submission. When the user has sent the message, it signals to autocomplete it.
   * @param {object} e - The event object.
   */
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
      this.chatStatusValue = "AwaitingUserReply";
    }
  }

  /**
   * Checks if the chat is in a processing state.
   * @returns {boolean} - True if chat is in processing state, false otherwise.
   */
  #isProcessing() {
    return this.chatStatusValue === "Processing";
  }
}
