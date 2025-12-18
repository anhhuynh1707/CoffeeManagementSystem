package dao;

import java.sql.*;

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
}
