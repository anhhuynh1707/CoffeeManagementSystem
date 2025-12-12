package controller;
import java.io.IOException;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import util.PasswordHashUtil;

@WebServlet("/change-password")
public class ChangePasswordController extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String currentPass = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        // 1. Validate old password
        if (!PasswordHashUtil.verifyPassword(currentPass, currentUser.getPassword())) {
            request.setAttribute("error", "Current password is incorrect.");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        // 2. Confirm new password = confirm password
        if (!newPass.equals(confirmPass)) {
            request.setAttribute("error", "New passwords do not match.");
            request.getRequestDispatcher("change-password.jsp").forward(request, response);
            return;
        }

        // 3. Hash new password
        String hashed = PasswordHashUtil.hashPassword(newPass);

        // 4. Update DB
        boolean updated = userDAO.updatePassword(currentUser.getEmail(), hashed);

        if (updated) {
            request.setAttribute("success", "Password updated successfully.");
            currentUser.setPassword(hashed); // update session
        } else {
            request.setAttribute("error", "Failed to update password.");
        }

        request.getRequestDispatcher("change-password.jsp").forward(request, response);
    }
}