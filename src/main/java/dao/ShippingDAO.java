package dao;

import java.sql.*;

import model.Shipping;
import util.DBConnection;

public class ShippingDAO {
	public Integer getShippingFee(String city, String district) {

	    if (district == null || district.isBlank()) return null;

	    // if you ever pass null city, still allow district-only
	    boolean hasCity = (city != null && !city.isBlank());

	    String sql = hasCity
	        ? "SELECT shipping_fee FROM shipping_zone WHERE LOWER(TRIM(city)) = ? AND LOWER(TRIM(district)) = ? LIMIT 1"
	        : "SELECT shipping_fee FROM shipping_zone WHERE LOWER(TRIM(district)) = ? LIMIT 1";

	    try (Connection con = DBConnection.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        if (hasCity) {
	            ps.setString(1, city.trim().toLowerCase());
	            ps.setString(2, district.trim().toLowerCase());
	        } else {
	            ps.setString(1, district.trim().toLowerCase());
	        }

	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) return rs.getInt(1);
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
			    ON DUPLICATE KEY UPDATE
			      receiver_name = VALUES(receiver_name),
			      phone = VALUES(phone),
			      address = VALUES(address),
			      city = VALUES(city),
			      district = VALUES(district),
			      ward = VALUES(ward),
			      shipping_fee = VALUES(shipping_fee),
			      method = VALUES(method),
			      status = VALUES(status),
			      updated_at = CURRENT_TIMESTAMP
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
