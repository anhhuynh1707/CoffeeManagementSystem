package dao;

import model.Menu;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {

	// Get all items (including category, image, price)
	public List<Menu> getMenu(String category, String keyword, String sort) {

		List<Menu> list = new ArrayList<>();

		StringBuilder sql = new StringBuilder("SELECT * FROM menu WHERE status = 'available'");

		// Filter by category
		if (category != null && !category.equals("all")) {
			sql.append(" AND category = ?");
		}

		// Search by name
		if (keyword != null && !keyword.trim().isEmpty()) {
			sql.append(" AND LOWER(name) LIKE ?");
		}

		// Sort by price
		if ("price_asc".equals(sort)) {
			sql.append(" ORDER BY price ASC");
		} else if ("price_desc".equals(sort)) {
			sql.append(" ORDER BY price DESC");
		} else {
			sql.append(" ORDER BY created_at DESC");
		}

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql.toString())) {

			int index = 1;

			if (category != null && !category.equals("all")) {
				ps.setString(index++, category);
			}

			if (keyword != null && !keyword.trim().isEmpty()) {
				ps.setString(index++, "%" + keyword.toLowerCase() + "%");
			}

			try (ResultSet rs = ps.executeQuery()) {
				while (rs.next()) {
					Menu item = new Menu();
					item.setId(rs.getInt("id"));
					item.setName(rs.getString("name"));
					item.setDescription(rs.getString("description"));
					item.setPrice(rs.getDouble("price"));
					item.setImageUrl(rs.getString("image_url"));
					item.setCategory(rs.getString("category"));
					item.setStatus(rs.getString("status"));

					Timestamp created = rs.getTimestamp("created_at");
					Timestamp updated = rs.getTimestamp("updated_at");

					if (created != null)
						item.setCreatedAt(created.toLocalDateTime());
					if (updated != null)
						item.setUpdatedAt(updated.toLocalDateTime());

					list.add(item);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	// Get a single menu item by ID
	public Menu getMenuById(int id) {

		String sql = "SELECT * FROM menu WHERE id = ? AND status = 'available'";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, id);

			try (ResultSet rs = ps.executeQuery()) {
				if (rs.next()) {

					Menu item = new Menu();

					item.setId(rs.getInt("id"));
					item.setName(rs.getString("name"));
					item.setDescription(rs.getString("description"));
					item.setPrice(rs.getDouble("price"));
					item.setImageUrl(rs.getString("image_url"));
					item.setCategory(rs.getString("category"));
					item.setStatus(rs.getString("status"));

					Timestamp created = rs.getTimestamp("created_at");
					Timestamp updated = rs.getTimestamp("updated_at");

					if (created != null)
						item.setCreatedAt(created.toLocalDateTime());
					if (updated != null)
						item.setUpdatedAt(updated.toLocalDateTime());

					return item; // return the found menu item
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null; // if no item found
	}

	public List<Menu> getAllProductsForAdmin() {

		List<Menu> list = new ArrayList<>();
		String sql = "SELECT * FROM menu ORDER BY created_at DESC";

		try (Connection con = DBConnection.getConnection();
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Menu item = new Menu();
				item.setId(rs.getInt("id"));
				item.setName(rs.getString("name"));
				item.setDescription(rs.getString("description"));
				item.setPrice(rs.getDouble("price"));
				item.setImageUrl(rs.getString("image_url"));
				item.setCategory(rs.getString("category"));
				item.setStatus(rs.getString("status"));

				Timestamp created = rs.getTimestamp("created_at");
				Timestamp updated = rs.getTimestamp("updated_at");

				if (created != null)
					item.setCreatedAt(created.toLocalDateTime());
				if (updated != null)
					item.setUpdatedAt(updated.toLocalDateTime());

				list.add(item);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	public boolean addProduct(Menu product) {

		String sql = """
				    INSERT INTO menu (name, description, price, image_url, category, status)
				    VALUES (?, ?, ?, ?, ?, ?)
				""";

		try (Connection con = DBConnection.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setString(1, product.getName());
			ps.setString(2, product.getDescription());
			ps.setDouble(3, product.getPrice());
			ps.setString(4, product.getImageUrl()); // <-- path like "img/menu/xxx.jpg"
			ps.setString(5, product.getCategory());
			ps.setString(6, product.getStatus()); // "available" or "unavailable"

			return ps.executeUpdate() == 1;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

}