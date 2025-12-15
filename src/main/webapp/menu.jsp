<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Menu | Matcha Coffee</title>

<!-- Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/menu.css">
<script src="${pageContext.request.contextPath}/js/main.js"></script>
</head>

<body>

	<!-- NAVBAR -->
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

	<!-- TITLE -->
	<div class="menu-title">
		<h1>Our Menu 🍵</h1>
		<p>Explore our matcha creations, coffee brews, and signature
			drinks.</p>
	</div>

	<!-- CATEGORY FILTER -->
	<div class="filter-bar">
		<form action="${pageContext.request.contextPath}/menu" method="get">
			<select name="category" onchange="this.form.submit()">
				<option value="all" ${param.category == 'all' ? 'selected' : ''}>All</option>
				<option value="coffee"
					${param.category == 'coffee' ? 'selected' : ''}>Coffee</option>
				<option value="matcha"
					${param.category == 'matcha' ? 'selected' : ''}>Matcha</option>
				<option value="tea" ${param.category == 'tea' ? 'selected' : ''}>Tea</option>
				<option value="bakery"
					${param.category == 'bakery' ? 'selected' : ''}>Bakery</option>
			</select>
		</form>
	</div>

	<!-- MENU LIST -->
	<div class="menu-grid">

		<c:forEach var="item" items="${menuList}">
			<div class="item-card">
				<img
					src="${pageContext.request.contextPath}/img/menu/${item.imageUrl}">
				<h3>${item.name}</h3>
				<div class="price">$${item.price}</div>

				<form action="${pageContext.request.contextPath}/cart" method="get">
					<input type="hidden" name="op" value="add"> <input
						type="hidden" name="pid" value="${item.id}">

					<!-- QUANTITY SELECTOR -->
					<div class="qty-control">
						<button type="button" onclick="decreaseQty(this)">−</button>

						<input type="number" name="qty" value="1" min="1" max="20"
							readonly>

						<button type="button" onclick="increaseQty(this)">+</button>
					</div>

					<button type="submit" class="btn-add">Add to Cart</button>
				</form>
			</div>
		</c:forEach>
	</div>

	<!-- FOOTER -->
	<div class="footer">Matcha Coffee © 2025 — Brewed with love 🍃</div>

</body>
</html>