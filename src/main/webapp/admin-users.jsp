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
  <link rel="stylesheet" href="css/admin-users.css">
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
