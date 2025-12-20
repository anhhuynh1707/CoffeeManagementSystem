package util;

public class AddressUtil {
	public static String extractDistrict(String address) {

	    if (address == null || address.trim().isEmpty()) {
	        return null;
	    }

	    String[] parts = address.split(",");
	    if (parts.length == 0) {
	        return null;
	    }

	    return parts[parts.length - 1].trim();
	}
}