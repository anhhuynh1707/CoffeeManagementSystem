package util;

public final class OrderStatus {
    private OrderStatus(){}

    public static final String PENDING = "pending";
    public static final String CONFIRMED = "confirmed";
    public static final String PREPARING = "preparing";
    public static final String DELIVERING = "delivering";   
    public static final String COMPLETED = "completed";
    public static final String CANCELLED = "cancelled";
}
