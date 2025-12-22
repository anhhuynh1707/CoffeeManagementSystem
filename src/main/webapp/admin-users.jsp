<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Users | Admin Panel - Matcha Coffee</title>

  <!-- Fonts -->
  <link
    href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap"
    rel="stylesheet"
  />

  <style>
    :root {
      --matcha-light: #E8F3E1;
      --matcha-green: #9BCF8E;
      --matcha-dark: #3A5F41;
      --brown-accent: #6A4E23;
      --white: #ffffff;
      --danger: #c0392b;
      --warning: #d1a229;
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

    .back-home {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 8px;
      padding: 10px 12px;
      border-radius: 8px;
      text-decoration: none;
      font-weight: 500;
      background: rgba(255, 255, 255, 0.12);
      color: var(--white);
      margin-top: 16px;
    }

    .back-home:hover {
      background: var(--matcha-green);
      color: var(--matcha-dark);
    }

    /* MAIN CONTENT */
    .content {
      margin-left: 260px;
      padding: 30px;
      width: calc(100% - 260px);
      box-sizing: border-box;
    }

    .content h1 {
      color: var(--brown-accent);
      margin-bottom: 18px;
    }

    .card {
      background: var(--white);
      border-radius: 15px;
      padding: 18px 22px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.08);
      margin-bottom: 18px;
    }

    /* TABLE */
    table {
      width: 100%;
      border-collapse: collapse;
      background: var(--white);
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 3px 8px rgba(0, 0, 0, 0.07);
    }

    th {
      background: var(--matcha-dark);
      color: white;
      padding: 12px;
      text-align: left;
      white-space: nowrap;
      font-size: 14px;
    }

    td {
      padding: 12px;
      border-bottom: 1px solid #eee;
      vertical-align: middle;
      font-size: 14px;
      white-space: nowrap;
    }

    tr:hover {
      background: #f0f7ef;
    }

    .muted {
      color: #6b7280;
      font-size: 0.92rem;
    }

    .badge {
      display: inline-block;
      padding: 6px 10px;
      border-radius: 999px;
      font-size: 0.82rem;
      font-weight: 800;
      color: white;
    }

    /* ROLE */
    .badge.admin { background: #3a86ff; }
    .badge.customer { background: #4CAF50; }

    /* STATUS */
    .badge.active { background: #4CAF50; }
    .badge.inactive { background: #c0392b; }
    .badge.blocked { background: #c0392b; }

    .truncate {
      max-width: 260px;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    @media (max-width: 768px) {
      .sidebar { position: relative; width: 100%; height: auto; }
      .content { margin-left: 0; width: 100%; }
      td, th { font-size: 13px; }
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

    <a href="${pageContext.request.contextPath}/" class="back-home">
      ← Back to Homepage
    </a>
  </div>

  <!-- MAIN CONTENT -->
  <div class="content">
    <h1>Users Management 👥</h1>

    <!-- USERS TABLE -->
    <div class="card" style="overflow:hidden;">
      <div style="padding:18px 22px;">
        <h2 style="margin:0 0 6px 0; color: var(--brown-accent);">User List</h2>
        <div class="muted">Showing registered accounts (admin & customer).</div>
      </div>

      <table>
        <thead>
          <tr>
            <th style="width:80px;">User ID</th>
            <th style="width:190px;">Full Name</th>
            <th style="width:220px;">Email</th>
            <th style="width:140px;">Phone</th>
            <th style="width:280px;">Address</th>
            <th style="width:110px;">Role</th>
            <th style="width:120px;">Status</th>
          </tr>
        </thead>

        <tbody>
          <!-- Empty state -->
          <c:if test="${empty users}">
            <tr>
              <td colspan="9" style="text-align:center;padding:22px;">
                No users found.
              </td>
            </tr>
          </c:if>

          <!-- Users loop -->
          <c:forEach var="u" items="${users}">
            <tr>
              <!-- users.id -->
              <td>#${u.id}</td>

              <!-- users.full_name -->
              <td class="truncate" title="${u.fullName}">
                <c:out value="${u.fullName}" />
              </td>

              <!-- users.email -->
              <td class="truncate" title="${u.email}">
                <c:out value="${u.email}" />
              </td>

              <!-- users.phone -->
              <td>
                <c:out value="${empty u.phone ? '-' : u.phone}" />
              </td>

              <!-- users.address -->
              <td class="truncate" title="${u.address}">
                <c:out value="${empty u.address ? '-' : u.address}" />
              </td>

              <!-- users.role -->
              <td>
                <span class="badge ${u.role}">
                  <c:out value="${u.role}" />
                </span>
              </td>

              <!-- users.status -->
              <td>
                <span class="badge ${u.status == 'active' ? 'active' : (u.status == 'inactive' ? 'inactive' : 'blocked')}">
                  <c:out value="${empty u.status ? 'active' : u.status}" />
                </span>
              </td>

            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</body>
</html>
