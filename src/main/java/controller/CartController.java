package controller;

import dao.CartDAO;
import dao.MenuDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.CartItem;
import model.Menu;
import model.User;
import service.ShippingService;
import util.AddressUtil;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/cart")
public class CartController extends HttpServlet {

    private CartDAO cartDAO = new CartDAO();
    private MenuDAO menuDAO = new MenuDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        String op = request.getParameter("op");

        if ("updateOptions".equals(op)) {

            int cartId = Integer.parseInt(request.getParameter("cid"));
            String milk = request.getParameter("milk");
            String sugar = request.getParameter("sugar");
            String ice = request.getParameter("ice");

            cartDAO.updateOptions(cartId, userId, milk, sugar, ice);
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
    
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
        String cid = request.getParameter("cid");
        String pid = request.getParameter("pid");

        /* ========= ADD TO CART ========= */
        if ("add".equals(op) && pid != null) {

            int qty = 1;

            // ✅ DEFAULT OPTIONS
            String milk = null;
            String sugar = null;
            String ice = null;
            String toppings = ""; // optional

            if (request.getParameter("qty") != null) {
                qty = Integer.parseInt(request.getParameter("qty"));
            }

            Menu product = menuDAO.getMenuById(Integer.parseInt(pid));
            if (product != null) {

                double basePrice = product.getPrice();
                double extraPrice = 0;
                if (!"Bakery".equalsIgnoreCase(product.getCategory())) {
                    // ☕ Drink defaults
                    milk = "Fresh Milk";
                    sugar = "70%";
                    ice = "100%";
                }
	             // ☕ Drinks only
	             if (!"Bakery".equalsIgnoreCase(product.getCategory())) {
	                 if ("Oatside".equals(milk)) {
	                     extraPrice = 5000;
	                 } else if ("Cream Milk".equals(milk)) {
	                     extraPrice = 7000;
	                 }
	             }
	             double finalPrice = basePrice + extraPrice;
                cartDAO.addToCart(
                        userId,
                        product.getId(),
                        qty,
                        basePrice,
                        extraPrice,
                        finalPrice,
                        milk,
                        sugar,
                        ice,
                        toppings
                );
            }

            // update cart count immediately
            int cartCount = cartDAO.getTotalQuantity(userId);
            session.setAttribute("cartCount", cartCount);

            // stay on menu
            response.sendRedirect(request.getContextPath() + "/menu");
            return;
        }

        /* ========= INCREASE ========= */
        if ("inc".equals(op) && cid != null) {
            cartDAO.increase(Integer.parseInt(cid));
        }

        /* ========= DECREASE ========= */
        if ("dec".equals(op) && cid != null) {
            cartDAO.decrease(Integer.parseInt(cid));
        }

        /* ========= REMOVE ========= */
        if ("remove".equals(op) && cid != null) {
            cartDAO.remove(Integer.parseInt(cid));
        }

        /* ========= LOAD CART ========= */
        List<CartItem> cart = cartDAO.getCartByUser(userId);

        BigDecimal subtotal = BigDecimal.ZERO;
        for (CartItem item : cart) {
        	BigDecimal price = BigDecimal.valueOf(item.getFinalPrice());
            BigDecimal qty = BigDecimal.valueOf(item.getQuantity());
            subtotal = subtotal.add(price.multiply(qty));
        }


        ShippingService shippingService = new ShippingService();

	    // get user address (single string)
        User currentUser = (User) session.getAttribute("currentUser");
        String fullAddress = currentUser != null ? currentUser.getAddress() : null;
	    // OR: currentUser.getAddress()
	    String district = AddressUtil.extractDistrict(fullAddress);
	    // fixed city for now
	    String city = "Ho Chi Minh City";
	
	    BigDecimal shipping = subtotal.compareTo(BigDecimal.ZERO) > 0
	            ? shippingService.calculateShipping(city, district)
	            : BigDecimal.ZERO;
	
	    BigDecimal total = subtotal.add(shipping);

        request.setAttribute("cartItems", cart);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shipping", shipping);
        request.setAttribute("total", total);

        // update cart count
        int cartCount = cartDAO.getTotalQuantity(userId);
        session.setAttribute("cartCount", cartCount);

        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }
}