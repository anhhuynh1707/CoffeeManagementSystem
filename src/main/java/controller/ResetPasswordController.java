package controller;

import dao.UserDAO;
import util.PasswordHashUtil;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/reset-password")
public class ResetPasswordController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");

        if (token == null || token.isEmpty() || !userDAO.isResetTokenValid(token)) {
            request.setAttribute("error", "Invalid or expired reset link.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        request.setAttribute("token", token);
        request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (token == null || token.isEmpty()) {
            request.setAttribute("error", "Invalid request.");
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }

        if (password == null || password.isEmpty() || confirmPassword == null || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Please fill in all fields.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
            return;
        }

        // Validate token and get user
        User user = userDAO.getUserByResetToken(token);

        if (user == null) {
            request.setAttribute("error", "Invalid or expired reset link.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        // Hash new password
        String hashedPassword = PasswordHashUtil.hashPassword(password);

        boolean updated = userDAO.updatePassword(user.getEmail(), hashedPassword);

        if (updated) {
            request.setAttribute("success", "Password reset successfully. Please login.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to reset password. Try again.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/reset-password.jsp").forward(request, response);
        }
    }
}