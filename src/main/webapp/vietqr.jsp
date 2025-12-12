<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>VietQR Payment | Matcha Coffee</title>

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
        color: var(--matcha-dark);
    }

    /* CENTERED PAYMENT CARD */
    .container {
        max-width: 450px;
        margin: 80px auto;
        background: var(--white);
        padding: 35px;
        border-radius: 18px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        text-align: center;
    }

    h1 {
        margin-bottom: 8px;
        color: var(--brown-accent);
        font-size: 1.9rem;
    }

    .subtext {
        font-size: 1rem;
        color: #666;
        margin-bottom: 20px;
    }

    .qr-box img {
        width: 250px;
        border-radius: 18px;
        margin-bottom: 15px;
        border: 3px solid var(--matcha-green);
    }

    .info {
        margin: 10px 0;
        font-size: 1.1rem;
        font-weight: bold;
        color: var(--matcha-dark);
    }

    /* BUTTONS */
    .btn-primary {
        display: block;
        width: 100%;
        padding: 12px;
        background: var(--matcha-green);
        color: white;
        border-radius: 25px;
        text-decoration: none;
        font-weight: bold;
        margin-top: 18px;
    }
    .btn-primary:hover {
        background: var(--matcha-dark);
    }

    .btn-secondary {
        display: block;
        width: 100%;
        padding: 12px;
        border: 2px solid var(--matcha-dark);
        color: var(--matcha-dark);
        border-radius: 25px;
        text-decoration: none;
        font-weight: bold;
        margin-top: 12px;
    }
    .btn-secondary:hover {
        background: var(--matcha-dark);
        color: var(--white);
    }
</style>
</head>

<body>

<div class="container">

    <h1>Scan VietQR to Pay 🍃</h1>
    <p class="subtext">Complete your payment to confirm the order</p>

    <div class="info">Order ID: #${orderId}</div>
    <div class="info">Amount: <span style="color: var(--brown-accent);">${amount} VND</span></div>

    <div class="qr-box">
        <img src="${qrUrl}" alt="VietQR Payment">
    </div>

    <p class="info">Account: ${accountName}</p>

    <a href="payment-result?status=success&orderId=${orderId}" 
       class="btn-primary">I Have Paid</a>

    <a href="payment-result?status=failed&orderId=${orderId}" 
       class="btn-secondary">Cancel</a>

</div>

</body>
</html>