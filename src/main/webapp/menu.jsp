<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Menu | Matcha Coffee</title>

    <!-- Font -->
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
            margin: 0;
            font-family: 'Noto Sans JP', sans-serif;
            background: var(--matcha-light);
            color: var(--matcha-dark);
        }

        /* NAVBAR SAME AS HOMEPAGE */
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

        /* TITLE */
        .menu-title {
            text-align: center;
            padding: 40px 10px 10px;
        }

        .menu-title h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            color: var(--brown-accent);
        }

        .menu-title p {
            font-size: 1.1rem;
        }

        /* CATEGORY FILTER */
        .filter-bar {
            text-align: center;
            margin-top: 10px;
            margin-bottom: 25px;
        }

        .filter-bar select {
		    padding: 8px 14px;
		    border: 1.8px solid var(--matcha-dark);
		    border-radius: 8px;
		    background: var(--white);
		    font-size: 1rem;
		    cursor: pointer;
		    transition: 0.2s;
		}
		
		.filter-bar select:hover {
		    background: var(--matcha-light);
		}
        /* MENU GRID */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 25px;
            padding: 40px;
        }

        /* ITEM CARD */
        .item-card {
            background: var(--white);
            border-radius: 15px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.08);
            text-align: center;
        }

        .item-card img {
            width: 100%;
            height: 180px;
            border-radius: 12px;
            object-fit: cover;
            margin-bottom: 15px;
        }

        .item-card h3 {
            margin: 10px 0;
            color: var(--brown-accent);
        }

        .price {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 12px;
            color: var(--matcha-dark);
        }

        .btn-add {
            padding: 10px 25px;
            background: var(--matcha-green);
            border-radius: 25px;
            color: white;
            text-decoration: none;
            font-weight: bold;
            display: inline-block;
            transition: 0.2s;
        }

        .btn-add:hover {
            background: var(--matcha-dark);
        }

        /* FOOTER */
        .footer {
            background: var(--matcha-dark);
            color: var(--white);
            text-align: center;
            padding: 15px;
            margin-top: 40px;
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

<!-- TITLE -->
<div class="menu-title">
    <h1>Our Menu 🍵</h1>
    <p>Explore our matcha creations, coffee brews, and signature drinks.</p>
</div>

<!-- CATEGORY FILTER -->
<div class="filter-bar">
    <form action="${pageContext.request.contextPath}/menu" method="get">
        <select name="category" onchange="this.form.submit()">
            <option value="all" ${param.category == 'all' ? 'selected' : ''}>All</option>
            <option value="coffee" ${param.category == 'coffee' ? 'selected' : ''}>Coffee</option>
            <option value="matcha" ${param.category == 'matcha' ? 'selected' : ''}>Matcha</option>
            <option value="tea" ${param.category == 'tea' ? 'selected' : ''}>Tea</option>
            <option value="bakery" ${param.category == 'bakery' ? 'selected' : ''}>Bakery</option>
        </select>
    </form>
</div>

<!-- MENU LIST -->
<div class="menu-grid">

    <c:forEach var="item" items="${menuList}">
	    <div class="item-card">
	        <img src="${pageContext.request.contextPath}/img/menu/${item.imageUrl}">
	        <h3>${item.name}</h3>
	        <div class="price">$${item.price}</div>
	
	        <!-- ADD TO CART (DB version) -->
	        <a class="btn-add"
	           href="${pageContext.request.contextPath}/cart?op=add&pid=${item.id}">
	            Add to Cart
	        </a>
	    </div>
	</c:forEach>
</div>

<!-- FOOTER -->
<div class="footer">
    Matcha Coffee © 2025 — Brewed with love 🍃
</div>

</body>
</html>