<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Order Details | Matcha Coffee</title>

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/order-details.css">
</head>

<body>

	<div class="card">

		<h2>Order #${order.id}</h2>

		<p>
			Status: <strong>${order.status}</strong><br> Payment: <strong>${order.paymentStatus}</strong><br>
			Method: <strong>${order.paymentMethod}</strong><br> Date: <strong>${order.createdAt}</strong>
		</p>

		<table>
			<tr>
				<th>Product</th>
				<th>Name</th>
				<th>Quantity</th>
				<th>Final Price</th>
			</tr>

			<c:forEach var="item" items="${items}">
				<tr>
					<td class="product-cell"><img
						src="${pageContext.request.contextPath}/img/menu/${item.imageUrl}"
						class="product-img">

						<div>
							<strong>${item.productName}</strong><br> <small>
								Milk: ${item.milkType}, Sugar: ${item.sugarLevel}, Ice:
								${item.iceLevel} </small>
						</div></td>

					<td>${item.quantity}</td>
					<td>$${item.finalPrice}</td>
				</tr>
			</c:forEach>
		</table>

		<div class="total-box">
			Subtotal: $${order.subtotal}<br> Shipping: $${order.shippingFee}<br>
			Total: <span style="color: var(--matcha-dark);">$${order.totalAmount}</span>
		</div>

		<!-- ACTION BUTTONS -->
		<a href="menu" class="btn-primary">← Back to Menu</a> <a href="cart"
			class="btn-primary">← Back to Cart</a> <a href="my-orders"
			class="btn-primary">📦 View My Orders</a>

	</div>

</body>
</html>