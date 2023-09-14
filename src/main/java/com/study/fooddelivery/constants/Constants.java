package com.study.fooddelivery.constants;


public class Constants {

    public enum OrderStatus {
        CANCELED  (-2),
        DELETED  (-1),
        INCART  (1),
        CONFIRMED  (2),
        CHARGEISSUED  (103),
        CHARGED  (104),
        COMPLETED(200),
        ;

        private final int code;

        OrderStatus(int code) {
            this.code = code;
        }

        public int getCode() {
            return this.code;
        }
    }

    public enum BillingStatus {
        FAILED  (-3),
        CANCELED  (-2),
        DELETED  (-1),
        INITIALIZED  (1),
        CHARGED  (200),

        INDISTRIBUTION (301),
        DISTRIUBTED(400)
        ;

        private final int code;

        BillingStatus(int code) {
            this.code = code;
        }

        public int getCode() {
            return this.code;
        }
    }


}
