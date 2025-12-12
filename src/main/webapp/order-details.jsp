<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>Order Details | Matcha Coffee</title>

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap" rel="stylesheet">

<style>
    :root {
        --matcha-light: #E8F3E1;
        --matcha-green: #9BCF8E;
        --matcha-dark: #3A5F41;
        --brown-accent: #6A4E23;
        --white: #ffffff;
    }

    body {
        background: var(--matcha-light);
        font-family: "Noto Sans JP", sans-serif;
        margin: 0;
        padding: 0;
    }

    .card {
        width: 750px;
        margin: 40px auto;
        background: var(--white);
        padding: 35px;
        border-radius: 20px;
        box-shadow: 0 4px 14px rgba(0, 0, 0, 0.12);
    }

    h2 {
        color: var(--matcha-dark);
        margin-bottom: 10px;
        font-size: 1.8rem;
    }

    p {
        font-size: 1rem;
        line-height: 1.6;
    }

    table {
        width: 100%;
        margin-top: 25px;
        border-collapse: collapse;
        font-size: 1rem;
    }

    th, td {
        padding: 14px;
        border-bottom: 1px solid #ddd;
        text-align: center;
    }

    th {
        background: var(--matcha-green);
        color: var(--white);
        font-weight: bold;
    }

    .total-box {
        text-align: right;
        font-size: 1.2rem;
        margin-top: 25px;
        font-weight: bold;
        line-height: 1.6;
    }

    /* MATCHA BUTTONS */
    .btn-primary {
        padding: 12px 25px;
        border: none;
        background: var(--matcha-green);
        color: white;
        border-radius: 999px;
        cursor: pointer;
        font-weight: bold;
        text-decoration: none;
        display: inline-block;
        margin-top: 20px;
        margin-right: 10px;
        transition: 0.25s ease-in-out;
    }

    .btn-primary:hover {
        background: var(--matcha-dark);
    }
</style>
</head>

<body>

<div class="card">

    <h2>Order #${order.id}</h2>

    <p>
        Status: <strong>${order.status}</strong><br>
        Payment: <strong>${order.paymentStatus}</strong><br>
        Method: <strong>${order.paymentMethod}</strong><br>
        Date: <strong>${order.createdAt}</strong>
    </p>

    <table>
        <tr>
            <th>Product</th>
            <th>Qty</th>
            <th>Final Price</th>
        </tr>

        <c:forEach var="item" items="${items}">
            <tr>
                <td>#${item.productId}</td>
                <td>${item.quantity}</td>
                <td>$${item.finalPrice}</td>
            </tr>
        </c:forEach>
    </table>

    <div class="total-box">
        Subtotal: $${order.subtotal}<br>
        Shipping: $${order.shippingFee}<br>
        Total: <span style="color: var(--matcha-dark);">$${order.totalAmount}</span>
    </div>

    <!-- ACTION BUTTONS -->
    <a href="menu" class="btn-primary">← Back to Menu</a>
    <a href="cart" class="btn-primary">← Back to Cart</a>
    <a href="my-orders" class="btn-primary">📦 View My Orders</a>

</div>

</body>
</html>