package com.study.fooddelivery.entity;

import java.util.List;

public class Billing {
    long orderId;
    float price;
    String transactionId;
    int billingStatus;

    public long getOrderId() {
        return orderId;
    }

    public void setOrderId(long orderId) {
        this.orderId = orderId;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public int getBillingStatus() {
        return billingStatus;
    }

    public void setBillingStatus(int billingStatus) {
        this.billingStatus = billingStatus;
    }
}
