package util;

public class AddressUtil {
	public static String extractDistrict(String fullAddress) {
		if (fullAddress == null)
			return null;
		String[] parts = fullAddress.split(",");
		if (parts.length < 2)
			return null;
		String district = parts[parts.length - 1].trim();
		return district.isEmpty() ? null : district;
	}
}