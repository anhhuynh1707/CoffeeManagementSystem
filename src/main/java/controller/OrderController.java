package controller;

import dao.CartDAO;
import dao.OrderDAO;
import dao.ShippingDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;
import model.Order;
import model.Shipping;
import model.User;
import service.ShippingService;
import util.AddressUtil;

import java.io.IOException;
import java.util.List;

@WebServlet("/checkout")
public class OrderController extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");
        List<CartItem> cart = cartDAO.getCartByUser(userId);

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        double subtotal = 0;
        int cups = 0;
        for (CartItem item : cart) {
            subtotal += item.getFinalPrice() * item.getQuantity();
            cups += item.getQuantity();
        }

        ShippingService shippingService = new ShippingService();

        User currentUser = (User) session.getAttribute("currentUser");
        String fullAddress = (currentUser != null) ? currentUser.getAddress() : null;

        String district = AddressUtil.extractDistrict(fullAddress);
        String city = "Ho Chi Minh City";

        double shipping = shippingService.calculateShipping(city, district).doubleValue();
        double total = subtotal + shipping;

        request.setAttribute("cart", cart);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shipping", shipping);
        request.setAttribute("total", total);
        request.setAttribute("cups", cups);

        try {
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        String paymentMethod = request.getParameter("paymentMethod");
        if (paymentMethod == null || paymentMethod.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/checkout?error=No payment method selected");
            return;
        }

        List<CartItem> cart = cartDAO.getCartByUser(userId);
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?error=Your cart is empty");
            return;
        }

        double subtotal = 0;
        int cups = 0;
        for (CartItem item : cart) {
            subtotal += item.getFinalPrice() * item.getQuantity();
            cups += item.getQuantity();
        }

        ShippingService shippingService = new ShippingService();

        User currentUser = (User) session.getAttribute("currentUser");
        String fullAddress = (currentUser != null) ? currentUser.getAddress() : null;

        String district = AddressUtil.extractDistrict(fullAddress);
        String city = "Ho Chi Minh City";

        double shipping = shippingService.calculateShipping(city, district).doubleValue();
        double total = subtotal + shipping;

        Order order = new Order();
        order.setUserId(userId);
        order.setSubtotal(subtotal);
        order.setShippingFee(shipping);
        order.setTotalAmount(total);
        order.setTotalCups(cups);
        order.setPaymentMethod(paymentMethod);

        // ✅ Correct status logic (admin confirms later)
        if ("COD".equals(paymentMethod)) {
            order.setStatus("pending");
            order.setPaymentStatus("unpaid");
        } else {
            order.setStatus("pending");
            order.setPaymentStatus("pending");
        }

        int orderId = orderDAO.saveOrder(order);
        orderDAO.moveCartToOrderItems(orderId, cart);

        // Shipping snapshot only if we have currentUser info
        if (currentUser != null) {
            Shipping shippingObj = new Shipping();
            shippingObj.setOrderId(orderId);
            shippingObj.setReceiverName(currentUser.getFullName());
            shippingObj.setPhone(currentUser.getPhone());
            shippingObj.setAddress(currentUser.getAddress());
            shippingObj.setCity(city);
            shippingObj.setDistrict(district);
            shippingObj.setWard("");
            shippingObj.setShippingFee(shipping);
            shippingObj.setMethod("standard");
            shippingObj.setStatus("pending");

            ShippingDAO shippingDAO = new ShippingDAO();
            shippingDAO.createShipping(shippingObj);
        }

        switch (paymentMethod) {
            case "COD" -> {
                cartDAO.clearCart(userId);
                session.setAttribute("cartCount", 0);
                response.sendRedirect(request.getContextPath() + "/payment-result?status=success&orderId=" + orderId);
            }
            case "VIETQR" -> response.sendRedirect(request.getContextPath() + "/vietqr?orderId=" + orderId);
            case "CARD" -> response.sendRedirect(request.getContextPath() + "/card-payment.jsp?orderId=" + orderId);
            default -> response.sendRedirect(request.getContextPath() + "/checkout?error=Invalid payment method");
        }
    }
}
