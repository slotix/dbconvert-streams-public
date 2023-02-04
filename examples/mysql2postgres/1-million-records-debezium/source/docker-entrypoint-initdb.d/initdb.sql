CREATE DATABASE `source`;
GRANT ALL PRIVILEGES ON source.* TO 'mysqluser'@'%';

USE `source`;

CREATE TABLE IF NOT EXISTS `products` (
`id` BIGINT NOT NULL,
`name` VARCHAR(255) NOT NULL,
`price` DECIMAL(10, 2) NOT NULL,
`weight` DOUBLE NULL,
`created` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `products` (`id`, `name`, `price`, `weight`) VALUES 
(1, 'Product 1', 19.99, 2.5);
