package dao;

import model.User;
import util.DBConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;

public class UserDAO {

    // Register new customer
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (full_name, email, password, phone, address, role, status) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getPhone());
            stmt.setString(5, user.getAddress());
            stmt.setString(6, user.getRole());
            stmt.setString(7, user.getStatus());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            DBConnection.closeConnection(stmt);
            DBConnection.closeConnection(conn);
        }
    }

    // Login
    public User login(String email) {
        String sql = "SELECT * FROM users WHERE email = ? AND status='active'";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setString(1, email);

            rs = stmt.executeQuery();

            if (rs.next()) {
                return extractUser(rs); // fetches hashed password from DB
            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            DBConnection.closeConnection(rs);
            DBConnection.closeConnection(stmt);
            DBConnection.closeConnection(conn);
        }

        return null;
    }

    // Get user by id
    public User getUserById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setInt(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return extractUser(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            DBConnection.closeConnection(rs);
            DBConnection.closeConnection(stmt);
            DBConnection.closeConnection(conn);
        }

        return null;
    }
    
    // Get user by email
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);

            rs = stmt.executeQuery();

            if (rs.next()) {
                return extractUser(rs);  // reuse your extractUser method
            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            DBConnection.closeConnection(rs);
            DBConnection.closeConnection(stmt);
            DBConnection.closeConnection(conn);
        }

        return null;
    }

    // Get all users
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM users";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                list.add(extractUser(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {
            DBConnection.closeConnection(rs);
            DBConnection.closeConnection(stmt);
            DBConnection.closeConnection(conn);
        }

        return list;
    }

    // Update user
    public boolean updateUser(User user) {
        String sql = "UPDATE users SET full_name=?, email=?, phone=?, address=?, role=?, status=? WHERE id=?";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            stmt = conn.prepareStatement(sql);

            stmt.setString(1, user.getFullName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getAddress());
            stmt.setString(5, user.getRole());
            stmt.setString(6, user.getStatus());
            stmt.setInt(7, user.getId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;

        } finally {
            DBConnection.closeConnection(stmt);
            DBConnection.closeConnection(conn);
        }
    }

    // Forgot password: Save reset token
    public boolean saveResetToken(String email, String token, LocalDateTime expiry) {
        String sql = "UPDATE users SET reset_token = ?, reset_token_expiry = ? WHERE email = ?";

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, token);

            // Convert LocalDateTime to Timestamp
            ps.setTimestamp(2, Timestamp.valueOf(expiry));

            ps.setString(3, email);

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.closeConnection(ps);
            DBConnection.closeConnection(conn);
        }
    }
    // Helper method
    private User extractUser(ResultSet rs) throws SQLException {
        User u = new User();

        u.setId(rs.getInt("id"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPassword(rs.getString("password"));
        u.setPhone(rs.getString("phone"));
        u.setAddress(rs.getString("address"));
        u.setRole(rs.getString("role"));
        u.setStatus(rs.getString("status"));
        u.setResetToken(rs.getString("reset_token"));
        Timestamp ts = rs.getTimestamp("reset_token_expiry");
        if (ts != null) {
            u.setResetTokenExpiry(ts.toLocalDateTime());
        } else {
            u.setResetTokenExpiry(null);
        }
        return u;
    }
    public boolean isResetTokenValid(String token) {
        String sql = "SELECT reset_token_expiry FROM users WHERE reset_token = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                Timestamp expiry = rs.getTimestamp("reset_token_expiry");
                return expiry != null && expiry.toLocalDateTime().isAfter(LocalDateTime.now());
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public User getUserByResetToken(String token) {
        String sql = "SELECT * FROM users WHERE reset_token = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, token);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                return extractUser(rs);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    public boolean updatePassword(String email, String hashedPassword) {
        String sql = "UPDATE users SET password = ?, reset_token = NULL, reset_token_expiry = NULL WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, hashedPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean checkPassword(int userId, String rawPassword) {
        String sql = "SELECT password FROM users WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("password").equals(rawPassword);
                // ⚠️ If hashed → use BCrypt
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    public void deleteUserCompletely(int userId) {

        String deleteCart = "DELETE FROM cart_items WHERE user_id = ?";
        String deleteOrders = "DELETE FROM orders WHERE user_id = ?";
        String deleteUser = "DELETE FROM users WHERE id = ?";

        try (Connection con = DBConnection.getConnection()) {

            con.setAutoCommit(false); // 🔒 transaction

            try (PreparedStatement ps1 = con.prepareStatement(deleteCart);
                 PreparedStatement ps2 = con.prepareStatement(deleteOrders);
                 PreparedStatement ps3 = con.prepareStatement(deleteUser)) {

                ps1.setInt(1, userId);
                ps1.executeUpdate();

                ps2.setInt(1, userId);
                ps2.executeUpdate();

                ps3.setInt(1, userId);
                ps3.executeUpdate();

                con.commit();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}