<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password | Coffee Management</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>

<div class="login-container">

    <h2>Reset Password</h2>

    <c:if test="${not empty error}">
        <div class="error-box">${error}</div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="success-box">${success}</div>
    </c:if>

    <form action="reset-password" method="post">

        <input type="hidden" name="token" value="${token}">

        <div class="form-group">
            <label>New Password</label>
            <input type="password" name="password" class="form-control" placeholder="Enter new password" required>
        </div>

        <div class="form-group">
            <label>Confirm Password</label>
            <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm new password" required>
        </div>

        <div class="btn-container">
            <button type="submit" class="btn-login">Reset Password</button>
        </div>

        <div class="form-footer">
            <a href="login.jsp">Back to login</a>
        </div>

    </form>
</div>

</body>
</html>