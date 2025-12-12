package model;

import java.time.LocalDateTime;

public class Menu {

    private int id;
    private String name;
    private String description;
    private double price;
    private String imageUrl;
    private String category;      // coffee, tea, milk tea, bakery, etc.
    private String status;        // available, unavailable

    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // EXTRA FIELD FOR CART SYSTEM
    private int quantity;

    public Menu() {}

    public Menu(int id, String name, String description, double price,
                String imageUrl, String category, String status,
                LocalDateTime createdAt, LocalDateTime updatedAt) {

        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.category = category;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;

        this.quantity = 1; // default when item added to cart
    }

    // ==================== GETTERS & SETTERS ====================

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}
