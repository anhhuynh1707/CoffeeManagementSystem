<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Change Password | Matcha Coffee</title>

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/change-password.css">

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
				<label>Current Password</label> <input type="password"
					name="currentPassword" class="form-control" required>
			</div>

			<div class="form-group">
				<label>New Password</label> <input type="password"
					name="newPassword" class="form-control" required>
			</div>

			<div class="form-group">
				<label>Confirm New Password</label> <input type="password"
					name="confirmPassword" class="form-control" required>
			</div>

			<button type="submit" class="btn-primary">Update Password</button>

			<a href="profile" class="btn-secondary">← Back to Profile</a>

		</form>
	</div>

</body>
</html>