<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Your Profile | Matcha Coffee</title>

<!-- Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/profile.css">
<script src="${pageContext.request.contextPath}/js/edit.js"></script>
<script src="${pageContext.request.contextPath}/js/main.js"></script>

</head>

<body>

	<div class="navbar">

		<!-- LEFT: LOGO -->
		<a href="${pageContext.request.contextPath}/index.jsp"
			class="logo-link"> Matcha Coffee ☕ </a>

		<!-- RIGHT: ACTIONS -->
		<div class="nav-actions">
			<!-- USER -->
			<div class="user-menu" id="userMenu">
				<span class="user-name"> 👤
					${sessionScope.currentUser.fullName} </span>

				<div class="dropdown" id="dropdownMenu">
					<a href="${pageContext.request.contextPath}/menu">Menu</a> <a
						href="${pageContext.request.contextPath}/profile">Profile</a> <a
						href="${pageContext.request.contextPath}/my-orders">Orders</a>
					<hr>
					<a href="${pageContext.request.contextPath}/logout" class="logout">
						Logout </a>
				</div>
				<!-- CART -->
				<a href="${pageContext.request.contextPath}/cart" class="cart-btn">
					🛒 <c:if test="${sessionScope.cartCount > 0}">
						<span class="cart-badge">${sessionScope.cartCount}</span>
					</c:if>
				</a>
			</div>

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
			<div style="text-align: center; margin-bottom: 20px;">
				<button type="button" id="editBtn" class="btn btn-primary"
					onclick="enableEdit()">Edit Profile</button>
			</div>

			<!-- PROFILE FORM -->
			<form action="update-profile" method="post">

				<div class="form-group">
					<label>Full Name</label> <input disabled
						class="form-control editable" name="fullName"
						value="${user.fullName}">
				</div>

				<div class="form-group">
					<label>Email</label> <input disabled class="form-control"
						value="${user.email}">
				</div>

				<div class="form-group">
					<label>Phone</label> <input disabled class="form-control editable"
						name="phone" value="${user.phone}">
				</div>

				<div class="form-group">
					<label>Address</label> <input disabled
						class="form-control editable" name="address"
						value="${user.address}">
				</div>

				<!-- ACTION BUTTONS -->
				<div class="actions">

					<!-- LEFT: Save + Cancel -->
					<div style="display: flex; gap: 15px;">
						<button type="submit" id="saveBtn" class="btn-primary"
							style="display: none;">Save Changes</button>
						<button type="button" id="cancelBtn" class="btn-secondary"
							onclick="cancelEdit()" style="display: none;">Cancel</button>
					</div>

					<!-- RIGHT: Security Buttons -->
					<div id="securityActions"
						style="display: flex; gap: 15px; margin-left: auto;">
						<a href="change-password.jsp" class="btn-link">Change Password</a>
						<a href="delete-account.jsp" class="btn-danger">Delete Account</a>
					</div>

				</div>

			</form>

		</div>
	</div>

</body>
</html>