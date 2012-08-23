package org.croteau.jms.domain;


public class Order {

    private String uuid;
    private int customerId;
    private double total;
   
    public Order(String uuid, int customerId, double total){
        this.uuid = uuid;
        this.customerId = customerId;
        this.total = total;
    }
   
    public String getUuid() {
        return uuid;
    }
    public void setUuid(String uuid) {
        this.uuid = uuid;
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