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

@WebServlet("/delete-account")
public class DeleteAccountController extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User currentUser = (User) session.getAttribute("currentUser");
        String password = request.getParameter("password");

        // 🔐 verify using PasswordHashUtil
        if (!PasswordHashUtil.verifyPassword(password, currentUser.getPassword())) {
            request.setAttribute("error", "Incorrect password");
            request.getRequestDispatcher("delete-account.jsp")
                   .forward(request, response);
            return;
        }

        // 🧹 delete everything
        userDAO.deleteUserCompletely(currentUser.getId());

        // 💬 success message for login page
        HttpSession flashSession = request.getSession(true);
        flashSession.setAttribute(
            "successMsg",
            "Your account has been deleted successfully. We're sorry to see you go 🍃"
        );

        session.invalidate();

        response.sendRedirect("login.jsp");
    }
}
