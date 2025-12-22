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
        String sql = "SELECT COUNT(*) AS total FROM users WHERE role = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "customer");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt("total");
            }

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
        String sql = "SELECT COALESCE(SUM(total_amount), 0) FROM orders WHERE status = 'completed'";

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
    
 // ---- ALL ORDERS FOR ADMIN ----
    public List<Order> getAllOrdersForAdmin() {
        List<Order> list = new ArrayList<>();

        String sql = """
            SELECT
                o.order_id,
                o.user_id,
                o.subtotal,
                o.shipping_fee,
                o.total_amount,
                o.total_cups,
                o.status,
                o.payment_method,
                o.payment_status,
                o.updated_at
            FROM orders o
            ORDER BY o.created_at DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("order_id"));
                o.setUserId(rs.getInt("user_id"));
                o.setSubtotal(rs.getDouble("subtotal"));
                o.setShippingFee(rs.getDouble("shipping_fee"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setTotalCups(rs.getInt("total_cups"));
                o.setStatus(rs.getString("status"));
                o.setPaymentMethod(rs.getString("payment_method"));
                o.setPaymentStatus(rs.getString("payment_status"));

                Timestamp updated = rs.getTimestamp("updated_at");
                if (updated != null) o.setUpdatedAt(updated.toLocalDateTime());

                list.add(o);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
 // ---- ADMIN: MARK ORDER AS COMPLETED ----
    public boolean markOrderCompleted(int orderId) {

        String sql = """
            UPDATE orders
            SET status = 'completed',
                payment_status = 'paid'
            WHERE order_id = ?
              AND status != 'completed'
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
 // ---- ADMIN: CANCEL ORDER ----
    public boolean cancelOrder(int orderId) {

        String sql = """
            UPDATE orders
            SET status = 'cancelled',
                payment_status = 'failed'
            WHERE order_id = ?
              AND status != 'completed'
              AND payment_status != 'paid'
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            return ps.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }



}