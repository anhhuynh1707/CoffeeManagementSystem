<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h3 style="margin-top:0;">Order Items</h3>

<table style="width:100%; border-collapse:collapse;">
  <thead>
    <tr style="background:#f3f7f3;">
      <th style="padding:8px;text-align:left;">Product</th>
      <th style="padding:8px;">Quantity</th>
      <th style="padding:8px;">Options</th>
      <th style="padding:8px;">Price</th>
    </tr>
  </thead>

  <tbody>
    <c:forEach var="i" items="${items}">
      <tr>
        <td style="padding:8px;">${i.productName}</td>
        <td style="padding:8px;text-align:center;">${i.quantity}</td>
        <td style="padding:8px;">
          <c:if test="${not empty i.milkType}">
            Milk: ${i.milkType}<br/>
            Sugar: ${i.sugarLevel}<br/>
            Ice: ${i.iceLevel}
          </c:if>
          <c:if test="${empty i.milkType}">
            -
          </c:if>
        </td>
        <td style="padding:8px;">
          <fmt:formatNumber value="${i.finalPrice}" groupingUsed="true" maxFractionDigits="0"/> VND
        </td>
      </tr>
    </c:forEach>
  </tbody>
</table>
