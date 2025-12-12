package controller;

import dao.MenuDAO;
import model.Menu;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class MenuController extends HttpServlet {

    private MenuDAO menuDAO = new MenuDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");  // matcha, coffee, etc.

        List<Menu> menuList = menuDAO.getMenuByCategory(category);

        request.setAttribute("menuList", menuList);
        request.setAttribute("selectedCategory", category);

        request.getRequestDispatcher("menu.jsp").forward(request, response);
    }
}
