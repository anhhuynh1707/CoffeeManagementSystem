<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Orders | Admin Panel - Matcha Coffee</title>

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
      --info: #3a86ff;
    }

    body {
      margin: 0;
      font-family: "Noto Sans JP", sans-serif;
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
      box-sizing: border-box;
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
      color: var(--white);
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
      color: var(--white);
    }

    /* PAYMENT STATUS */
    .badge.confirmed { background: #4CAF50; }
    .badge.pending   { background: var(--warning); color: #1f1f1f; }
    .badge.failed    { background: var(--danger); }

    /* ORDER STATUS */
    .badge.status-pending    { background: var(--warning); color: #1f1f1f; }
    .badge.status-processing { background: var(--info); }
    .badge.status-completed  { background: #4CAF50; }
    .badge.status-cancelled  { background: var(--danger); }

    .truncate {
      max-width: 260px;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    /* ACTION BUTTONS */
    .btn {
      padding: 6px 10px;
      border: none;
      border-radius: 6px;
      color: var(--white);
      font-weight: 600;
      cursor: pointer;
    }

    .btn-view      { background: var(--info); margin-right: 6px; }
    .btn-complete  { background: #4CAF50; }
    .btn-cancel    { background: var(--danger); margin-left: 6px; }

    /* MODAL */
    #orderModal {
      display: none;
      position: fixed;
      inset: 0;
      background: rgba(0, 0, 0, 0.4);
      align-items: center;
      justify-content: center;
      padding: 18px;
      box-sizing: border-box;
    }

    #orderModal .modal-box {
      background: var(--white);
      padding: 20px;
      width: 600px;
      border-radius: 12px;
      max-height: 80vh;
      overflow: auto;
      box-sizing: border-box;
      position: relative;
    }

    #orderModal .modal-close {
      position: absolute;
      top: 12px;
      right: 12px;
      border: none;
      background: none;
      font-size: 18px;
      cursor: pointer;
    }

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
      td, th {
        font-size: 13px;
      }
      #orderModal .modal-box {
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

    <a href="${pageContext.request.contextPath}/" class="back-home">
      ← Back to Homepage
    </a>
  </div>

  <!-- MAIN CONTENT -->
  <div class="content">
    <h1>Orders Management 🧾</h1>

    <!-- ORDERS TABLE -->
    <div class="card" style="overflow:hidden;">
      <div style="padding:18px 22px;">
        <h2 style="margin:0 0 6px 0; color: var(--brown-accent);">Recent Orders</h2>
        <div class="muted">Showing the most recent customer orders.</div>
      </div>

      <table>
        <thead>
          <tr>
            <th style="width:95px;">Order ID</th>
            <th style="width:85px;">User ID</th>

            <th style="width:140px;">Subtotal</th>
            <th style="width:140px;">Shipping</th>
            <th style="width:150px;">Total Amount</th>
            <th style="width:110px;">Total Cups</th>

            <th style="width:140px;">Order Status</th>
            <th style="width:170px;">Payment Method</th>
            <th style="width:170px;">Payment Status</th>

            <th style="width:150px;">Action</th>
          </tr>
        </thead>

        <tbody>
          <!-- Empty state -->
          <c:if test="${empty orders}">
            <tr>
              <td colspan="10" style="text-align:center; padding:22px;">
                No orders found.
              </td>
            </tr>
          </c:if>

          <!-- Orders loop -->
          <c:forEach var="o" items="${orders}">
            <tr>
              <!-- orders.order_id -->
              <td>#${o.id}</td>

              <!-- orders.user_id -->
              <td>${o.userId}</td>

              <!-- orders.subtotal -->
              <td>
                <fmt:formatNumber
                  value="${o.subtotal}"
                  groupingUsed="true"
                  maxFractionDigits="0"
                />
                VND
              </td>

              <!-- orders.shipping_fee -->
              <td>
                <fmt:formatNumber
                  value="${o.shippingFee}"
                  groupingUsed="true"
                  maxFractionDigits="0"
                />
                VND
              </td>

              <!-- orders.total_amount -->
              <td>
                <fmt:formatNumber
                  value="${o.totalAmount}"
                  groupingUsed="true"
                  maxFractionDigits="0"
                />
                VND
              </td>

              <!-- orders.total_cups -->
              <td>${o.totalCups}</td>

              <!-- orders.status -->
				<td>
				  <form action="${pageContext.request.contextPath}/orders" method="post" style="display:inline;">
				    <input type="hidden" name="action" value="updateOrderStatus" />
				    <input type="hidden" name="orderId" value="${o.id}" />
				
				    <select name="status"
				            onchange="return confirmStatusChange(this) && this.form.submit();"
				            style="padding:6px 10px;border-radius:8px;border:1px solid #ddd; margin-left:10px;">
				      <option value="pending"   ${o.status=='pending'?'selected':''}>pending</option>
				      <option value="confirmed" ${o.status=='confirmed'?'selected':''}>confirmed</option>
				      <option value="preparing" ${o.status=='preparing'?'selected':''}>preparing</option>
				      <option value="shipping"  ${o.status=='shipping'?'selected':''}>shipping</option>
				      <option value="completed" ${o.status=='completed'?'selected':''}>completed</option>
				      <option value="cancelled" ${o.status=='cancelled'?'selected':''}>cancelled</option>
				    </select>
				  </form>
				</td>
              <!-- orders.payment_method -->
              <td>${o.paymentMethod}</td>

              <!-- orders.payment_status -->
				<td>
				  <form action="${pageContext.request.contextPath}/orders" method="post" style="display:inline;">
				    <input type="hidden" name="action" value="updatePaymentStatus" />
				    <input type="hidden" name="orderId" value="${o.id}" />
				
				    <select name="paymentStatus" onchange="this.form.submit()"
				            style="padding:6px 10px;border-radius:8px;border:1px solid #ddd;">
				      <option value="unpaid"  ${o.paymentStatus=='unpaid'?'selected':''}>unpaid</option>
				      <option value="pending" ${o.paymentStatus=='pending'?'selected':''}>pending</option>
				      <option value="paid"    ${o.paymentStatus=='paid'?'selected':''}>paid</option>
				      <option value="failed"  ${o.paymentStatus=='failed'?'selected':''}>failed</option>
					  <option value="refunded" ${o.paymentStatus=='refunded'?'selected':''}>refunded</option>
				    </select>
				  </form>
				</td>

              <td>
                <!-- VIEW (always available) -->
                <button
                  type="button"
                  class="btn btn-view"
                  onclick="openOrder(${o.id})"
                >
                  View
                </button>

                <!-- COMPLETED LABEL -->
                <c:if test="${o.status == 'completed'}">
                  <span class="muted">✓ Completed</span>
                </c:if>

                <!-- CANCELLED LABEL -->
                <c:if test="${o.status == 'cancelled'}">
                  <span class="muted">✕ Cancelled</span>
                </c:if>

                <!-- ACTIONS (only if NOT completed/cancelled) -->
                <c:if test="${o.status != 'completed' && o.status != 'cancelled'}">
                  <!-- COMPLETE -->
                  <form
                    action="${pageContext.request.contextPath}/orders"
                    method="post"
                    style="display:inline;"
                    onsubmit="return confirm('Mark this order as completed?');"
                  >
                    <input type="hidden" name="action" value="complete" />
                    <input type="hidden" name="orderId" value="${o.id}" />
                    <button type="submit" class="btn btn-complete">
                      Completed
                    </button>
                  </form>

                  <!-- CANCEL (only if not paid) -->
                  <c:if test="${o.paymentStatus != 'paid'}">
                    <form
                      action="${pageContext.request.contextPath}/orders"
                      method="post"
                      style="display:inline;"
                      onsubmit="return confirm('Cancel this order? This action cannot be undone.');"
                    >
                      <input type="hidden" name="action" value="cancel" />
                      <input type="hidden" name="orderId" value="${o.id}" />
                      <button type="submit" class="btn btn-cancel">
                        Cancel
                      </button>
                    </form>
                  </c:if>
                </c:if>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </div>
  </div>

  <!-- MODAL -->
  <div id="orderModal">
    <div class="modal-box">
      <button class="modal-close" onclick="closeModal()">✕</button>
      <div id="modalContent">Loading...</div>
    </div>
  </div>

  <script>
    function openOrder(orderId) {
      const modal = document.getElementById("orderModal");
      const content = document.getElementById("modalContent");

      modal.style.display = "flex";
      content.innerHTML = "Loading...";

      fetch(
        "${pageContext.request.contextPath}/admin/order-details?orderId=" + orderId
      )
        .then((res) => res.text())
        .then((html) => (content.innerHTML = html));
    }

    function closeModal() {
      document.getElementById("orderModal").style.display = "none";
    }
  </script>
</body>
</html>

