<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Orders | Matcha Coffee</title>

<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/my-orders.css">
<script src="${pageContext.request.contextPath}/js/main.js"></script>
<script src="${pageContext.request.contextPath}/js/weather.js"></script>
</head>

<body>
<div class="navbar">

		<!-- LEFT: LOGO -->
		<a href="${pageContext.request.contextPath}/index.jsp"
			class="logo-link"> Matcha Coffee ☕ </a>

		<!-- RIGHT: ACTIONS -->
		<div class="weather-box" id="weatherBox">
		    <span class="weather-icon" id="weatherIcon">⛅</span>
		    <span class="weather-text" id="weatherText">Loading...</span>
		    <span class="separator">|</span>
		    <span class="weather-greet"> How do you feel today,
		        <strong>
		            <c:choose>
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

	<div class="wrapper">
		<h1>Your Orders 🍃</h1>

		<c:if test="${empty orders}">
			<p
				style="text-align: center; color: var(--matcha-dark); font-weight: bold;">
				You have no orders yet.</p>
		</c:if>

		<c:forEach var="o" items="${orders}">
			<div class="order-card">

				<div class="order-header">
					<span>Order #${o.id}</span> <span>${o.createdAt}</span>
				</div>

				<div class="order-details">
					<p>
						Total Cups: <b>${o.totalCups}</b>
					</p>
					<p>
						Total Amount: <b>$${o.totalAmount}</b>
					</p>
					<p>
						Payment Method: <b>${o.paymentMethod}</b>
					</p>

					<c:choose>
						<c:when test="${o.status == 'confirmed'}">
							<div class="status status-confirmed">Confirmed</div>
						</c:when>

						<c:when test="${o.status == 'pending'}">
							<div class="status status-pending">Pending</div>
						</c:when>

						<c:otherwise>
							<div class="status status-cancelled">Cancelled</div>
						</c:otherwise>
					</c:choose>
				</div>

				<a href="order-details?id=${o.id}" class="btn-view">View Details</a>

			</div>
		</c:forEach>
	</div>

</body>
</html>