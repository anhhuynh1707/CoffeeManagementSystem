<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
<script src="${pageContext.request.contextPath}/js/weather.js"></script>
</head>

<body>

	<!-- NAVBAR -->
	<div class="navbar">

		<!-- LEFT: LOGO -->
		<a href="${pageContext.request.contextPath}/index.jsp"
			class="logo-link"> Matcha Coffee ☕ </a>

		<!-- RIGHT: ACTIONS -->
		<div class="weather-box" id="weatherBox">
			<span class="weather-icon" id="weatherIcon">⛅</span> <span
				class="weather-text" id="weatherText">Loading...</span> <span
				class="separator">|</span> <span class="weather-greet"> How
				do you feel today, <strong> <c:choose>
						<c:when test="${not empty sessionScope.currentUser}">
		                    ${sessionScope.currentUser.fullName}
		                </c:when>
						<c:otherwise>
		                    Guest
		                </c:otherwise>
					</c:choose>
			</strong>?
			</span>
		</div>
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
		<!-- CATEGORY FORM (JS controlled) -->
		<form id="categoryForm"
			action="${pageContext.request.contextPath}/menu" method="get">
			<input type="hidden" name="category" id="categoryInput"
				value="${param.category != null ? param.category : 'all'}">
			<!-- preserve search & sort -->
			<input type="hidden" name="q" id="qInput" value="${param.q}">
			<input type="hidden" name="sort" id="categorySortInput"
				value="${param.sort}">
			<div class="custom-select" id="customSelect">
				<div class="select-selected" id="selectedOption">All</div>
				<div class="select-items">
					<div data-value="all">All</div>
					<div data-value="coffee">Coffee</div>
					<div data-value="matcha">Matcha</div>
					<div data-value="tea">Tea</div>
					<div data-value="milk tea">Milk Tea</div>
					<div data-value="bakery">Bakery</div>
				</div>
			</div>
		</form>
		<!-- SEARCH + SORT FORM -->
		<form action="${pageContext.request.contextPath}/menu" method="get"
			class="search-sort-form">

			<!-- preserve category -->
			<input type="hidden" name="category"
				value="${param.category != null ? param.category : 'all'}">

			<!-- search -->
			<input type="text" name="q" placeholder="Search menu..."
				value="${param.q}">

			<!-- sort -->
			<input type="hidden" name="sort" id="sortInput"
				value="${param.sort != null ? param.sort : ''}">

			<!-- CUSTOM SORT DROPDOWN -->
			<div class="custom-select" id="sortSelect">
				<div class="select-selected" id="sortSelected">Newest</div>

				<div class="select-items">
					<div data-value="">Newest</div>
					<div data-value="price_asc">Price ↑</div>
					<div data-value="price_desc">Price ↓</div>
				</div>
			</div>
			<button type="submit">Search</button>
		</form>
	</div>

	<!-- MENU LIST -->
	<div class="menu-grid">

		<c:forEach var="item" items="${menuList}">
			<div class="item-card">
				<img
					src="${pageContext.request.contextPath}/img/menu/${item.imageUrl}">
				<h3>${item.name}</h3>
				<div class="price">
				    <fmt:formatNumber
				        value="${item.price}"
				        groupingUsed="true"
				        maxFractionDigits="0"/> VND
				</div>	

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