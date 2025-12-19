<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Payment Result | Matcha Coffee</title>

<!-- Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/payment-result.css">
</head>

<body>

	<div class="container">

		<!-- SUCCESS STATE -->
		<c:if test="${status == 'success'}">
			<div class="success">✔</div>
			<h1 style="color: var(--brown-accent)">Payment Successful</h1>
			<p class="order-id">Order ID: #${orderId}</p>
			<p class="msg">Thank you! Your order is confirmed and being
				prepared. 🍃</p>
			<a href="menu" class="btn-secondary">Back to Menu</a>
			<a href="${pageContext.request.contextPath}/shipping?orderId=${param.orderId}"
			   class="btn-primary">
			    Track Your Order
			</a>
		</c:if>

		<!-- FAILED STATE -->
		<c:if test="${status == 'failed'}">
			<div class="fail">✘</div>
			<h1 style="color: var(--danger)">Payment Failed</h1>
			<p class="order-id">Order ID: #${orderId}</p>
			<p class="msg">Something went wrong. Please try again or use a
				different payment method.</p>

			<a href="checkout.jsp" class="btn-primary">Try Again</a>
			<a href="menu" class="btn-secondary">Return to Menu</a>
		</c:if>

	</div>

</body>
</html>