package controller;

import java.io.IOException;
import java.util.List;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Order;
import model.OrderItem;

@WebServlet("/order-details")
public class OrderDetailsController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String id = request.getParameter("id");
        if (id == null) {
            response.sendRedirect("menu.jsp");
            return;
        }

        int orderId = Integer.parseInt(id);

        Order order = orderDAO.getOrderById(orderId);
        List<OrderItem> items = orderDAO.getOrderItems(orderId);

        request.setAttribute("order", order);
        request.setAttribute("items", items);

        request.getRequestDispatcher("order-details.jsp").forward(request, response);
    }
}