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