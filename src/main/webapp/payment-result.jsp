<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Result | Matcha Coffee</title>

    <!-- Font -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap" 
          rel="stylesheet">

    <style>
        :root {
            --matcha-light: #E8F3E1;
            --matcha-green: #9BCF8E;
            --matcha-dark: #3A5F41;
            --brown-accent: #6A4E23;
            --white: #ffffff;
            --danger: #c0392b;
        }

        body {
            margin: 0;
            font-family: "Noto Sans JP", sans-serif;
            background: var(--matcha-light);
        }

        /* CENTER BOX */
        .container {
            max-width: 550px;
            margin: 80px auto;
            background: var(--white);
            border-radius: 18px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
        }

        h1 {
            margin-bottom: 10px;
        }

        .success {
            font-size: 70px;
            color: #4CAF50;
            margin-bottom: 10px;
        }

        .fail {
            font-size: 70px;
            color: var(--danger);
            margin-bottom: 10px;
        }

        .order-id {
            margin: 15px 0;
            font-size: 1.1rem;
            color: var(--matcha-dark);
        }

        .msg {
            font-size: 1rem;
            color: #555;
            margin-bottom: 20px;
        }

        .btn-primary {
            padding: 12px 25px;
            background: var(--matcha-green);
            color: white;
            border-radius: 25px;
            display: inline-block;
            text-decoration: none;
            font-weight: bold;
            margin: 10px 5px;
        }

        .btn-primary:hover {
            background: var(--matcha-dark);
        }

        .btn-secondary {
            padding: 10px 22px;
            border: 2px solid var(--matcha-dark);
            color: var(--matcha-dark);
            border-radius: 25px;
            text-decoration: none;
            margin: 10px 5px;
            font-weight: bold;
        }

        .btn-secondary:hover {
            background: var(--matcha-dark);
            color: white;
        }
    </style>
</head>

<body>

<div class="container">

    <!-- SUCCESS STATE -->
    <c:if test="${status == 'success'}">
        <div class="success">✔</div>
        <h1 style="color: var(--brown-accent)">Payment Successful</h1>
        <p class="order-id">Order ID: #${orderId}</p>
        <p class="msg">Thank you! Your order is confirmed and being prepared. 🍃</p>

        <a href="order-details?id=${orderId}" class="btn-primary">View Order</a>
        <a href="menu" class="btn-secondary">Back to Menu</a>
    </c:if>

    <!-- FAILED STATE -->
    <c:if test="${status == 'failed'}">
        <div class="fail">✘</div>
        <h1 style="color: var(--danger)">Payment Failed</h1>
        <p class="order-id">Order ID: #${orderId}</p>
        <p class="msg">Something went wrong. Please try again or use a different payment method.</p>

        <a href="checkout.jsp" class="btn-primary">Try Again</a>
        <a href="menu" class="btn-secondary">Return to Menu</a>
    </c:if>

</div>

</body>
</html>