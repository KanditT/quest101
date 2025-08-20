import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["form"];

    connect() {
        this.element.addEventListener(
            "turbo:submit-end",
            this.handleSubmitEnd.bind(this)
        );
    }

    handleSubmitEnd(event) {
        if (event.detail.success) {
            this.formTarget.reset();
        }
    }
}
