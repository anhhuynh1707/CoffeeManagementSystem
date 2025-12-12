<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Cart | Matcha Coffee</title>

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --matcha-light: #E8F3E1;
            --matcha-green: #9BCF8E;
            --matcha-dark: #3A5F41;
            --brown-accent: #6A4E23;
            --white: #ffffff;
            --danger: #d84a4a;
        }

        body {
            margin: 0;
            font-family: "Noto Sans JP", sans-serif;
            background: var(--matcha-light);
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

        /* WRAPPER */
        .wrapper {
            max-width: 1100px;
            margin: 30px auto;
            padding: 0 20px;
        }

        h1 {
            text-align: center;
            color: var(--brown-accent);
        }

        /* CART ITEM */
        .cart-item {
            background: var(--white);
            border-radius: 15px;
            padding: 18px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .cart-img {
            width: 120px;
            height: 120px;
            border-radius: 12px;
            object-fit: cover;
        }

        .item-info {
            flex: 1;
        }

        .item-info h3 {
            margin: 0 0 8px 0;
            color: var(--brown-accent);
        }

        .item-price {
            font-size: 1.1rem;
            font-weight: bold;
        }

        .item-actions {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }

        .quantity-box {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .qty-btn {
            width: 28px;
            height: 28px;
            border: none;
            background: var(--matcha-green);
            color: white;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            text-align: center;
            line-height: 28px;
        }

        .qty-btn:hover {
            background: var(--matcha-dark);
        }

        .qty-display {
            padding: 5px 12px;
            background: #eee;
            border-radius: 6px;
            font-weight: bold;
        }

        .remove-btn {
            background: var(--danger);
            color: white;
            padding: 8px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 0.9rem;
        }

        .remove-btn:hover {
            background: #b73838;
        }

        /* SUMMARY */
        .summary {
            background: var(--white);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.07);
            margin-top: 20px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            font-size: 1.1rem;
        }

        .summary-total {
            font-weight: bold;
            color: var(--brown-accent);
        }

        .btn-primary {
            padding: 12px 25px;
            border: none;
            background: var(--matcha-green);
            color: white;
            border-radius: 25px;
            cursor: pointer;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }

        .btn-primary:hover {
            background: var(--matcha-dark);
        }

        .btn-secondary {
            padding: 10px 20px;
            border: 2px solid var(--matcha-dark);
            background: transparent;
            color: var(--matcha-dark);
            border-radius: 25px;
            text-decoration: none;
        }

        .btn-secondary:hover {
            background: var(--matcha-dark);
            color: white;
        }

        /* EMPTY */
        .empty {
            text-align: center;
            padding: 60px 10px;
        }

        .empty p {
            font-size: 1.2rem;
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

<!-- MAIN -->
<div class="wrapper">

    <h1>Your Cart 🛒</h1>

    <!-- SUCCESS NOTIFICATION -->
    <c:if test="${not empty successMsg}">
        <div style="margin:15px 0;padding:12px 18px;border-radius:8px;background:#e3f8e5;color:#256029;border:1px solid #a4d5aa;font-weight:500;">
            ${successMsg}
        </div>
    </c:if>

    <!-- EMPTY CART -->
    <c:if test="${empty cartItems}">
        <div class="empty">
            <p>Your cart is empty 🍃</p>
            <a href="${pageContext.request.contextPath}/menu" class="btn-primary">Browse Menu</a>
        </div>
    </c:if>

    <!-- CART ITEMS -->
    <c:forEach var="item" items="${cartItems}">
	    <div class="cart-item">
	
	        <!-- IMAGE -->
	        <img src="${pageContext.request.contextPath}/img/menu/${item.imageUrl}"
	             class="cart-img" alt="${item.productName}">
	
	        <!-- INFO -->
	        <div class="item-info">
	            <h3>${item.productName}</h3>
	            <div class="item-price">$${item.finalPrice}</div>
	        </div>
	
	        <!-- ACTIONS -->
	        <div class="item-actions">
	
	            <div class="quantity-box">
	                <a href="cart?op=dec&cid=${item.cartId}" class="qty-btn">−</a>
	                <span class="qty-display">${item.quantity}</span>
	                <a href="cart?op=inc&cid=${item.cartId}" class="qty-btn">+</a>
	            </div>
	
	            <a href="cart?op=remove&cid=${item.cartId}" class="remove-btn">
	                Remove
	            </a>
	        </div>
	
	    </div>
	</c:forEach>

    <!-- SUMMARY -->
    <c:if test="${not empty cartItems}">
        <div class="summary">
            <h2>Order Summary</h2>

            <div class="summary-row">
                <span>Subtotal</span>
                <span>$${subtotal}</span>
            </div>
            <div class="summary-row">
	            <span>Shipping Fee</span>
	            <span>$${shipping}</span>
	        </div>

            <div class="summary-row summary-total">
                <span>Total</span>
                <span>$${total}</span>
            </div>

            <a href="${pageContext.request.contextPath}/checkout" class="btn-primary">
                Proceed to Checkout
            </a>

            <a href="${pageContext.request.contextPath}/menu" class="btn-secondary">
                Continue Shopping
            </a>
        </div>
    </c:if>

</div>

</body>
</html>