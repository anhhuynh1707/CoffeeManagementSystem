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

    private CartDAO cartDAO = new CartDAO();
    private OrderDAO orderDAO = new OrderDAO();

    // STEP 1: Show checkout page
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        List<CartItem> cart = cartDAO.getCartByUser(userId);

        if (cart.isEmpty()) {
            response.sendRedirect("cart");
            return;
        }

        double subtotal = 0;
        int cups = 0;

        for (CartItem item : cart) {
            subtotal += item.getFinalPrice() * item.getQuantity();
            cups += item.getQuantity();
        }

        ShippingService shippingService = new ShippingService();

	    // get address from currentUser (NOT session string)
	    User currentUser = (User) session.getAttribute("currentUser");
	    String fullAddress = currentUser != null ? currentUser.getAddress() : null;
	
	    String district = AddressUtil.extractDistrict(fullAddress);
	    String city = "Ho Chi Minh City";
	
	    double shipping = shippingService
	            .calculateShipping(city, district)
	            .doubleValue();
	
	    double total = subtotal + shipping;

        // Pass data to page
        request.setAttribute("cart", cart);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shipping", shipping);
        request.setAttribute("total", total);
        request.setAttribute("cups", cups);

        try {
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
        } catch (Exception ignored) {}
    }

    // STEP 2: User submits payment
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        // Must be logged in
        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get payment method (COD, VietQR, CARD)
        String paymentMethod = request.getParameter("paymentMethod");

        if (paymentMethod == null || paymentMethod.isEmpty()) {
            response.sendRedirect("checkout.jsp?error=No payment method selected");
            return;
        }

        // Load cart
        List<CartItem> cart = cartDAO.getCartByUser(userId);

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=Your cart is empty");
            return;
        }

        double subtotal = 0;
        int cups = 0;

        for (CartItem item : cart) {
            subtotal += item.getFinalPrice() * item.getQuantity();
            cups += item.getQuantity();
        }

        ShippingService shippingService = new ShippingService();

	    // user has only ONE address string
        User currentUser = (User) session.getAttribute("currentUser");
        String fullAddress = currentUser != null ? currentUser.getAddress() : null;
	    String district = AddressUtil.extractDistrict(fullAddress);
		// city fixed for now
	    String city = "Ho Chi Minh City";
	
	    // FINAL shipping fee
	    double shipping = shippingService
	            .calculateShipping(city, district)
	            .doubleValue();
	    double total = subtotal + shipping;

        // Create new order object
        Order order = new Order();
        order.setUserId(userId);
        order.setSubtotal(subtotal);
        order.setShippingFee(shipping);
        order.setTotalAmount(total);
        order.setTotalCups(cups);
        order.setPaymentMethod(paymentMethod);

        // Determine order + payment status
        if (paymentMethod.equals("COD")) {
            order.setStatus("confirmed");
            order.setPaymentStatus("unpaid");
        } else {
            order.setStatus("pending");
            order.setPaymentStatus("pending");
        }

        // Save order → returns orderId
        int orderId = orderDAO.saveOrder(order);
        // 🔥🔥 ADD THIS BLOCK (SHIPPING SNAPSHOT) 🔥🔥
        Shipping shippingObj = new Shipping();
        shippingObj.setOrderId(orderId);
        shippingObj.setReceiverName(currentUser.getFullName());
        shippingObj.setPhone(currentUser.getPhone());
        shippingObj.setAddress(currentUser.getAddress());
        shippingObj.setCity(city);
        shippingObj.setDistrict(district);
        shippingObj.setWard(""); // optional
        shippingObj.setShippingFee(shipping);
        shippingObj.setMethod("standard");
        shippingObj.setStatus("pending");

        ShippingDAO shippingDAO = new ShippingDAO();
        shippingDAO.createShipping(shippingObj);        

        // REDIRECT BASED ON PAYMENT TYPE
        switch (paymentMethod) {

            case "COD" -> {
                // COD is instantly successful
            	orderDAO.moveCartToOrderItems(orderId, cart);
            	cartDAO.clearCart(userId);
            	session.setAttribute("cartCount", 0);
                response.sendRedirect("payment-result?status=success&orderId=" + orderId);
            }

            case "VIETQR" -> {
                // Redirect to VietQR processing controller
            	response.sendRedirect("vietqr?orderId=" + orderId);
            }

            case "CARD" -> {
                // Redirect to card payment controller
                response.sendRedirect("card-payment.jsp?orderId=" + orderId);
            }

            default -> {
                // Unexpected method
                response.sendRedirect("checkout.jsp?error=Invalid payment method");
            }
        }
    }
}
