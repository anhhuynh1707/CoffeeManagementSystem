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

    /* =========================
       CATEGORY DROPDOWN
    ========================= */
    const categorySelect = document.getElementById("customSelect");
    const categorySelected = document.getElementById("selectedOption");
    const categoryItems = categorySelect.querySelector(".select-items");

    const categoryInput = document.getElementById("categoryInput");
    const qInput = document.getElementById("qInput");

    // 🔥 IMPORTANT: correct sort input for CATEGORY form
    const categorySortInput = document.getElementById("categorySortInput");

    const categoryForm = document.getElementById("categoryForm");

    /* =========================
       SORT DROPDOWN
    ========================= */
    const sortSelect = document.getElementById("sortSelect");
    const sortSelected = document.getElementById("sortSelected");
    const sortItems = sortSelect.querySelector(".select-items");

    // 🔥 correct sort input for SEARCH form
    const sortInput = document.getElementById("sortInput");

    const categoryLabels = {
        all: "All",
        coffee: "Coffee",
        matcha: "Matcha",
        tea: "Tea",
        "milk tea": "Milk Tea",
        bakery: "Bakery"
    };

    const sortLabels = {
        "": "Newest",
        price_asc: "Price ↑",
        price_desc: "Price ↓"
    };

    const urlParams = new URLSearchParams(window.location.search);

    const currentCategory = urlParams.get("category") || "all";
    const currentQ = urlParams.get("q") || "";
    const currentSort = urlParams.get("sort") || "";

    /* =========================
       INIT VALUES
    ========================= */
    categorySelected.textContent = categoryLabels[currentCategory] || "All";
    categoryInput.value = currentCategory;
    qInput.value = currentQ;
    categorySortInput.value = currentSort;

    sortSelected.textContent = sortLabels[currentSort] || "Newest";
    sortInput.value = currentSort;

    /* =========================
       CATEGORY EVENTS
    ========================= */
    categorySelected.addEventListener("click", (e) => {
        e.stopPropagation();
        categorySelect.classList.toggle("open");
        sortSelect.classList.remove("open");
    });

    categoryItems.querySelectorAll("div").forEach(option => {
        option.addEventListener("click", () => {
            categorySelected.textContent = option.textContent;
            categoryInput.value = option.dataset.value;
            categorySelect.classList.remove("open");

            categoryForm.submit(); // ✅ keeps q & sort
        });
    });

    /* =========================
       SORT EVENTS
    ========================= */
    sortSelected.addEventListener("click", (e) => {
        e.stopPropagation();
        sortSelect.classList.toggle("open");
        categorySelect.classList.remove("open");
    });

    sortItems.querySelectorAll("div").forEach(option => {
        option.addEventListener("click", () => {
            sortSelected.textContent = option.textContent;
            sortInput.value = option.dataset.value;
            sortSelect.classList.remove("open");

            sortSelect.closest("form").submit();
        });
    });

    /* =========================
       CLOSE ON OUTSIDE CLICK
    ========================= */
    document.addEventListener("click", () => {
        categorySelect.classList.remove("open");
        sortSelect.classList.remove("open");
    });
});