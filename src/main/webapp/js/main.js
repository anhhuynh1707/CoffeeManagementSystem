document.addEventListener("DOMContentLoaded", () => {
    const userMenu = document.getElementById("userMenu");
    const dropdown = document.getElementById("dropdownMenu");

    if (!userMenu || !dropdown) return;

    // Open / close on click
    userMenu.addEventListener("click", (e) => {
        e.stopPropagation();
        userMenu.classList.toggle("open");
    });

    // Close when clicking outside
    document.addEventListener("click", () => {
        userMenu.classList.remove("open");
    });
});
function increaseQty(btn) {
    const input = btn.parentElement.querySelector("input");
    let val = parseInt(input.value);
    if (val < 20) input.value = val + 1;
}

function decreaseQty(btn) {
    const input = btn.parentElement.querySelector("input");
    let val = parseInt(input.value);
    if (val > 1) input.value = val - 1;
}
document.addEventListener("DOMContentLoaded", () => {

    const select = document.getElementById("customSelect");
    const selected = document.getElementById("selectedOption");
    const items = select.querySelector(".select-items");
    const input = document.getElementById("categoryInput");
    const form = document.getElementById("categoryForm");

    const labels = {
        all: "All",
        coffee: "Coffee",
        matcha: "Matcha",
        tea: "Tea",
        "milk tea": "Milk Tea",
        bakery: "Bakery"
    };

    const urlParams = new URLSearchParams(window.location.search);
    const currentCategory = urlParams.get("category") || "all";

    selected.textContent = labels[currentCategory] || "All";
    input.value = currentCategory;

    // Toggle dropdown
    selected.addEventListener("click", (e) => {
        e.stopPropagation();
        select.classList.toggle("open");
    });

    // Select item
    items.querySelectorAll("div").forEach(option => {
        option.addEventListener("click", () => {
            selected.textContent = option.textContent;
            input.value = option.dataset.value;
            select.classList.remove("open");

            setTimeout(() => form.submit(), 150);
        });
    });

    // Close when clicking outside
    document.addEventListener("click", () => {
        select.classList.remove("open");
    });
});