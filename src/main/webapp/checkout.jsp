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

<style>
:root {
	--matcha-light: #E8F3E1;
	--matcha-green: #9BCF8E;
	--matcha-dark: #3A5F41;
	--brown-accent: #6A4E23;
	--white: #ffffff;
}

body {
	margin: 0;
	background: var(--matcha-light);
	font-family: "Noto Sans JP", sans-serif;
	color: var(--matcha-dark);
}

/* NAVBAR */
.navbar {
	width: 97%;
	background: var(--matcha-dark);
	color: var(--white);
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 14px 25px;
	height: auto;
	line-height: 1.4;
}

.navbar h2 {
	margin: 0;
}

.navbar div {
	display: flex;
	gap: 22px;
}

.navbar a {
	color: var(--white);
	text-decoration: none;
	font-weight: 500;
}

.navbar a:hover {
	color: var(--matcha-green);
}

/* MAIN WRAPPER */
.wrapper {
	max-width: 900px;
	margin: 40px auto;
	background: var(--white);
	padding: 35px;
	border-radius: 20px;
	box-shadow: 0 8px 18px rgba(0, 0, 0, 0.1);
}

h1 {
	text-align: center;
	color: var(--brown-accent);
	margin-bottom: 30px;
	font-size: 2rem;
}

/* SUMMARY BOX */
.summary-box {
	padding: 20px;
	background: #f7f7f7;
	border-radius: 12px;
	margin-bottom: 25px;
}

.summary-row {
	display: flex;
	justify-content: space-between;
	margin: 8px 0;
	font-size: 1.05rem;
}

.summary-total {
	font-weight: bold;
	font-size: 1.2rem;
	margin-top: 10px;
	padding-top: 10px;
	border-top: 1px solid #ccc;
}

/* PAYMENT METHODS */
.payment-box {
	margin-top: 25px;
}

.payment-option {
	background: #f2f7f2;
	border: 2px solid var(--matcha-green);
	padding: 15px;
	border-radius: 12px;
	margin-bottom: 12px;
	cursor: pointer;
	display: flex;
	align-items: center;
	gap: 10px;
}

.payment-option:hover {
	background: #e1f3de;
}

.payment-option input {
	transform: scale(1.3);
	cursor: pointer;
}

/* BUTTON */
.btn-primary {
	width: 100%;
	padding: 12px;
	background: var(--matcha-green);
	color: white;
	border: none;
	border-radius: 25px;
	font-weight: bold;
	cursor: pointer;
	margin-top: 20px;
	font-size: 1.1rem;
}

.btn-primary:hover {
	background: var(--matcha-dark);
}
</style>

</head>
<body>

	<!-- NAVBAR -->
	<div class="navbar">
		<h2>Matcha Coffee ☕</h2>
		<div>
			<a href="${pageContext.request.contextPath}/index.jsp">Home</a> <a
				href="${pageContext.request.contextPath}/menu">Menu</a> <a
				href="${pageContext.request.contextPath}/cart">Cart</a> <a
				href="${pageContext.request.contextPath}/profile">Profile</a> <a
				href="${pageContext.request.contextPath}/my-orders">Orders</a> <a
				href="${pageContext.request.contextPath}/logout">Logout</a>
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