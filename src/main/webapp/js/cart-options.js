document.addEventListener("DOMContentLoaded", () => {

    document.querySelectorAll(".toggle-group").forEach(group => {

        const name = group.dataset.name; // milk | sugar | ice
        const form = group.closest("form");
        const hiddenInput = form.querySelector(`input[name="${name}"]`);

        group.querySelectorAll(".toggle-btn").forEach(btn => {

            btn.addEventListener("click", () => {

                // remove active from siblings
                group.querySelectorAll(".toggle-btn")
                     .forEach(b => b.classList.remove("active"));

                // activate clicked
                btn.classList.add("active");

                // update hidden input
                hiddenInput.value = btn.dataset.value;

                // smooth auto submit
                setTimeout(() => form.submit(), 150);
            });

        });

    });

});