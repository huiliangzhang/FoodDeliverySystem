package com.study.fooddelivery.implementation;

import com.study.fooddelivery.constants.Constants;
import com.study.fooddelivery.entity.Billing;
import com.study.fooddelivery.entity.Order;
import com.study.fooddelivery.entity.OrderItem;
import com.study.fooddelivery.service.KafkaService;
import com.study.fooddelivery.service.OrderService;

public class KafkaServiceImpl implements KafkaService {

    // priorityqueue first first out

    @Override
    public void produce(Object message) {

    }

    @Override
    public Object consume() {
        return null;
    }
}
