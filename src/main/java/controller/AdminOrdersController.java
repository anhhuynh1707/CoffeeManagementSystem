package controller;

import dao.OrderDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;
import model.Order;

@WebServlet("/orders")
public class AdminOrdersController extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Load orders for admin page
        List<Order> orders = orderDAO.getAllOrdersForAdmin();
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/admin-orders.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        if (role == null || !"admin".equalsIgnoreCase(role)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        String orderIdStr = request.getParameter("orderId");

        if (action == null || orderIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/orders");
            return;
        }

        int orderId = Integer.parseInt(orderIdStr);

        boolean ok = false;

        if ("complete".equals(action)) {
            ok = orderDAO.markOrderCompletedAndPaid(orderId);
        } else if ("cancel".equals(action)) {
            ok = orderDAO.cancelOrder(orderId); // instead of updateOrderStatus
        } else if ("confirm".equals(action)) {
            ok = orderDAO.updateOrderStatus(orderId, "confirmed");
        } else if ("preparing".equals(action)) {
            ok = orderDAO.updateOrderStatus(orderId, "preparing");
        } else if ("updateOrderStatus".equals(action)) {
            String status = request.getParameter("status"); // from <select name="status">
            if (status != null && !status.isBlank()) {
                ok = orderDAO.updateOrderStatus(orderId, status);
            }
        }

        // optional: flash message
        session.setAttribute("ordersMsg", ok ? "Updated successfully." : "Update failed.");
        response.sendRedirect(request.getContextPath() + "/orders");
    }
}
