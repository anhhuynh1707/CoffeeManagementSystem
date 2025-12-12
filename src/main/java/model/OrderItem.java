package model;

public class OrderItem {

    private int itemId;
    private int orderId;
    private int productId;

    private int quantity;
    private double basePrice;
    private double extraPrice;
    private double finalPrice;

    private String milkType;
    private String sugarLevel;
    private String iceLevel;
    private String toppings;
    
    private String productName;
    private String imageUrl;

    public OrderItem() {}

    // ======= GETTERS & SETTERS =======

    public int getItemId() {
        return itemId;
    }
    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }
    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getBasePrice() {
        return basePrice;
    }
    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public double getExtraPrice() {
        return extraPrice;
    }
    public void setExtraPrice(double extraPrice) {
        this.extraPrice = extraPrice;
    }

    public double getFinalPrice() {
        return finalPrice;
    }
    public void setFinalPrice(double finalPrice) {
        this.finalPrice = finalPrice;
    }

    public String getMilkType() {
        return milkType;
    }
    public void setMilkType(String milkType) {
        this.milkType = milkType;
    }

    public String getSugarLevel() {
        return sugarLevel;
    }
    public void setSugarLevel(String sugarLevel) {
        this.sugarLevel = sugarLevel;
    }

    public String getIceLevel() {
        return iceLevel;
    }
    public void setIceLevel(String iceLevel) {
        this.iceLevel = iceLevel;
    }

    public String getToppings() {
        return toppings;
    }
    public void setToppings(String toppings) {
        this.toppings = toppings;
    }
    public String getProductName() {
        return productName;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}