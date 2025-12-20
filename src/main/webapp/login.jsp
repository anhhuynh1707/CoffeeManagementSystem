<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Login | Coffee Management</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/login.css">
</head>

<body>

    <div class="login-container">

        <h2>Welcome Back 🍃</h2>

        <!-- Error message -->
        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

        <!-- Success message -->
        <c:if test="${not empty success}">
            <div class="success-msg">${success}</div>
        </c:if>
        <!-- Logout message from redirect -->
        <c:if test="${not empty param.message}">
            <div class="success-msg">${param.message}</div>
        </c:if>
        <form action="${pageContext.request.contextPath}/login" method="post">

            <div class="form-group">
                <label>Email</label>
                <input type="email" name="email" class="form-control" required placeholder="Enter your email">
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" class="form-control" required placeholder="Enter your password">
            </div>

            <div class="btn-container">
                <button type="submit" class="btn-login">Login</button>
            </div>

            <div class="links">
                <p><a href="${pageContext.request.contextPath}/register">Create Account</a></p>
                <p><a href="${pageContext.request.contextPath}/forgot-password">Forgot Password?</a></p>
            </div>
        </form>
    </div>
</body>
</html>