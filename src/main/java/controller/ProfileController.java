package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileController extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Get user ID from session
        int userId = (int) session.getAttribute("userId");

        // Fetch user info from DB
        User user = userDAO.getUserById(userId);

        if (user == null) {
            // User not found → force logout
            session.invalidate();
            response.sendRedirect("login.jsp");
            return;
        }

        // Send user object to JSP
        request.setAttribute("user", user);

        // Forward to JSP
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }
}
