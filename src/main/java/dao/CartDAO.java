package dao;

import model.CartItem;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    // Add item OR increase quantity if already exists
	public void addToCart(int userId, int productId, double basePrice, int quantity) {

	    String checkSql = """
	        SELECT cart_id
	        FROM cart_items 
	        WHERE user_id = ? AND product_id = ?
	    """;

	    String insertSql = """
	        INSERT INTO cart_items 
	        (user_id, product_id, quantity, base_price, extra_price, final_price)
	        VALUES (?, ?, ?, ?, 0, ?)
	    """;

	    String updateSql = """
	        UPDATE cart_items 
	        SET quantity = quantity + ?
	        WHERE cart_id = ?
	    """;

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement checkPs = con.prepareStatement(checkSql)) {

	        checkPs.setInt(1, userId);
	        checkPs.setInt(2, productId);

	        ResultSet rs = checkPs.executeQuery();

	        if (rs.next()) {
	            int cartId = rs.getInt("cart_id");
	            try (PreparedStatement ps = con.prepareStatement(updateSql)) {
	                ps.setInt(1, quantity);   // qty selected
	                ps.setInt(2, cartId);    // correct cart_id
	                ps.executeUpdate();
	            }
	        } else {
	            try (PreparedStatement ps = con.prepareStatement(insertSql)) {
	                ps.setInt(1, userId);
	                ps.setInt(2, productId);
	                ps.setInt(3, quantity);
	                ps.setDouble(4, basePrice);
	                ps.setDouble(5, basePrice);
	                ps.executeUpdate();
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}

    // 🔹 Get all cart items for a user
    public List<CartItem> getCartByUser(int userId) {
        List<CartItem> list = new ArrayList<>();

        String sql = """
        SELECT 
            c.cart_id,
            c.product_id,
            c.quantity,
            c.base_price,
            c.extra_price,
            c.final_price,
            c.milk_type,
            c.sugar_level,
            c.ice_level,
            c.toppings,
            m.name,
            m.image_url,
            m.price
        FROM cart_items c
        JOIN menu m ON c.product_id = m.id
        WHERE c.user_id = ?
        ORDER BY c.created_at DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CartItem item = new CartItem();

                item.setCartId(rs.getInt("cart_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));

                item.setBasePrice(rs.getDouble("base_price"));
                item.setExtraPrice(rs.getDouble("extra_price"));
                item.setFinalPrice(rs.getDouble("final_price"));

                item.setMilkType(rs.getString("milk_type"));
                item.setSugarLevel(rs.getString("sugar_level"));
                item.setIceLevel(rs.getString("ice_level"));
                item.setToppings(rs.getString("toppings"));

                item.setProductName(rs.getString("name"));
                item.setImageUrl(rs.getString("image_url"));

                list.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // 🔹 Increase quantity
    public void increase(int cartId) {
        String sql = "UPDATE cart_items SET quantity = quantity + 1 WHERE cart_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 🔹 Decrease quantity (delete if <= 0)
    public void decrease(int cartId) {
        String sql1 = "UPDATE cart_items SET quantity = quantity - 1 WHERE cart_id = ?";
        String sql2 = "DELETE FROM cart_items WHERE cart_id = ? AND quantity <= 0";

        try (Connection con = DBConnection.getConnection()) {

            try (PreparedStatement ps = con.prepareStatement(sql1)) {
                ps.setInt(1, cartId);
                ps.executeUpdate();
            }

            try (PreparedStatement ps = con.prepareStatement(sql2)) {
                ps.setInt(1, cartId);
                ps.executeUpdate();
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 🔹 Remove item completely
    public void remove(int cartId) {
        String sql = "DELETE FROM cart_items WHERE cart_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 🔹 Delete all items for a user
    public void clearCart(int userId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public int getTotalQuantity(int userId) {
        String sql = "SELECT SUM(quantity) FROM cart_items WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}