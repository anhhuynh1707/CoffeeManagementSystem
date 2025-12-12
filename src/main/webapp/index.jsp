<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Matcha Coffee | Home</title>

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="css/index.css">
</head>

<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="logo">
        <h2>Matcha Coffee ☕</h2>
    </div>
    <div class="menu">
        <a href="${pageContext.request.contextPath}/index.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/menu">Menu</a>
        <a href="${pageContext.request.contextPath}/cart">Cart</a>
        <a href="${pageContext.request.contextPath}/profile">Profile</a>
        <a href="${pageContext.request.contextPath}/my-orders">Orders</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<!-- HERO SECTION -->
<div class="wrapper">
<div class="hero">
    <h1>Fresh Matcha • Fresh Coffee</h1>
    <p>Experience the calming taste of matcha and the aroma of fresh brew — all in one place.</p>
    <a href="${pageContext.request.contextPath}/menu" class="btn-primary">Explore Menu</a>
</div>

<!-- FEATURE GRID -->
<div class="features">

    <div class="feature-card">
        <h3>🍵 Matcha & Coffee Menu</h3>
        <p>Browse all drinks and items available in our café.</p>
        <a href="menu" class="btn-primary">View Menu</a>
    </div>

    <div class="feature-card">
        <h3>🛒 Cart System</h3>
        <p>Add drinks, customize orders, and checkout easily.</p>
        <a href="cart" class="btn-primary">Go to Cart</a>
    </div>

    <div class="feature-card">
        <h3>👤 Your Profile</h3>
        <p>Edit your info, address, and preferences.</p>
        <a href="profile" class="btn-primary">Profile</a>
    </div>

    <div class="feature-card">
        <h3>📦 Order History</h3>
        <p>Track all your previous and ongoing orders.</p>
        <a href="my-orders" class="btn-primary">View Orders</a>
    </div>

</div>
</div>

<!-- FOOTER -->
<div class="footer">
    Matcha Coffee © 2025 — Brewed with love 🍃
</div>

</body>
</html>
