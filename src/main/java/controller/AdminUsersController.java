package controller;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/users")
public class AdminUsersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // TEMP: logic comes later
        // request.setAttribute("users", users);

        request.getRequestDispatcher("/admin-users.jsp")
               .forward(request, response);
    }
}
