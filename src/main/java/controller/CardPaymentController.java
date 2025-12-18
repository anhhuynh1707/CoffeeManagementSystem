package controller;
import java.io.IOException;

import dao.CartDAO;
import dao.OrderDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/card-payment")
public class CardPaymentController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private CartDAO cartDAO = new CartDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("currentUser");

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String cardNumber = request.getParameter("cardNumber");

        boolean paymentSuccess =
                cardNumber != null && cardNumber.matches("\\d{16}");

        if (!paymentSuccess) {
            response.sendRedirect(
                "payment-result?status=failed&orderId=" + orderId
            );
            return;
        }

        orderDAO.confirmCardPayment(orderId);

        cartDAO.clearCart(user.getId());
        session.setAttribute("cartCount", 0);

        response.sendRedirect(
            "payment-result?status=success&orderId=" + orderId
        );
    }
}