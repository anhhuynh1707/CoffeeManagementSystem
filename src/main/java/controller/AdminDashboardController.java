package controller;

import dao.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/dashboard")
public class AdminDashboardController extends HttpServlet {

    private AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("currentUser") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        if (!"admin".equalsIgnoreCase(role)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied.");
            return;
        }

        // Load dashboard stats
        req.setAttribute("totalOrders", adminDAO.getTotalOrders());
        req.setAttribute("totalUsers", adminDAO.getTotalUsers());
        req.setAttribute("totalRevenue", adminDAO.getTotalRevenue());
        req.setAttribute("totalProducts", adminDAO.getTotalProducts());
        req.setAttribute("recentOrders", adminDAO.getRecentOrders());

        req.getRequestDispatcher("/admin-dashboard.jsp").forward(req, resp);
    }
}