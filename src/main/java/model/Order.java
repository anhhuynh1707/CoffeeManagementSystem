package model;

import java.time.LocalDateTime;
import java.util.List;

public class Order {

    private int id;
    private int userId;

    private double subtotal;          // total price of items
    private double shippingFee;       // auto-calculated
    private double totalAmount;       // subtotal + shippingFee

    private int totalCups;            // number of coffee cups ordered (for priority)
    private String status;            // pending, paid, shipped, cancelled

    private String paymentMethod;     // VNPay, COD, etc.
    private String transactionId;     // from VNPay (if using QR payment)
    private String paymentStatus;     // success, failed, processing

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // List of order items inside this order
    private List<OrderItem> orderItems;
    private String customerName;

    public Order() {}

    public Order(int id, int userId, double subtotal, double shippingFee, double totalAmount,
                 int totalCups, String status, String paymentMethod, String transactionId,
                 String paymentStatus, LocalDateTime createdAt, LocalDateTime updatedAt) {

        this.id = id;
        this.userId = userId;
        this.subtotal = subtotal;
        this.shippingFee = shippingFee;
        this.totalAmount = totalAmount;
        this.totalCups = totalCups;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.transactionId = transactionId;
        this.paymentStatus = paymentStatus;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // ==================== GETTERS & SETTERS ====================

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(double shippingFee) {
        this.shippingFee = shippingFee;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getTotalCups() {
        return totalCups;
    }

    public void setTotalCups(int totalCups) {
        this.totalCups = totalCups;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }
    public String getCustomerName() { 
    	return customerName;
    }
    public void setCustomerName(String customerName) { 
    	this.customerName = customerName;
    }
}