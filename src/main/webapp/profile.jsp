<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Profile | Matcha Coffee</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --matcha-light: #E8F3E1;
            --matcha-green: #9BCF8E;
            --matcha-dark: #3A5F41;
            --brown-accent: #6A4E23;
            --white: #ffffff;
            --danger: #d84a4a;
        }

        body {
            margin: 0;
            font-family: "Noto Sans JP", sans-serif;
            background: var(--matcha-light);
            color: var(--matcha-dark);
        }

        /* NAVBAR */
        .navbar {
            width: 97%;
            background: var(--matcha-dark);
            color: var(--white);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 25px;
            height: auto;
            line-height: 1.4;
        }

        .navbar h2 {
            margin: 0;
        }

        .navbar div {
            display: flex;
            gap: 22px;
        }

        .navbar a {
            color: var(--white);
            text-decoration: none;
            font-weight: 500;
        }

        .navbar a:hover {
            color: var(--matcha-green);
        }

        /* MAIN WRAPPER */
        .wrapper {
            max-width: 900px;
            margin: 40px auto 60px;
            padding: 0 20px;
        }

        h1 {
            text-align: center;
            color: var(--brown-accent);
            margin-bottom: 30px;
            font-size: 2rem;
        }

        /* PROFILE CARD */
        .profile-card {
            background: var(--white);
            padding: 35px;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.08);
        }

        .profile-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .profile-header img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            border: 4px solid var(--matcha-green);
            object-fit: cover;
            margin-bottom: 10px;
        }

        .profile-name {
            font-size: 1.6rem;
            font-weight: bold;
        }

        .profile-email {
            color: #666;
            font-size: 0.95rem;
        }

        /* FORM */
        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            font-weight: bold;
            font-size: 14px;
            display: block;
        }

        .form-control {
            width: 100%;
            padding: 11px;
            border-radius: 8px;
            margin-top: 6px;
            border: 1px solid #ccc;
            background: #f4f4f4;
        }

        .form-control:disabled {
            opacity: 0.6;
        }

        /* BUTTONS */
        .btn {
            padding: 10px 22px;
            border-radius: 25px;
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
            display: inline-block;
            transition: 0.2s;
        }

        .btn-primary {
            background: var(--matcha-green);
            color: white;
            padding: 10px 22px;
            border-radius: 25px;
            border: none;
            cursor: pointer;
            transition: 0.2s;
        }
        .btn-primary:hover { background: var(--matcha-dark); }

        .btn-secondary {
            background: transparent;
            color: var(--matcha-dark);
            padding: 10px 22px;
            border-radius: 25px;
            border: 2px solid var(--matcha-dark);
            cursor: pointer;
            transition: 0.2s;
        }
        .btn-secondary:hover { background: var(--matcha-dark); color: white; }

        .btn-link {
            padding: 10px 20px;
            border-radius: 25px;
            background: transparent;
            border: 2px solid var(--matcha-dark);
            color: var(--matcha-dark);
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
        }
        .btn-link:hover { background: var(--matcha-dark); color: white; }

        .btn-danger {
            background: var(--danger);
            color: white;
            padding: 10px 22px;
            border-radius: 25px;
            border: none;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-danger:hover {
        	background: #b73838;
        }

        .actions {
            display: flex;
            justify-content: space-between;
            margin-top: 25px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }
    </style>

    <script>
        function enableEdit() {
            document.querySelectorAll(".editable").forEach(el => el.disabled = false);

            // show save + cancel
            document.getElementById("saveBtn").style.display = "inline-block";
            document.getElementById("cancelBtn").style.display = "inline-block";
            document.getElementById("editBtn").style.display = "none";

            // hide security actions (change password + delete)
            document.getElementById("securityActions").style.display = "none";
        }

        function cancelEdit() {
            window.location.reload();
        }
    </script>

</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <h2>Matcha Coffee ☕</h2>
    <div>
	<a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/menu">Menu</a>
        <a href="${pageContext.request.contextPath}/cart">Cart</a>
        <a href="${pageContext.request.contextPath}/profile">Profile</a>
        <a href="${pageContext.request.contextPath}/my-orders">Orders</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<div class="wrapper">
    <h1>Your Profile 🍃</h1>

    <div class="profile-card">

        <!-- PROFILE HEADER -->
        <div class="profile-header">
            <div class="profile-name">${user.fullName}</div>
            <div class="profile-email">${user.email}</div>
        </div>

        <!-- EDIT BUTTON -->
        <div style="text-align:center; margin-bottom:20px;">
            <button type="button" id="editBtn" class="btn btn-primary" onclick="enableEdit()">Edit Profile</button>
        </div>

        <!-- PROFILE FORM -->
        <form action="update-profile" method="post">

            <div class="form-group">
                <label>Full Name</label>
                <input disabled class="form-control editable" name="fullName" value="${user.fullName}">
            </div>

            <div class="form-group">
                <label>Email</label>
                <input disabled class="form-control" value="${user.email}">
            </div>

            <div class="form-group">
                <label>Phone</label>
                <input disabled class="form-control editable" name="phone" value="${user.phone}">
            </div>

            <div class="form-group">
                <label>Address</label>
                <input disabled class="form-control editable" name="address" value="${user.address}">
            </div>

            <!-- ACTION BUTTONS -->
            <div class="actions">

                <!-- LEFT: Save + Cancel -->
                <div style="display: flex; gap: 15px;">
                    <button type="submit" id="saveBtn" class="btn-primary" style="display:none;">Save Changes</button>
                    <button type="button" id="cancelBtn" class="btn-secondary" onclick="cancelEdit()" style="display:none;">Cancel</button>
                </div>

                <!-- RIGHT: Security Buttons -->
                <div id="securityActions" style="display: flex; gap: 15px; margin-left:auto;">
                    <a href="change-password.jsp" class="btn-link">Change Password</a>
                    <a href="delete-account.jsp" class="btn-danger">Delete Account</a>
                </div>

            </div>

        </form>

    </div>
</div>

</body>
</html>