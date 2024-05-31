import { Controller } from "@hotwired/stimulus";
import GLightbox from "glightbox";

export default class extends Controller {
  connect() {
    GLightbox();
  }
}
