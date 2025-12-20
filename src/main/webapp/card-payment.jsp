<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <title>Card Payment | Matcha Coffee</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/cart-payment.css">
</head>

<body>

    <div class="payment-card">

        <h2>💳 Card Payment</h2>
        <p>Total Amount: <strong>$${sessionScope.totalAmount}</strong></p>

        <form action="card-payment" method="post" autocomplete="off">

            <!-- 🔑 REQUIRED: pass orderId to POST -->
            <input type="hidden" name="orderId" value="${param.orderId}">

            <div class="form-group">
                <label>Cardholder Name</label>
                <input type="text" name="cardName" required>
            </div>

            <div class="form-group">
                <label>Card Number</label>
                <input type="text" name="cardNumber" autocomplete="off" maxlength="16" placeholder="1234 5678 9012 3456"
                    required>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Expiry</label>
                    <input type="text" name="expiry" autocomplete="off" placeholder="MM/YY" required>
                </div>

                <div class="form-group">
                    <label>CVV</label>
                    <input type="password" name="cvv" autocomplete="off" maxlength="3" required>
                </div>
            </div>

            <button type="submit" class="btn-primary">
                Pay Now ☕
            </button>

            <a href="checkout" class="btn-secondary">
                Cancel
            </a>
        </form>

    </div>

</body>

</html>