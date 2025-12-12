package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/payment-result")
public class PaymentResultController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        String status = req.getParameter("status");
        String orderId = req.getParameter("orderId");

        req.setAttribute("status", status);
        req.setAttribute("orderId", orderId);

        req.getRequestDispatcher("payment-result.jsp").forward(req, resp);
    }
}