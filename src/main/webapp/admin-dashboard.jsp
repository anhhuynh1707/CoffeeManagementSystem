<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard | Matcha Coffee</title>

<!-- Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="css/admin-dashboard.css">
</head>

<body>

	<!-- SIDEBAR -->
	<div class="sidebar">
		<h2>☘ Admin Panel</h2>
		<a href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
		<a href="products">Products</a> 
		<a href="orders">Orders</a> 
		<a href="users">Users</a> 
		<a href="logout">Logout</a>
			<div class="sidebar-footer">
			<a href="${pageContext.request.contextPath}/" class="back-home">← Back to Homepage</a>
    </div>
	</div>

	<!-- MAIN CONTENT -->
	<div class="content">

		<h1>Welcome, Admin 👨‍💼</h1>

		<!-- STATS CARDS -->
		<div class="stats-grid">
			<div class="stat-card">
				<h3>Total Orders</h3>
				<div class="stat-number">${totalOrders}</div>
			</div>
			<div class="stat-card">
				<h3>Total Customers</h3>
				<div class="stat-number">${totalUsers}</div>
			</div>
			<div class="stat-card">
				<h3>Revenue</h3>
				<div class="stat-number">
  					<fmt:formatNumber value="${totalRevenue}" groupingUsed="true" maxFractionDigits="0" /> VND
				</div>
			</div>
			<div class="stat-card">
				<h3>Products</h3>
				<div class="stat-number">${totalProducts}</div>
			</div>
		</div>

		<!-- RECENT ORDERS TABLE -->
		<h2 style="color: var(--brown-accent); margin-bottom: 10px;">Recent
			Orders</h2>

		<table>
			<tr>
				<th>Order ID</th>
				<th>User</th>
				<th>Total</th>
				<th>Date</th>
				<th>Status</th>
			</tr>

			<!-- If no orders, show placeholder -->
			<c:if test="${empty recentOrders}">
				<tr>
					<td colspan="5" style="text-align: center; padding: 20px;">No
						recent orders found.</td>
				</tr>
			</c:if>

			<!-- Loop orders -->
			<c:forEach var="o" items="${recentOrders}">
				<tr>
					<td>#${o.id}</td>
					<td>${o.customerName}</td>
					<td>
  						<fmt:formatNumber value="${o.totalAmount}" groupingUsed="true" maxFractionDigits="0" /> VND
					</td>
					<td>${o.createdAt}</td>

					<td><span
						class="status 
                        <c:choose>
                            <c:when test='${o.status == "Pending"}'>pending</c:when>
                            <c:when test='${o.status == "Completed"}'>completed</c:when>
                            <c:otherwise>cancelled</c:otherwise>
                        </c:choose>">
							${o.status} </span></td>
				</tr>
			</c:forEach>

		</table>

	</div>

</body>
</html>
