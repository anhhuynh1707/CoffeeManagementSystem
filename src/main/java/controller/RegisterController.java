package controller;

import dao.UserDAO;
import model.User;
import util.PasswordHashUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterController extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Basic validation
        if(fullName.isEmpty() || email.isEmpty() || password.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Please fill in all required fields.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        //Email validation
        String emailPattern = "^[A-Za-z0-9+_.-]+@(.+)$";
        if (email != null && !email.trim().isEmpty()) {
            if (!email.matches(emailPattern)) {
                request.setAttribute("errorEmail", "Invalid email format.");
            }
        }

        if(!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        if(userDAO.getUserByEmail(email) != null) {
            request.setAttribute("error", "Email is already registered.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Hash password using bcrypt
        String hashedPassword = PasswordHashUtil.hashPassword(password);

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(hashedPassword);
        user.setPhone(phone);
        user.setAddress(address);
        user.setRole("customer");  // default role
        user.setStatus("active");  // default active

        boolean registered = userDAO.registerUser(user);

        if(registered) {
            request.setAttribute("success", "Registration successful. Please login.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}