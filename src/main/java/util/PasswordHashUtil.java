package util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordHashUtil {

    // Hash a password
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(12)); // 12 = workload factor
    }

    // Verify a password
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (hashedPassword == null || hashedPassword.isEmpty()) return false;
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }

    // Testing
//    public static void main(String[] args) {
//        String password = "Admin@123";
//        String hashed = hashPassword(password);
//
//        System.out.println("Hashed: " + hashed);
//        System.out.println("Verify correct: " + verifyPassword("Admin@123", hashed));
//        System.out.println("Verify wrong: " + verifyPassword("Admin@12", hashed));
//    }
}
