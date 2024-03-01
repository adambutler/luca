import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    window.addEventListener(
      "scroll",
      () => {
        var scale = 1 - window.scrollY / 250;
        if (scale < 0.6) {
          scale = 0.6;
        }
        let transformValue = `scale(${scale})`;
        this.element.style.transform = transformValue;
        this.element.style.transformOrigin = "bottom center";
      },
      false
    );
  }
}
