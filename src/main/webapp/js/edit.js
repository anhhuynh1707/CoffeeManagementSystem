function enableEdit() {
    document.querySelectorAll(".editable").forEach(el => {
        el.disabled = false;
    });

    // show save + cancel
    document.getElementById("saveBtn").style.display = "inline-block";
    document.getElementById("cancelBtn").style.display = "inline-block";
    document.getElementById("editBtn").style.display = "none";

    // hide security actions
    document.getElementById("securityActions").style.display = "none";
}

function cancelEdit() {
    window.location.reload();
}
