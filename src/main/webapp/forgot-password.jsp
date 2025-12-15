<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Forgot Password | Coffee Management</title>
<link rel="stylesheet" href="css/login.css">
</head>
<body>

	<div class="login-container">

		<h2>Forgot Password</h2>

		<c:if test="${not empty error}">
			<div class="error-box">${error}</div>
		</c:if>

		<c:if test="${not empty success}">
			<div class="success-box">${success}</div>
		</c:if>

		<form action="forgot-password" method="post">

			<div class="form-group">
				<label>Email</label> <input type="email" name="email"
					class="form-control" placeholder="Enter your registered email"
					required>
			</div>

			<div class="btn-container">
				<button type="submit" class="btn-login">Send</button>
			</div>

			<div class="form-footer">
				<a href="login.jsp">Back to login</a>
			</div>

		</form>
	</div>

</body>
</html>