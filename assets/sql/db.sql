CREATE DATABASE `foodDelivery` /*!40100 DEFAULT CHARACTER SET utf8 */;

CREATE TABLE `address` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '-1: deleted\n1: valid',
  `version` int(11) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `country` varchar(15) DEFAULT NULL,
  `state` varchar(15) DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f1_idx` (`customer_id`),
  CONSTRAINT `f1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `billing` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `restaurent_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `price` float DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '-2: cancelled\n-1: deleted\n1: valid\n2: confirmed\n3:making\n4:ready\n5:picked\n',
  `version` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f1_billing_customer_idx` (`customer_id`),
  KEY `f1_billing_restaurant_idx` (`restaurent_id`),
  CONSTRAINT `f1_billing_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `f1_billing_restaurant` FOREIGN KEY (`restaurent_id`) REFERENCES `restaurant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `customer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '-1: deleted\n1: valid',
  `version` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint(20) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `description` text,
  `image_urls` text,
  `price` float DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '-1: deleted\n1: valid',
  `selections` text COMMENT 'JSON object with selections like size/flavor and different prices',
  `version` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_menu_restaurant_idx` (`restaurant_id`),
  CONSTRAINT `f_menu_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `menu_group` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_id` bigint(20) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `description` text,
  `image_urls` text,
  `price` float DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '-1: deleted\n1: valid',
  `selections` text COMMENT 'JSON object with selections like size/flavor and different prices',
  `version` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_menugroup_menu_idx` (`menu_id`),
  CONSTRAINT `f_menugroup_menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `menu_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `menu_group_id` bigint(20) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `description` text,
  `image_urls` text,
  `price` float DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '-1: deleted\n1: valid',
  `selections` text COMMENT 'JSON object with selections like size/flavor and different prices',
  `version` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_menu_item_group_idx` (`menu_group_id`),
  CONSTRAINT `f_menu_item_group` FOREIGN KEY (`menu_group_id`) REFERENCES `menu_group` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `notification` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL,
  `restaurant_id` bigint(20) DEFAULT NULL,
  `customer_id` bigint(20) NOT NULL,
  `audience` enum('restaurant','customer') DEFAULT NULL,
  `title` varchar(200) DEFAULT NULL,
  `content` text,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '-2: cancelled\n-1: deleted\n1: valid\n2: confirmed\n3:making\n4:ready\n5:picked\n',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_notification_order_idx` (`order_id`),
  KEY `f_notification_restaurant_idx` (`restaurant_id`),
  KEY `f_notification_customer_idx` (`customer_id`),
  CONSTRAINT `f_notification_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `f_notification_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `f_notification_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `open_hour` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `restaurant_id` bigint(20) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '-1: deleted\n1: valid',
  `weekday` int(11) DEFAULT NULL,
  `start_time` int(11) DEFAULT NULL,
  `end_time` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_openhour_restaurant_idx` (`restaurant_id`),
  CONSTRAINT `f_openhour_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `restaurant_id` bigint(20) NOT NULL,
  `customer_id` bigint(20) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address_id` bigint(20) DEFAULT NULL,
  `pickup_time` timestamp NULL DEFAULT NULL,
  `requirements` text,
  `description` text,
  `discount` float DEFAULT NULL,
  `price` float DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '-2: cancelled\n-1: deleted\n1: valid\n2: confirmed\n3:making\n4:ready\n5:picked\n',
  `version` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_order_customer_idx` (`customer_id`),
  KEY `f_order_restaurant_idx` (`restaurant_id`),
  KEY `f_order_address_idx` (`address_id`),
  CONSTRAINT `f_order_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `f_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `f_order_restaurant` FOREIGN KEY (`restaurant_id`) REFERENCES `restaurant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) DEFAULT NULL,
  `menu_item_id` bigint(20) NOT NULL,
  `selections` text,
  `price` float DEFAULT NULL,
  `discount` float DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT '1' COMMENT '-1: deleted\n1: valid',
  `final_price` float DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_item_order_idx` (`order_id`),
  KEY `f_item_menu_idx` (`menu_item_id`),
  CONSTRAINT `f_item_menu` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_item` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `f_item_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `restaurant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `type` varchar(45) NOT NULL,
  `chain_id` int(11) DEFAULT NULL,
  `country` varchar(15) DEFAULT NULL,
  `state` varchar(15) DEFAULT NULL,
  `city` varchar(15) DEFAULT NULL,
  `address` varchar(45) DEFAULT NULL,
  `zipcode` varchar(10) DEFAULT NULL,
  `coordinate` point DEFAULT NULL,
  `timezone` varchar(15) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `cuisine` varchar(45) DEFAULT NULL,
  `description` text,
  `image_urls` text,
  `version` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT '1' COMMENT '-1: deleted\n1: valid',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `special_day` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `restaurent_id` bigint(20) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '-1: deleted\n1: valid',
  `date` date DEFAULT NULL,
  `start_time` int(11) DEFAULT NULL,
  `end_time` int(11) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `created_by` varchar(30) DEFAULT NULL,
  `modified_by` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `f_special_restaurant_idx` (`restaurent_id`),
  CONSTRAINT `f_special_restaurant` FOREIGN KEY (`restaurent_id`) REFERENCES `restaurant` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
