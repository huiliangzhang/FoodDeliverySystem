package com.study.fooddelivery.service;

import com.study.fooddelivery.constants.Constants;
import com.study.fooddelivery.entity.Billing;
import com.study.fooddelivery.entity.Order;
import com.study.fooddelivery.entity.OrderItem;

public interface OrderService {

    public Order order(Order order) throws Exception;

    public float computeTotalPrice(Order order);

}
