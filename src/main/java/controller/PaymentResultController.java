package controller;

import java.io.IOException;

import dao.CartDAO;
import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/payment-result")
public class PaymentResultController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        HttpSession session = req.getSession(false);
        Integer userId = (Integer) session.getAttribute("userId");

        String status = req.getParameter("status");
        int orderId = Integer.parseInt(req.getParameter("orderId"));

        if ("success".equalsIgnoreCase(status) && userId != null) {
            // ONLY clear cart (order already created)
            cartDAO.clearCart(userId);
            session.setAttribute("cartCount", 0);
        }

        req.setAttribute("status", status);
        req.setAttribute("orderId", orderId);
        req.getRequestDispatcher("payment-result.jsp").forward(req, resp);
    }
}