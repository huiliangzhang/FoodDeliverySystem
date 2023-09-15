package com.study.fooddelivery.implementation;

import com.study.fooddelivery.service.KafkaService;
import com.study.fooddelivery.service.NotifyService;

public class NotifyServiceImpl implements NotifyService {

    @Override
    public void sendNotice() {
        KafkaService kafkaService = new KafkaServiceImpl();

        while(true) {
            Object message = kafkaService.consume();
            if(message == null) {
                //sleep
            }
            else {

                // send out email, sms, push notification
                System.out.println(message);

            }

        }


    }
}
