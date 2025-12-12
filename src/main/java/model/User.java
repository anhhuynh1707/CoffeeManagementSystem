package model;

import java.time.LocalDateTime;

public class User {

    private int id;
    private String fullName;
    private String email;
    private String password;     // hashed password
    private String phone;
    private String address;

    private String role;         // "customer" or "admin"
    private String status;       // "active", "inactive", "deleted"

    // For password reset via email
    private String resetToken;
    private LocalDateTime resetTokenExpiry;

    // Constructors
    public User() {
    }

    public User(int id, String fullName, String email, String password,
                String phone, String address, String role, String status) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.status = status;
    }

    // ==================== GETTERS & SETTERS ====================

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getResetToken() {
        return resetToken;
    }

    public void setResetToken(String resetToken) {
        this.resetToken = resetToken;
    }

    public LocalDateTime getResetTokenExpiry() {
        return resetTokenExpiry;
    }

    public void setResetTokenExpiry(LocalDateTime resetTokenExpiry) {
        this.resetTokenExpiry = resetTokenExpiry;
    }
    // Utility methods
    public boolean isAdmin() {
        return "admin".equalsIgnoreCase(this.role);
    }
    
    public boolean isCustomer() {
        return "customer".equalsIgnoreCase(this.role);
    }
}