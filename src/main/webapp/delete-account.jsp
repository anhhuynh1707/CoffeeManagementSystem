<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Delete Account | Matcha Coffee</title>
<link rel="stylesheet" href="css/profile.css">
</head>
<body>

<div class="wrapper">
    <div class="profile-card">

        <h2 style="color:#c0392b;">⚠ Delete Account</h2>

        <p>
            This action <strong>cannot be undone</strong>.
            All your orders, cart items, and profile data will be permanently removed.
        </p>

        <form action="delete-account" method="post">
            <div class="form-group">
                <label>Confirm your password</label>
                <input type="password"
                       name="password"
                       class="form-control"
                       required>
            </div>

            <div class="actions">
                <button type="submit" class="btn-danger">
                    Yes, Delete My Account
                </button>

                <a href="profile" class="btn-secondary">
                    Cancel
                </a>
            </div>
        </form>

    </div>
</div>

</body>
</html>