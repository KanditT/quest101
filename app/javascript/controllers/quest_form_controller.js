import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["form", "input"];
    static values = {
        errorPlaceholder: {
            type: String,
            default: "please type in your quest...",
        },
    };

    connect() {
        this.originalPlaceholder =
            this.inputTarget.getAttribute("placeholder") || "";

        this.element.addEventListener("submit", this.handleSubmit);
        this.element.addEventListener("turbo:submit-end", this.handleSubmitEnd);
        this.inputTarget.addEventListener("input", this.handleInput);
    }

    handleSubmit = (e) => {
        if (this.inputTarget.value.trim().length === 0) {
            e.preventDefault();
            this.showError();
        }
    };

    handleSubmitEnd = (event) => {
        if (event.detail.success) {
            this.formTarget.reset();
            this.clearError();
        }
    };

    handleInput = () => {
        if (this.inputTarget.value.trim().length > 0) {
            this.clearError();
        }
    };

    showError() {
        this.inputTarget.value = "";
        this.inputTarget.setAttribute(
            "placeholder",
            this.errorPlaceholderValue
        );
        this.inputTarget.classList.add("placeholder-red-300");
    }

    clearError() {
        this.inputTarget.setAttribute("placeholder", this.originalPlaceholder);
        this.inputTarget.classList.remove("placeholder-red-300");
    }
}
