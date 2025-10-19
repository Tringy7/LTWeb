-- SCHEMA.SQL
-- Cấu trúc các bảng trong database shop

CREATE TABLE `cart_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` double DEFAULT NULL,
  `quantity` bigint DEFAULT NULL,
  `size` varchar(255) DEFAULT NULL,
  `cart_id` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `voucher_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKkcochhsa891wv0s9wrtf36wgt` (`cart_id`),
  KEY `FK9rlic3aynl3g75jvedkx84lhv` (`product_id`),
  KEY `FKkx27uvqb5v4y79f0qplehj951` (`voucher_id`),
  CONSTRAINT `FK9rlic3aynl3g75jvedkx84lhv` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKkcochhsa891wv0s9wrtf36wgt` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`),
  CONSTRAINT `FKkx27uvqb5v4y79f0qplehj951` FOREIGN KEY (`voucher_id`) REFERENCES `voucher` (`id`)
);

CREATE TABLE `carts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `total_price` double DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK64t7ox312pqal3p7fg9o503c2` (`user_id`),
  CONSTRAINT `FKb5o626f86h46m4s7ms6ginnop` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

CREATE TABLE `commissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(15,2) NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `percent` decimal(5,2) DEFAULT NULL,
  `period_end` date NOT NULL,
  `period_start` date NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `total_revenue` decimal(15,2) NOT NULL,
  `shop_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKachi3xm2onm9x8222ttitnc6` (`shop_id`),
  CONSTRAINT `FKachi3xm2onm9x8222ttitnc6` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`)
);

CREATE TABLE `order_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `price` double DEFAULT NULL,
  `quantity` bigint DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  `shop_id` bigint NOT NULL,
  `voucher_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKjyu2qbqt8gnvno9oe9j2s2ldk` (`order_id`),
  KEY `FK4q98utpd73imf4yhttm3w0eax` (`product_id`),
  KEY `FKqx9qmi9pb7q729iq28cmuybwp` (`shop_id`),
  KEY `FKkja29w7ntp6p3tk0gglggxt37` (`voucher_id`),
  CONSTRAINT `FK4q98utpd73imf4yhttm3w0eax` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `FKjyu2qbqt8gnvno9oe9j2s2ldk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  CONSTRAINT `FKkja29w7ntp6p3tk0gglggxt37` FOREIGN KEY (`voucher_id`) REFERENCES `voucher` (`id`),
  CONSTRAINT `FKqx9qmi9pb7q729iq28cmuybwp` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`)
);

CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `total_price` double DEFAULT NULL,
  `voucher_code` varchar(50) DEFAULT NULL,
  `address_id` bigint DEFAULT NULL,
  `shop_id` bigint DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKebxbj09m4a87s8na3lr86xnf4` (`address_id`),
  KEY `FK21gttsw5evi5bbsvleui69d7r` (`shop_id`),
  KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`),
  CONSTRAINT `FK21gttsw5evi5bbsvleui69d7r` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`),
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKebxbj09m4a87s8na3lr86xnf4` FOREIGN KEY (`address_id`) REFERENCES `user_addresses` (`id`)
);

CREATE TABLE `product_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `quantity` bigint DEFAULT NULL,
  `size` varchar(50) DEFAULT NULL,
  `sold` bigint DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKkjg5lmvxecaopqrai3u0v8j3i` (`product_id`),
  CONSTRAINT `FKkjg5lmvxecaopqrai3u0v8j3i` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
);

CREATE TABLE `products` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `brand` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `detail_desc` text,
  `gender` varchar(50) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `price` double NOT NULL,
  `shop_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7kp8sbhxboponhx3lxqtmkcoj` (`shop_id`),
  CONSTRAINT `FK7kp8sbhxboponhx3lxqtmkcoj` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`)
);

CREATE TABLE `reviews` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `message` varchar(1000) DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `product_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpl51cejpw4gy5swfar8br9ngi` (`product_id`),
  KEY `FKcgy7qjc1r99dp117y9en6lxye` (`user_id`),
  CONSTRAINT `FKcgy7qjc1r99dp117y9en6lxye` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKpl51cejpw4gy5swfar8br9ngi` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`)
);

CREATE TABLE `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `shops` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL,
  `shop_name` varchar(255) NOT NULL,
  `status` varchar(50) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKfrcvw4bjeifsxtwi7udccb03u` (`user_id`),
  CONSTRAINT `FK34po7mmli7wotimo70r6640ap` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

CREATE TABLE `user_addresses` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `note` text,
  `receiver_address` varchar(500) DEFAULT NULL,
  `receiver_name` varchar(255) DEFAULT NULL,
  `receiver_phone` varchar(50) DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKq52s2takhsu9yxyodxujt8fpj` (`user_id`),
  CONSTRAINT `FKn2fisxyyu3l9wlch3ve2nocgp` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

CREATE TABLE `user_voucher` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` bit(1) DEFAULT NULL,
  `user_id` bigint NOT NULL,
  `voucher_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqbre9r4sb85kdd0q1d9fa8c9m` (`user_id`),
  KEY `FK5llb4x2ixiwa75csgei7hbl5r` (`voucher_id`),
  CONSTRAINT `FK5llb4x2ixiwa75csgei7hbl5r` FOREIGN KEY (`voucher_id`) REFERENCES `voucher` (`id`),
  CONSTRAINT `FKqbre9r4sb85kdd0q1d9fa8c9m` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
);

CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(50) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK6dotkott2kjsp8vw4d0m25fb7` (`email`),
  KEY `FKp56c1712k691lhsyewcssf40f` (`role_id`),
  CONSTRAINT `FKp56c1712k691lhsyewcssf40f` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
);

CREATE TABLE `voucher` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(50) DEFAULT NULL,
  `discount_percent` double DEFAULT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `min_price` double DEFAULT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `shop_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKpvh1lqheshnjoekevvwla03xn` (`code`),
  KEY `FK88xfgegvk0oxtbem16bo4vusu` (`shop_id`),
  CONSTRAINT `FK88xfgegvk0oxtbem16bo4vusu` FOREIGN KEY (`shop_id`) REFERENCES `shops` (`id`)
);
