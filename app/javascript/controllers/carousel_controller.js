import { Controller } from "@hotwired/stimulus";
import { useResize } from "stimulus-use";

export default class extends Controller {
  static targets = ["leftPadding", "rightPadding", "slide"];
  static values = { startingSlide: String };

  connect() {
    useResize(this);

    if (this.startingSlideValue) {
      this.element
        .querySelector(`#${this.startingSlideValue}`)
        .scrollIntoView();
    }
  }

  resize() {
    const containerWidth = this.element.clientWidth;
    const slideWidth = this.slideTargets[0].clientWidth;
    const remainder = containerWidth - slideWidth;
    const padding = remainder / 2;
    this.leftPaddingTarget.style.width = `${padding}px`;
    this.rightPaddingTarget.style.width = `${padding}px`;
  }
}
