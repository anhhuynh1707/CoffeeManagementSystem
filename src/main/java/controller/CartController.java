package controller;

import dao.CartDAO;
import dao.MenuDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;
import model.Menu;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private CartDAO cartDAO = new CartDAO();
    private MenuDAO menuDAO = new MenuDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String op = request.getParameter("op");
        String cid = request.getParameter("cid");   // cart_id
        String pid = request.getParameter("pid");   // product_id

        if ("add".equals(op) && pid != null) {
            Menu product = menuDAO.getMenuById(Integer.parseInt(pid));
            if (product != null) {
                cartDAO.addToCart(userId, product.getId(), product.getPrice());
            }
            request.setAttribute("successMsg", "Added to cart successfully!");
        }

        if ("inc".equals(op) && cid != null) {
            cartDAO.increase(Integer.parseInt(cid));
        }

        if ("dec".equals(op) && cid != null) {
            cartDAO.decrease(Integer.parseInt(cid));
        }

        if ("remove".equals(op) && cid != null) {
            cartDAO.remove(Integer.parseInt(cid));
        }

        // Load updated cart
        List<CartItem> cart = cartDAO.getCartByUser(userId);

        double subtotal = 0;
        for (CartItem item : cart) {
            subtotal += item.getFinalPrice() * item.getQuantity();
        }

        double shipping = subtotal > 0 ? 2.50 : 0;
        double total = subtotal + shipping;

        request.setAttribute("cartItems", cart);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shipping", shipping);
        request.setAttribute("total", total);

        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}