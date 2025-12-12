<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | Matcha Coffee</title>

    <!-- Fonts -->
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
            background: #f3f7f3;
            display: flex;
        }

        /* SIDEBAR */
        .sidebar {
            width: 240px;
            background: var(--matcha-dark);
            color: var(--white);
            height: 100vh;
            padding: 20px;
            position: fixed;
        }

        .sidebar h2 {
            margin: 0 0 20px 0;
            text-align: center;
        }

        .sidebar a {
            display: block;
            padding: 12px;
            text-decoration: none;
            color: var(--white);
            margin: 8px 0;
            border-radius: 6px;
            font-weight: 500;
        }

        .sidebar a:hover {
            background: var(--matcha-green);
            color: var(--matcha-dark);
        }

        /* MAIN CONTENT WRAPPER */
        .content {
            margin-left: 260px;
            padding: 30px;
            width: calc(100% - 260px);
        }

        .content h1 {
            color: var(--brown-accent);
            margin-bottom: 20px;
        }

        /* STATS CARDS */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: var(--white);
            border-radius: 15px;
            padding: 20px 25px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.08);
        }

        .stat-card h3 {
            margin: 5px 0;
            color: var(--brown-accent);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: bold;
            color: var(--matcha-dark);
        }

        /* TABLE */
        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--white);
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 3px 8px rgba(0,0,0,0.07);
        }

        th {
            background: var(--matcha-dark);
            color: white;
            padding: 12px;
            text-align: left;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background: #f0f7ef;
        }

        .status {
            padding: 6px 12px;
            border-radius: 12px;
            font-size: 0.85rem;
            font-weight: bold;
            color: white;
        }

        .status.pending { background: #d1a229; }
        .status.completed { background: #4CAF50; }
        .status.cancelled { background: #c0392b; }

        /* RESPONSIVE */
        @media (max-width: 768px) {
            .sidebar {
                position: relative;
                width: 100%;
                height: auto;
            }

            .content {
                margin-left: 0;
                width: 100%;
            }
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <h2>☘ Admin Panel</h2>
    <a href="dashboard">Dashboard</a>
    <a href="products">Products</a>
    <a href="orders">Orders</a>
    <a href="users">Users</a>
    <a href="logout">Logout</a>
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
            <div class="stat-number">$${totalRevenue}</div>
        </div>
        <div class="stat-card">
            <h3>Products</h3>
            <div class="stat-number">${totalProducts}</div>
        </div>
    </div>

    <!-- RECENT ORDERS TABLE -->
    <h2 style="color: var(--brown-accent); margin-bottom: 10px;">Recent Orders</h2>

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
                <td colspan="5" style="text-align:center; padding: 20px;">No recent orders found.</td>
            </tr>
        </c:if>

        <!-- Loop orders -->
        <c:forEach var="o" items="${recentOrders}">
            <tr>
                <td>#${o.id}</td>
                <td>${o.customerName}</td>
                <td>$${o.totalAmount}</td>
                <td>${o.createdAt}</td>

                <td>
                    <span class="status 
                        <c:choose>
                            <c:when test='${o.status == "Pending"}'>pending</c:when>
                            <c:when test='${o.status == "Completed"}'>completed</c:when>
                            <c:otherwise>cancelled</c:otherwise>
                        </c:choose>">
                        ${o.status}
                    </span>
                </td>
            </tr>
        </c:forEach>

    </table>

</div>

</body>
</html>
