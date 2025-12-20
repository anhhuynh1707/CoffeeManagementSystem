document.addEventListener("DOMContentLoaded", () => {

    if (!window.ORDER_CREATED_AT || !window.ORDER_ID) {
        console.error("Missing order data for countdown");
        return;
    }

    // Convert "2025-01-16T10:30:00" → Date
    const createdAt = new Date(window.ORDER_CREATED_AT.replace(" ", "T"));

    // 2 minutes countdown
    const EXPIRY_MS = 2 * 60 * 1000;
    const expiryTime = new Date(createdAt.getTime() + EXPIRY_MS);

    const countdownEl = document.getElementById("countdown");

    const timer = setInterval(() => {
        const now = new Date();
        const remaining = expiryTime - now;

        if (remaining <= 0) {
            clearInterval(timer);
            countdownEl.textContent = "00:00";

            // Auto cancel
            window.location.href =
                `payment-result?status=failed&orderId=${window.ORDER_ID}`;
            return;
        }

        const minutes = Math.floor(remaining / 60000);
        const seconds = Math.floor((remaining % 60000) / 1000);

        countdownEl.textContent =
            `${String(minutes).padStart(2, "0")}:${String(seconds).padStart(2, "0")}`;

    }, 1000);
});