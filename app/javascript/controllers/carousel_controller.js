import { Controller } from "@hotwired/stimulus";
import { useResize, useDebounce } from "stimulus-use";

export default class extends Controller {
  static debounces = ["onScroll"];
  static targets = ["leftPadding", "rightPadding", "slide"];
  static values = { startingSlide: String };

  connect() {
    useResize(this);
    useDebounce(this, { wait: 60 });

    this.onScroll = this.onScroll.bind(this);
    this.element.addEventListener("scroll", this.onScroll);
  }

  disconnect() {
    this.removeEventListener("scroll", this.onScroll);
  }

  onScroll() {
    console.log("scrolling");
    const deltas = this.slideTargets.map((slide, index) => {
      const boundingClientRect = slide.getBoundingClientRect();
      const middle = boundingClientRect.left + boundingClientRect.width / 2;
      const delta = Math.abs(middle - this.containerWidth / 2);
      return [delta, index];
    });

    // Get index from the lowest delta
    const index = deltas.reduce((lowest, next) =>
      next[0] < lowest[0] ? next : lowest
    )[1];

    this.slideTargets.forEach((slide, i) => {
      i === index
        ? slide.classList.add("active")
        : slide.classList.remove("active");
    });
  }

  scrollIntoView() {
    if (this.startingSlideValue) {
      this.element
        .querySelector(`#${this.startingSlideValue}`)
        .scrollIntoView();
    }
  }

  resize() {
    this.containerWidth = this.element.clientWidth;
    const slideWidth = this.slideTargets[0].clientWidth;
    const remainder = this.containerWidth - slideWidth;
    const padding = remainder / 2;
    this.leftPaddingTarget.style.width = `${padding}px`;
    this.rightPaddingTarget.style.width = `${padding}px`;

    if (!this.firstResizeComplete) {
      this.scrollIntoView();
      this.firstResizeComplete = true;
    }
  }
}
