package dao;

import util.DBConnection;
import model.Order;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

    // ---- TOTAL ORDERS ----
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM orders";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }


    // ---- TOTAL USERS ----
    public int getTotalUsers() {
        String sql = "SELECT COUNT (*) FROM users WHERE role = 'customer'"; //count all the users except admins

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }


    // ---- TOTAL PRODUCTS ----
    // FIX: use menu table, NOT products
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM menu";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }


    // ---- TOTAL REVENUE ----
    public double getTotalRevenue() {
        String sql = "SELECT SUM(total_amount) FROM orders WHERE status = 'confirmed'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getDouble(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }


    // ---- RECENT 5 ORDERS ----
    public List<Order> getRecentOrders() {
        List<Order> list = new ArrayList<>();

        String sql = """
        	    SELECT 
        	        o.order_id AS id,
        	        o.total_amount,
        	        o.status,
        	        o.created_at,
        	        u.full_name AS customerName
        	    FROM orders o
        	    JOIN users u ON o.user_id = u.id
        	    ORDER BY o.created_at DESC
        	    LIMIT 10
        	""";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setStatus(rs.getString("status"));
                o.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                o.setCustomerName(rs.getString("customerName")); // NOW VALID

                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}