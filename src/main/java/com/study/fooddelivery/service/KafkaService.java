package com.study.fooddelivery.service;

import com.study.fooddelivery.entity.Order;

public interface KafkaService {

    public void produce(Object message);
    public Object consume();

}
