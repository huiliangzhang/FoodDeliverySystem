package com.study.fooddelivery.service;

import com.study.fooddelivery.implementation.OrderServiceImpl;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

import com.study.fooddelivery.entity.Order;
import com.study.fooddelivery.entity.OrderItem;

import java.util.ArrayList;
import java.util.List;

class OrderServiceImplTest {

    OrderService tester;
    Order testOrder_good;
    Order testOrder_priceNotMatching;
    @BeforeEach
    void setUp() {
        tester = new OrderServiceImpl();

        testOrder_good = new Order();
        List<OrderItem> items = new ArrayList<OrderItem>();
        OrderItem item1 = new OrderItem();
        items.add(item1);
        item1.setPrice(10.5F);
        item1.setQuantity(3);
        OrderItem item2 = new OrderItem();
        items.add(item2);
        item2.setPrice(12.5F);
        item2.setQuantity(1);
        testOrder_good.setOrderItems(items);
        testOrder_good.setPrice(44F);

        // testOrder_priceNotMatching is having a not matching total price
        testOrder_priceNotMatching = new Order();
        testOrder_priceNotMatching.setOrderItems(items);
        testOrder_priceNotMatching.setPrice(45F);
    }

    @Test
    void order_good() {
        Assertions.assertDoesNotThrow(() -> tester.order(testOrder_good));
    }

    @Test
    void order_priceNotMatching() {
        Exception exception = Assertions.assertThrows(Exception.class, () -> {
            tester.order(testOrder_priceNotMatching);
        });
        Assertions.assertNotNull(exception);
        Assertions.assertEquals("Price is not matching", exception.getMessage());
    }

    @Test
    void computeTotalPrice() {
        Assertions.assertEquals(44, tester.computeTotalPrice(testOrder_good));
        Assertions.assertEquals(44, tester.computeTotalPrice(testOrder_priceNotMatching));
    }
}