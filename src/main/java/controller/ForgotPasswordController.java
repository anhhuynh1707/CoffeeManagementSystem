package controller;

import dao.UserDAO;
import model.User;
import util.EmailUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.UUID;

@WebServlet("/forgot-password")
public class ForgotPasswordController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        // Validate email field
        if (email == null || email.isBlank()) {
            request.setAttribute("error", "Please enter your email.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        User user = userDAO.getUserByEmail(email);

        // Check if email exists in DB
        if (user == null) {
            request.setAttribute("error", "No account found with this email.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        // Generate secure reset token & expiry time
        String token = UUID.randomUUID().toString();
        LocalDateTime expiry = LocalDateTime.now().plusMinutes(30);

        boolean saved = userDAO.saveResetToken(email, token, expiry);

        if (!saved) {
            request.setAttribute("error", "Failed to generate reset link. Please try again later.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        // Build full reset-password URL
        String resetUrl = request.getRequestURL().toString()
                .replace("forgot-password", "reset-password")
                + "?token=" + token;

        // Build HTML email content (Gmail-compatible)
        String html = """
                <h2>Password Reset – Matcha Coffee</h2>
                <p>Hello,</p>
                <p>You requested to reset your password.</p>
                <p>Click the button below to continue:</p>

                <p>
                    <a href="{RESET_URL}"
                       style="padding:12px 20px; background:#76b947; color:white;
                              text-decoration:none; border-radius:6px; font-weight:bold;">
                        Reset Password
                    </a>
                </p>

                <p>This link expires in <b>30 minutes</b>.</p>
                <p>If you did not request this, please ignore this email.</p>
                """;

        html = html.replace("{RESET_URL}", resetUrl);

        // Send email via Gmail SMTP
        boolean sent = EmailUtil.sendEmail(
                email,
                "Reset your password – Matcha Coffee",
                html
        );

        if (!sent) {
            request.setAttribute("error",
                    "Failed to send email. Please verify Gmail SMTP settings.");
            request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
            return;
        }

        // Success message
        request.setAttribute("success",
                "A password reset link has been sent to your email inbox.");
        request.getRequestDispatcher("/forgot-password.jsp").forward(request, response);
    }
}