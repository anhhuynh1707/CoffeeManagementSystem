package dao;

import model.CartItem;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

	// Add item OR increase quantity if already exists
	public void addToCart(int userId, int productId, int quantity, double basePrice, double extraPrice,
			double finalPrice, String milk, String sugar, String ice, String toppings) {

		String checkSql = """
				SELECT cart_id
				FROM cart_items
				WHERE user_id = ?
				AND product_id = ?
				AND milk_type = ?
				AND sugar_level = ?
				AND ice_level = ?
				""";

		String insertSql = """
				INSERT INTO cart_items
				(user_id, product_id, quantity,
				base_price, extra_price, final_price,
				milk_type, sugar_level, ice_level, toppings)
				VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
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
			checkPs.setString(3, milk);
			checkPs.setString(4, sugar);
			checkPs.setString(5, ice);

			ResultSet rs = checkPs.executeQuery();

			if (rs.next()) {
				int cartId = rs.getInt("cart_id");
				try (PreparedStatement ps = con.prepareStatement(updateSql)) {
					ps.setInt(1, quantity);
					ps.setInt(2, cartId);
					ps.executeUpdate();
				}
			} else {
				try (PreparedStatement ps = con.prepareStatement(insertSql)) {
					ps.setInt(1, userId);
					ps.setInt(2, productId);
					ps.setInt(3, quantity);
					ps.setDouble(4, basePrice);
					ps.setDouble(5, extraPrice);
					ps.setDouble(6, finalPrice);
					ps.setString(7, milk);
					ps.setString(8, sugar);
					ps.setString(9, ice);
					ps.setString(10, toppings);
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

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

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
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

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

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, cartId);
			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 🔹 Delete all items for a user
	public void clearCart(int userId) {
		String sql = "DELETE FROM cart_items WHERE user_id = ?";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, userId);
			ps.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public int getTotalQuantity(int userId) {
		String sql = "SELECT SUM(quantity) FROM cart_items WHERE user_id = ?";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

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

	public void updateOptions(int cartId, int userId, String milk, String sugar, String ice) {
		double extraPrice = 0;
		// 🧮 PRICE RULES (milk affects price)
		if ("Oatside".equals(milk)) {
			extraPrice = 0.5;
		} else if ("Cream Milk".equals(milk)) {
			extraPrice = 0.7;
		}
		// Fresh Milk → +0
		String sql = """
				UPDATE cart_items
				SET milk_type = ?,
				sugar_level = ?,
				ice_level = ?,
				extra_price = ?,
				final_price = base_price + ?
				WHERE cart_id = ? AND user_id = ?
				""";
		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
			ps.setString(1, milk);
			ps.setString(2, sugar);
			ps.setString(3, ice);
			ps.setDouble(4, extraPrice);
			ps.setDouble(5, extraPrice);
			ps.setInt(6, cartId);
			ps.setInt(7, userId);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}