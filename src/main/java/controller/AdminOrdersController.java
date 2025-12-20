package controller;


import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/orders")
public class AdminOrdersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // TEMP: logic comes later
        // request.setAttribute("orders", orders);

        request.getRequestDispatcher("/admin-orders.jsp")
               .forward(request, response);
    }
}

