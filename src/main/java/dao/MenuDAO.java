package dao;

import model.Menu;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {

    // Get all items (including category, image, price)
	public List<Menu> getMenuByCategory(String category) {

	    List<Menu> list = new ArrayList<>();

	    String sql;

	    if (category == null || category.equals("all")) {
	        sql = "SELECT * FROM menu WHERE status = 'available' ORDER BY created_at DESC";
	    } else {
	        sql = "SELECT * FROM menu WHERE status = 'available' AND category = ? ORDER BY created_at DESC";
	    }

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        // If category is applied, set parameter
	        if (category != null && !category.equals("all")) {
	            ps.setString(1, category);
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

	                if (created != null) item.setCreatedAt(created.toLocalDateTime());
	                if (updated != null) item.setUpdatedAt(updated.toLocalDateTime());

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

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

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

	                if (created != null) item.setCreatedAt(created.toLocalDateTime());
	                if (updated != null) item.setUpdatedAt(updated.toLocalDateTime());

	                return item;  // return the found menu item
	            }
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return null;  // if no item found
	}
}