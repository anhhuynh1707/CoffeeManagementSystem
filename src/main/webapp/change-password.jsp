<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Change Password | Matcha Coffee</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap" rel="stylesheet">

<style>
    :root {
        --matcha-light: #E8F3E1;
        --matcha-green: #9BCF8E;
        --matcha-dark: #3A5F41;
        --danger: #d84a4a;
        --white: #ffffff;
    }

    body {
        margin: 0;
        background: var(--matcha-light);
        font-family: "Noto Sans JP", sans-serif;
        color: var(--matcha-dark);
    }

    /* CENTERED WRAPPER */
    .form-container {
        width: 360px;
        margin: 80px auto;
        background: var(--white);
        padding: 35px;
        border-radius: 18px;
        box-shadow: 0 8px 18px rgba(0,0,0,0.1);
        text-align: center;
    }

    h2 {
        margin-bottom: 18px;
        color: var(--matcha-dark);
    }

    .form-group {
        text-align: left;
        margin-bottom: 18px;
    }

    .form-group label {
        font-weight: bold;
        font-size: 14px;
    }

    .form-control {
        width: 95%;
        padding: 10px;
        margin-top: 6px;
        border-radius: 8px;
        border: 1px solid #ccc;
        background: #f4f4f4;
    }

    .btn-primary {
        width: 100%;
        padding: 12px;
        background: var(--matcha-green);
        color: white;
        border: none;
        border-radius: 25px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 15px;
    }
    .btn-primary:hover {
        background: var(--matcha-dark);
    }

    .btn-secondary {
        display: block;
        margin-top: 12px;
        padding: 10px;
        text-decoration: none;
        font-weight: bold;
        color: var(--matcha-dark);
    }
    .btn-secondary:hover {
        color: var(--brown);
        text-decoration: underline;
    }

    /* Messages */
    .error-msg {
        background: #ffd4d4;
        color: #a40000;
        padding: 10px;
        border-radius: 8px;
        margin-bottom: 15px;
        font-weight: bold;
    }

    .success-msg {
        background: #e3f8e5;
        color: #256029;
        padding: 10px;
        border-radius: 8px;
        margin-bottom: 15px;
        font-weight: bold;
    }
</style>

</head>
<body>

<div class="form-container">

    <h2>Change Password 🔐</h2>
	
    <!-- Error message -->
    <c:if test="${not empty error}">
        <div class="error-msg">${error}</div>
    </c:if>

    <!-- Success message -->
    <c:if test="${not empty success}">
        <div class="success-msg">${success}</div>
    </c:if>

    <form action="change-password" method="post">

        <div class="form-group">
            <label>Current Password</label>
            <input type="password" name="currentPassword" class="form-control" required>
        </div>

        <div class="form-group">
            <label>New Password</label>
            <input type="password" name="newPassword" class="form-control" required>
        </div>

        <div class="form-group">
            <label>Confirm New Password</label>
            <input type="password" name="confirmPassword" class="form-control" required>
        </div>

        <button type="submit" class="btn-primary">Update Password</button>

        <a href="profile" class="btn-secondary">← Back to Profile</a>

    </form>
</div>

</body>
</html>