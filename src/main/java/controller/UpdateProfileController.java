package controller;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/update-profile")
public class UpdateProfileController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Ensure user is logged in
        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");

        // Fetch updated fields
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Basic validation
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Full name cannot be empty.");
            request.getRequestDispatcher("profile").forward(request, response);
            return;
        }

        // Update user object
        currentUser.setFullName(fullName);
        currentUser.setPhone(phone);
        currentUser.setAddress(address);

        // Save to database
        boolean updated = userDAO.updateUser(currentUser);

        if (updated) {
            // Refresh session
            session.setAttribute("currentUser", currentUser);

            // Redirect to avoid form resubmission
            response.sendRedirect("profile?success=1");
        } else {
            request.setAttribute("error", "Failed to update profile. Please try again.");
            request.getRequestDispatcher("profile").forward(request, response);
        }
    }
}