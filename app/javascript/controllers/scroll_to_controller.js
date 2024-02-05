import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { selector: String };

  connect() {
    document.addEventListener("turbo:load", () => {
      this.element.querySelector(`${this.selectorValue}`).scrollIntoView();
    });
  }
}
