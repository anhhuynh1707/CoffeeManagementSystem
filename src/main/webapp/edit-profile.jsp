<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Profile | Matcha Coffee</title>

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
            width: 100%;
            padding: 15px 40px;
            background: var(--matcha-dark);
            color: var(--white);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
        }

        .navbar a {
            color: var(--white);
            margin-left: 25px;
            text-decoration: none;
            font-weight: 500;
        }

        .navbar a:hover {
            color: var(--matcha-green);
        }

        /* CONTAINER */
        .wrapper {
            max-width: 800px;
            margin: 40px auto;
            background: var(--white);
            padding: 30px;
            border-radius: 18px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        h1 {
            text-align: center;
            margin-bottom: 25px;
            color: var(--brown-accent);
        }

        /* FORM */
        .form-group {
            margin-bottom: 18px;
        }

        label {
            font-weight: bold;
            font-size: 14px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            margin-top: 5px;
            font-size: 14px;
        }

        .btn-primary {
            background: var(--matcha-green);
            padding: 12px 28px;
            color: white;
            font-weight: bold;
            border-radius: 25px;
            border: none;
            cursor: pointer;
            font-size: 15px;
            margin-top: 20px;
        }

        .btn-primary:hover {
            background: var(--matcha-dark);
        }

        .btn-secondary {
            background: transparent;
            border: 2px solid var(--matcha-dark);
            padding: 10px 24px;
            border-radius: 25px;
            font-size: 15px;
            cursor: pointer;
            margin-left: 10px;
            text-decoration: none;
            color: var(--matcha-dark);
        }

        .btn-secondary:hover {
            background: var(--matcha-dark);
            color: white;
        }

        .btn-row {
            margin-top: 25px;
            text-align: center;
        }

        /* SUCCESS + ERROR */
        .success-msg {
            background: #ddffdd;
            color: #008800;
            padding: 10px;
            border-left: 4px solid #008800;
            margin-bottom: 15px;
            border-radius: 4px;
        }

        .error-msg {
            background: #ffdddd;
            color: #cc0000;
            padding: 10px;
            border-left: 4px solid #cc0000;
            margin-bottom: 15px;
            border-radius: 4px;
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
        <a href="${pageContext.request.contextPath}/cart.jsp">Cart</a>
        <a href="${pageContext.request.contextPath}/profile.jsp">Profile</a>
        <a href="${pageContext.request.contextPath}/order-details.jsp">Orders</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<!-- MAIN CONTENT -->
<div class="wrapper">

    <h1>Edit Profile 🍃</h1>

    <!-- Messages -->
    <c:if test="${not empty success}">
        <div class="success-msg">${success}</div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="error-msg">${error}</div>
    </c:if>

    <form action="update-profile" method="post">

        <div class="form-group">
            <label>Full Name</label>
            <input type="text" name="fullName" class="form-control"
                   value="${user.fullName}" required>
        </div>

        <div class="form-group">
            <label>Email (cannot change)</label>
            <input type="email" class="form-control" value="${user.email}" disabled>
        </div>

        <div class="form-group">
            <label>Phone</label>
            <input type="text" name="phone" class="form-control"
                   value="${user.phone}">
        </div>

        <div class="form-group">
            <label>Address</label>
            <input type="text" name="address" class="form-control"
                   value="${user.address}">
        </div>

        <div class="form-group">
            <label>Update Profile Picture (optional)</label>
            <input type="file" name="avatar" class="form-control">
        </div>

        <!-- BUTTON ROW -->
        <div class="btn-row">
            <button type="submit" class="btn-primary">Save Changes</button>
            <a href="profile.jsp" class="btn-secondary">Cancel</a>
        </div>

    </form>

</div>

</body>
</html>