<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Your Cart | Matcha Coffee</title>

<!-- Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/cart.css">
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

	<!-- MAIN -->
	<div class="wrapper">

		<h1>Your Cart 🛒</h1>

		<!-- SUCCESS NOTIFICATION -->
		<c:if test="${not empty successMsg}">
			<div
				style="margin: 15px 0; padding: 12px 18px; border-radius: 8px; background: #e3f8e5; color: #256029; border: 1px solid #a4d5aa; font-weight: 500;">
				${successMsg}</div>
		</c:if>

		<!-- EMPTY CART -->
		<c:if test="${empty cartItems}">
			<div class="empty">
				<p>Your cart is empty 🍃</p>
				<a href="${pageContext.request.contextPath}/menu"
					class="btn-primary">Browse Menu</a>
			</div>
		</c:if>

		<!-- CART ITEMS -->
		<c:forEach var="item" items="${cartItems}">
			<div class="cart-item">

				<!-- IMAGE -->
				<img
					src="${pageContext.request.contextPath}/img/menu/${item.imageUrl}"
					class="cart-img" alt="${item.productName}">

				<!-- INFO -->
				<div class="item-info">
					<h3>${item.productName}</h3>
					<div class="item-price">$${item.finalPrice}</div>
				</div>

				<!-- ACTIONS -->
				<div class="item-actions">

					<div class="quantity-box">
						<a href="cart?op=dec&cid=${item.cartId}" class="qty-btn">−</a> <span
							class="qty-display">${item.quantity}</span> <a
							href="cart?op=inc&cid=${item.cartId}" class="qty-btn">+</a>
					</div>

					<a href="cart?op=remove&cid=${item.cartId}" class="remove-btn">
						Remove </a>
				</div>

			</div>
		</c:forEach>

		<!-- SUMMARY -->
		<c:if test="${not empty cartItems}">
			<div class="summary">
				<h2>Order Summary</h2>

				<div class="summary-row">
					<span>Subtotal</span> <span>$${subtotal}</span>
				</div>
				<div class="summary-row">
					<span>Shipping Fee</span> <span>$${shipping}</span>
				</div>

				<div class="summary-row summary-total">
					<span>Total</span> <span>$${total}</span>
				</div>

				<a href="${pageContext.request.contextPath}/checkout"
					class="btn-primary"> Proceed to Checkout </a> <a
					href="${pageContext.request.contextPath}/menu"
					class="btn-secondary"> Continue Shopping </a>
			</div>
		</c:if>

	</div>

</body>
</html>