package controller;

import dao.OrderDAO;
import dao.ShippingDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Order;
import model.Shipping;

import java.io.IOException;

@WebServlet("/shipping")
public class ShippingController extends HttpServlet {

    private ShippingDAO shippingDAO = new ShippingDAO();
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        Order order = orderDAO.getOrderById(orderId);
        Shipping shipping = shippingDAO.getShippingByOrderId(orderId);

        request.setAttribute("order", order);
        request.setAttribute("shipping", shipping);
        request.setAttribute("orderItems", orderDAO.getOrderItems(orderId));

        request.getRequestDispatcher("shipping.jsp").forward(request, response);
    }
}