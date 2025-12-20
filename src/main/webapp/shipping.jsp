<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Order Delivery Tracking | Matcha Coffee</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shipping.css">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap" rel="stylesheet">
</head>
<body>
  <div class="track-wrap">
    <div class="track-card">
      <!-- TITLE -->
      <h2 class="track-title">Order Delivery Tracking</h2>
      <!-- META INFO -->
      <div class="meta-row">
        <span class="meta-pill">
          Order Status:
          <b>${order.status}</b>
        </span>
        <span class="meta-pill">
          Payment:
          <b>${order.paymentStatus}</b>
        </span>
        <span class="meta-pill">
          Method:
          <b>${order.paymentMethod}</b>
        </span>
      </div>

      <!-- DELIVERY STATUS -->
      <div class="section">
        <span class="badge 
        <c:choose>
          <c:when test=" ${shipping.status=='delivered' }">badge-delivered</c:when>
          <c:when test="${shipping.status == 'shipping'}">badge-delivering</c:when>
          <c:otherwise>
            badge-pending
          </c:otherwise>
          </c:choose>
          ">
          <c:choose>
            <c:when test="${shipping.status == 'delivered'}">
              Delivered ✅
            </c:when>
            <c:when test="${shipping.status == 'shipping'}">
              Shipper is on the way 🚴
            </c:when>
            <c:otherwise>
              Preparing your order ☕
            </c:otherwise>
          </c:choose>
        </span>
      </div>

      <!-- RECEIVER INFO -->
      <div class="section">
        <h3>Receiver Information</h3>
        <div class="info-grid">
          <div class="label">Name</div>
          <div class="value">${shipping.receiverName}</div>
          <div class="label">Phone</div>
          <div class="value">${shipping.phone}</div>
          <div class="label">Address</div>
          <div class="value">
            ${shipping.address}, ${shipping.city}
          </div>
        </div>
      </div>

      <!-- PAYMENT -->
      <div class="section">
        <h3>Payment</h3>
        <div class="info-grid">
          <div class="label">Method</div>
          <div class="value">${order.paymentMethod}</div>
          <div class="label">Status</div>
          <div class="value">
            <c:choose>
              <c:when test="${order.paymentStatus == 'paid'}">
                Paid ✅
              </c:when>
              <c:otherwise>
                Pay on delivery
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>

      <!-- ITEMS -->
      <div class="section">
        <h3>Items</h3>

        <div class="items">
          <c:forEach var="item" items="${orderItems}">
            <div class="item">
              <div class="item-left">
                <div class="item-name">
                  ${item.productName} × ${item.quantity}
                </div>
              </div>
              <div class="item-price">
                <fmt:formatNumber value="${item.finalPrice}" groupingUsed="true" maxFractionDigits="0" /> VND
              </div>
            </div>
          </c:forEach>
        </div>
      </div>
      <!-- SUMMARY -->
      <div class="section">
        <h3>Summary</h3>
        <div class="summary">
          <div class="summary-row">
            <span>Subtotal</span>
            <span>
              <fmt:formatNumber value="${order.subtotal}" groupingUsed="true" maxFractionDigits="0" /> VND
            </span>
          </div>
          <div class="summary-row">
            <span>Shipping</span>
            <span>
              <fmt:formatNumber value="${shipping.shippingFee}" groupingUsed="true" maxFractionDigits="0" /> VND
            </span>
          </div>
          <div class="summary-row summary-total">
            <span>Total</span>
            <span>
              <fmt:formatNumber value="${order.totalAmount}" groupingUsed="true" maxFractionDigits="0" /> VND
            </span>
          </div>
        </div>
      </div>

      <!-- ACTIONS -->
      <div class="actions">
        <a href="${pageContext.request.contextPath}/my-orders" class="btn btn-ghost">← My Orders </a>
        <a href="${pageContext.request.contextPath}/menu" class="btn btn-primary">Order Again ☕</a>
      </div>
    </div>
  </div>
</body>
</html>