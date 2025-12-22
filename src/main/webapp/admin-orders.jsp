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
  <link rel="stylesheet" href="css/admin-orders.css">
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

