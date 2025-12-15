<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Checkout | Matcha Coffee</title>

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/checkout.css">
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

	<div class="wrapper">

		<h1>Checkout 🍃</h1>

		<!-- ORDER SUMMARY -->
		<div class="summary-box">
			<div class="summary-row">
				<span>Subtotal</span> <span>$${subtotal}</span>
			</div>

			<div class="summary-row">
				<span>Shipping Fee</span> <span>$${shipping}</span>
			</div>

			<div class="summary-row summary-total">
				<span>Total</span> <span>$${total}</span>
			</div>
		</div>

		<!-- PAYMENT METHODS -->
		<h3>Select Payment Method</h3>

		<form action="checkout" method="post">

			<label class="payment-option"> <input type="radio"
				name="paymentMethod" value="COD" checked> Cash on Delivery
				(COD)
			</label> <label class="payment-option"> <label><input
					type="radio" name="paymentMethod" value="VIETQR"> </label> VietQR -
				Pay with QR code
			</label> <label class="payment-option"> <input type="radio"
				name="paymentMethod" value="CARD"> Credit / Debit Card
			</label>

			<button type="submit" class="btn-primary">Confirm Order</button>
		</form>

	</div>

</body>
</html>