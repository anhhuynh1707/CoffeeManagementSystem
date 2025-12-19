package dao;

import java.sql.*;

import model.Shipping;
import util.DBConnection;

public class ShippingDAO {
	public Integer getShippingFee(String city, String district) {

	    if (district == null) {
	        return null;
	    }

	    String sql = """
	        SELECT shipping_fee
	        FROM shipping_zone
	        WHERE LOWER(TRIM(district)) = ?
	    """;

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setString(1, district.trim().toLowerCase());

	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            return rs.getInt("shipping_fee");
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return null;
	}
	public void createShipping(Shipping shipping) {

        String sql = """
            INSERT INTO shipping
            (order_id, receiver_name, phone, address, city, district, ward,
             shipping_fee, method, status)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, shipping.getOrderId());
            ps.setString(2, shipping.getReceiverName());
            ps.setString(3, shipping.getPhone());
            ps.setString(4, shipping.getAddress());
            ps.setString(5, shipping.getCity());
            ps.setString(6, shipping.getDistrict());
            ps.setString(7, shipping.getWard());
            ps.setDouble(8, shipping.getShippingFee());
            ps.setString(9, shipping.getMethod());
            ps.setString(10, shipping.getStatus());

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	public Shipping getShippingByOrderId(int orderId) {

        String sql = "SELECT * FROM shipping WHERE order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Shipping s = new Shipping();
                s.setShippingId(rs.getInt("shipping_id"));
                s.setOrderId(rs.getInt("order_id"));
                s.setReceiverName(rs.getString("receiver_name"));
                s.setPhone(rs.getString("phone"));
                s.setAddress(rs.getString("address"));
                s.setCity(rs.getString("city"));
                s.setDistrict(rs.getString("district"));
                s.setWard(rs.getString("ward"));
                s.setShippingFee(rs.getDouble("shipping_fee"));
                s.setMethod(rs.getString("method"));
                s.setStatus(rs.getString("status"));
                s.setCreatedAt(rs.getTimestamp("created_at"));
                s.setUpdatedAt(rs.getTimestamp("updated_at"));
                return s;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
