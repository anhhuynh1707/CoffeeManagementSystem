package controller;

import dao.OrderDAO;
import model.OrderItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/order-details")
public class AdminOrderDetailsController extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int orderId = Integer.parseInt(orderIdParam);
        List<OrderItem> items = orderDAO.getOrderItems(orderId);

        request.setAttribute("items", items);
        request.getRequestDispatcher("/admin-order-items.jsp")
               .forward(request, response);
    }
}
