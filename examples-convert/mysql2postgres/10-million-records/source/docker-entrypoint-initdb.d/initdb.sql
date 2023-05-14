CREATE DATABASE `source`;
USE `source`;
CREATE TABLE IF NOT EXISTS `products` (
`id` BIGINT NOT NULL AUTO_INCREMENT,
`name` VARCHAR(255) NOT NULL,
`price` DECIMAL(10, 2) NOT NULL,
`weight` DOUBLE NULL,
`created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
