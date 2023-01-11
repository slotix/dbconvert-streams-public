CREATE DATABASE `source`;
USE `source`;

CREATE TABLE `product` (
  `product_id` int NOT NULL,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`product_id`)
);

CREATE TABLE `country` (
  `country_id` int NOT NULL,
  `country_name` varchar(450) NOT NULL,
  PRIMARY KEY (`country_id`)
);

CREATE TABLE `city` (
  `city_id` int NOT NULL,
  `city_name` varchar(450) NOT NULL,
  `country_id` int NOT NULL,
  PRIMARY KEY (`city_id`)
);

CREATE TABLE `store` (
  `store_id` int NOT NULL,
  `name` varchar(250) NOT NULL,
  `city_id` int NOT NULL,
  PRIMARY KEY (`store_id`)
);

CREATE TABLE `users` (
  `user_id` int NOT NULL,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`user_id`)
);

CREATE TABLE `status_name` (
  `status_name_id` int NOT NULL,
  `status_name` varchar(450) NOT NULL,
  PRIMARY KEY (`status_name_id`)
);

CREATE TABLE `sale` (
  `sale_id` varchar(200) NOT NULL,
  `amount` decimal(20,3) NOT NULL,
  `date_sale` datetime DEFAULT NULL,
  `product_id` int NOT NULL,
  `user_id` int NOT NULL,
  `store_id` int NOT NULL,
  PRIMARY KEY (`sale_id`)
);

CREATE TABLE `order_status` (
  `order_status_id` varchar(200) NOT NULL,
  `update_at` datetime DEFAULT NULL,
  `sale_id` varchar(200) NOT NULL,
  `status_name_id` int NOT NULL,
  PRIMARY KEY (`order_status_id`)
);
