package controller;

import java.io.IOException;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;

@WebServlet("/vietqr")
public class VietQRController extends HttpServlet {

    private static final String BANK_CODE = "MBBank";  // example
    private static final String ACCOUNT_NO = "07777170705";
    private static final String ACCOUNT_NAME = "HUYNH TUAN ANH";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        int orderId = Integer.parseInt(req.getParameter("orderId"));
        double amount = 0;

        OrderDAO dao = new OrderDAO();
        Order order = dao.getOrderById(orderId);

        if (order != null) {
            amount = order.getTotalAmount();
        }

        String qrUrl = "https://img.vietqr.io/image/" + BANK_CODE + "-" + ACCOUNT_NO +
                "-compact2.png?amount=" + (int)amount +
                "&addInfo=ORDER" + orderId;

        req.setAttribute("qrUrl", qrUrl);
        req.setAttribute("orderId", orderId);
        req.setAttribute("amount", amount);
        req.setAttribute("createdAt", order.getCreatedAt());
        req.setAttribute("accountName", ACCOUNT_NAME);

        req.getRequestDispatcher("vietqr.jsp").forward(req, resp);
    }
}