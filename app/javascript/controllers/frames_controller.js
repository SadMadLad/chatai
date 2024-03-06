import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  morphChildren(e) {
    e.target.replaceWith(...e.detail.newFrame.childNodes);
  }
}
