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

        String category = request.getParameter("category");
        String keyword  = request.getParameter("q");       // search
        String sort     = request.getParameter("sort");    // price sorting

        List<Menu> menuList = menuDAO.getMenu(category, keyword, sort);

        request.setAttribute("menuList", menuList);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("keyword", keyword);
        request.setAttribute("sort", sort);

        request.getRequestDispatcher("menu.jsp").forward(request, response);
    }
}
