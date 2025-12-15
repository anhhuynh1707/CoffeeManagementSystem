package dao;

import model.CartItem;
import model.Order;
import model.OrderItem;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int saveOrder(Order order) {
        String sql = "INSERT INTO orders (user_id, subtotal, shipping_fee, total_amount, total_cups, status, payment_method, payment_status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getSubtotal());
            ps.setDouble(3, order.getShippingFee());
            ps.setDouble(4, order.getTotalAmount());
            ps.setInt(5, order.getTotalCups());
            ps.setString(6, order.getStatus());
            ps.setString(7, order.getPaymentMethod());
            ps.setString(8, order.getPaymentStatus());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // return order_id
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }


    public void saveOrderItems(int orderId, List<OrderItem> items) {
        String sql = "INSERT INTO order_items (order_id, product_id, quantity, base_price, extra_price, final_price, milk_type, sugar_level, ice_level, toppings) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            for (OrderItem item : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getProductId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getBasePrice());
                ps.setDouble(5, item.getExtraPrice());
                ps.setDouble(6, item.getFinalPrice());
                ps.setString(7, item.getMilkType());
                ps.setString(8, item.getSugarLevel());
                ps.setString(9, item.getIceLevel());
                ps.setString(10, item.getToppings());
                ps.addBatch();
            }
            ps.executeBatch();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void moveCartToOrderItems(int orderId, List<CartItem> cart) {

        String sql = """
            INSERT INTO order_items 
            (order_id, product_id, quantity, base_price, extra_price, final_price, 
             milk_type, sugar_level, ice_level, toppings)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            for (CartItem c : cart) {
                ps.setInt(1, orderId);
                ps.setInt(2, c.getProductId());
                ps.setInt(3, c.getQuantity());
                ps.setDouble(4, c.getBasePrice());
                ps.setDouble(5, c.getExtraPrice());
                ps.setDouble(6, c.getFinalPrice());
                ps.setString(7, c.getMilkType());
                ps.setString(8, c.getSugarLevel());
                ps.setString(9, c.getIceLevel());
                ps.setString(10, c.getToppings());
                ps.addBatch();
            }

            ps.executeBatch();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setSubtotal(rs.getDouble("subtotal"));
                order.setShippingFee(rs.getDouble("shipping_fee"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setTotalCups(rs.getInt("total_cups"));
                order.setStatus(rs.getString("status"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setPaymentStatus(rs.getString("payment_status"));
                Timestamp ts = rs.getTimestamp("created_at");
                if (ts != null) {
                    order.setCreatedAt(ts.toLocalDateTime());
                }

                return order;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
    public List<OrderItem> getOrderItems(int orderId) {

        List<OrderItem> list = new ArrayList<>();

        String sql = """
            SELECT 
                oi.item_id,
                oi.order_id,
                oi.product_id,
                oi.quantity,
                oi.base_price,
                oi.extra_price,
                oi.final_price,
                oi.milk_type,
                oi.sugar_level,
                oi.ice_level,
                oi.toppings,
                m.name AS product_name,
                m.image_url
            FROM order_items oi
            JOIN menu m ON oi.product_id = m.id
            WHERE oi.order_id = ?
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();

                // existing fields
                item.setItemId(rs.getInt("item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setBasePrice(rs.getDouble("base_price"));
                item.setExtraPrice(rs.getDouble("extra_price"));
                item.setFinalPrice(rs.getDouble("final_price"));
                item.setMilkType(rs.getString("milk_type"));
                item.setSugarLevel(rs.getString("sugar_level"));
                item.setIceLevel(rs.getString("ice_level"));
                item.setToppings(rs.getString("toppings"));

                // 🔥 NEW: product info
                item.setProductName(rs.getString("product_name"));
                item.setImageUrl(rs.getString("image_url"));

                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public List<Order> getOrdersByUser(int userId) {
        List<Order> list = new ArrayList<>();

        String sql = """
            SELECT * FROM orders 
            WHERE user_id = ? 
            ORDER BY created_at DESC
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();

                order.setId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setSubtotal(rs.getDouble("subtotal"));
                order.setShippingFee(rs.getDouble("shipping_fee"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setTotalCups(rs.getInt("total_cups"));
                order.setStatus(rs.getString("status"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setPaymentStatus(rs.getString("payment_status"));

                Timestamp ts = rs.getTimestamp("created_at");
                if (ts != null) order.setCreatedAt(ts.toLocalDateTime());

                list.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}