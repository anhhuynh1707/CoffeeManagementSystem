<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register | Coffee Management</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>

<div class="login-container">

    <h2>Create Account</h2>

    <c:if test="${not empty error}">
        <div class="error-box">${error}</div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="success-box">${success}</div>
    </c:if>

    <form action="register" method="post">

        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="fullName" class="form-control" placeholder="Enter full name" required>
        </div>

        <div class="form-group">
            <label>Email</label>
            <input type="email" name="email" class="form-control" placeholder="Enter email" required>
        </div>

        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter password" required>
        </div>

        <div class="form-group">
            <label>Confirm Password</label>
            <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm password" required>
        </div>

        <div class="form-group">
            <label>Phone</label>
            <input type="text" name="phone" class="form-control" placeholder="Enter phone number">
        </div>

        <div class="form-group">
            <label>Address</label>
            <input type="text" name="address" class="form-control" placeholder="Enter address">
        </div>

        <div class="btn-container">
            <button type="submit" class="btn-login">Register</button>
        </div>

        <div class="form-footer">
            <a href="login">Already have an account? Login</a>
        </div>

    </form>
</div>

</body>
</html>