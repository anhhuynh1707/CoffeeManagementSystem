package service;

import java.math.BigDecimal;
import dao.ShippingDAO;

public class ShippingService {
	private ShippingDAO shippingDAO = new ShippingDAO();

	public BigDecimal calculateShipping(String city, String district) {

	    // 🚨 Guard clause
	    if (district == null || district.isBlank()) {
	        return BigDecimal.valueOf(50000); // fallback
	    }

	    Integer fee = shippingDAO.getShippingFee(
	            city == null ? null : city.trim().toLowerCase(),
	            district.trim().toLowerCase()
	    );

	    if (fee == null) {
	        return BigDecimal.valueOf(50000);
	    }

	    return BigDecimal.valueOf(fee);
	}
}
