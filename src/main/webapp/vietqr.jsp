<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>VietQR Payment | Matcha Coffee</title>

<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
      rel="stylesheet">
<link rel="stylesheet" href="css/vietqr.css">
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
	<div class = "btn-container">
	    <a href="payment-result?status=success&orderId=${orderId}" 
	       class="btn-primary">I Have Paid</a>
	
	    <a href="payment-result?status=failed&orderId=${orderId}" 
	       class="btn-secondary">Cancel</a>
	</div>
</div>

</body>
</html>