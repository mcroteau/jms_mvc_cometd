package org.croteau.jms.domain;


public class Order {

    private int orderId;
    private int customerId;
    private double total;
   
    public Order(int orderId, int customerId, double total){
        this.orderId = orderId;
        this.customerId = customerId;
        this.total = total;
    }
   
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public int getCustomerId() {
        return customerId;
    }
    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }
    public double getTotal() {
        return total;
    }
    public void setTotal(double total) {
        this.total = total;
    }

}