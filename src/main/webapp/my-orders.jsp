<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders | Matcha Coffee</title>

    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
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
        .wrapper {
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: var(--brown-accent);
            margin-bottom: 30px;
        }

        .order-card {
            background: var(--white);
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 18px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.08);
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            color: var(--matcha-dark);
            font-weight: bold;
        }

        .order-details {
            color: #444;
            margin-bottom: 12px;
        }

        .status {
            padding: 7px 16px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: bold;
            margin-bottom: 20px;
            display: inline-block;
        }

        .status-confirmed { background: #d4f5d4; color: #256029; }
        .status-pending { background: #fff4c4; color: #8a6d1d; }
        .status-cancelled { background: #ffd4d4; color: #a40000; }

        .btn-view {
            padding: 10px 18px;
            background: var(--matcha-green);
            color: white;
            border-radius: 25px;
            text-decoration: none;
            font-weight: bold;
        }

        .btn-view:hover {
            background: var(--matcha-dark);
        }

        .center-buttons {
            text-align: center;
            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 20px;
        }
    </style>
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <h2>Matcha Coffee ☕</h2>

    <div>
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/menu">Menu</a>
        <a href="${pageContext.request.contextPath}/cart">Cart</a>
        <a href="${pageContext.request.contextPath}/profile">Profile</a>
        <a href="${pageContext.request.contextPath}/my-orders">Orders</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<div class="wrapper">
    <h1>Your Orders 🍃</h1>

    <c:if test="${empty orders}">
        <p style="text-align:center; color: var(--matcha-dark); font-weight: bold;">
            You have no orders yet.
        </p>
    </c:if>

    <c:forEach var="o" items="${orders}">
        <div class="order-card">

            <div class="order-header">
                <span>Order #${o.id}</span>
                <span>${o.createdAt}</span>
            </div>

            <div class="order-details">
                <p>Total Cups: <b>${o.totalCups}</b></p>
                <p>Total Amount: <b>$${o.totalAmount}</b></p>
                <p>Payment Method: <b>${o.paymentMethod}</b></p>

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

    <div class="center-buttons">
        <a href="menu" class="btn-view">← Back to Menu</a>
        <a href="cart" class="btn-view">← Back to Cart</a>
    </div>
</div>

</body>
</html>