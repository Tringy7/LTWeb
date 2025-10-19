-- DATA.SQL
-- Dữ liệu khởi tạo cho database shop

INSERT INTO `carts` VALUES (1,1520000,2),(2,1250000,3);

INSERT INTO `commissions` VALUES 
(1,68400.00,'2025-02-01 10:00:00.000000',5.00,'2025-01-31','2025-01-01','Paid',1368000.00,1),
(2,0.00,'2025-03-01 10:00:00.000000',5.00,'2025-02-28','2025-02-01','Pending',0.00,1),
(3,56000.00,'2025-02-01 10:00:00.000000',5.00,'2025-01-31','2025-01-01','Paid',1120000.00,2),
(4,36000.00,'2025-03-01 10:00:00.000000',5.00,'2025-02-28','2025-02-01','Pending',720000.00,2);

INSERT INTO `product_detail` VALUES
(1,120,'M',30,1),(2,100,'L',25,1),(3,80,'XL',15,1),(4,110,'M',40,2),(5,90,'L',35,2),
(6,95,'XL',50,3),(7,75,'XXL',20,3),(8,110,'M',28,4),(9,95,'L',22,4),
(10,70,'S',18,5),(11,85,'M',32,5),(12,65,'L',25,5),
(13,80,'S',40,6),(14,70,'M',30,6),
(15,100,'M',35,7),(16,90,'L',28,7),(17,60,'X',22,8),
(18,120,'L',45,9),(19,100,'XL',38,9),(20,105,'M',30,10),(21,95,'L',25,10),
(22,90,'M',40,11),(23,85,'L',35,11),(24,110,'M',50,12),(25,95,'L',42,12),
(26,75,'X',28,13),(27,90,'M',45,14),(28,80,'L',35,14),
(29,65,'M',30,15),(30,60,'L',25,15),(31,85,'S',38,16),(32,80,'M',32,16),
(33,100,'M',48,17),(34,90,'L',40,17),(35,125,'M',55,18),(36,110,'L',45,18),
(37,105,'M',52,19),(38,95,'L',40,19);

INSERT INTO `products` VALUES 
(1,'N&M','Áo thun','Trắng','Áo thun nam chất liệu cotton 100%, thoáng mát','Nam','aothun_trang.jpg','Áo thun trơn nam cotton',250000,1),
(2,'N&M','Áo thun','Đen','Áo thun cổ tròn basic, dễ phối đồ','Nam','aothun_den.jpg','Áo thun cổ tròn',260000,1),
(3,'N&M','Áo thun','Be','Form rộng trẻ trung, unisex','Unisex','aothun_be.jpg','Áo thun tay lỡ oversize',270000,1),
(4,'N&M','Áo polo','Xanh','Polo kẻ sọc vải cotton lạnh','Nam','polo_xanh.jpg','Áo polo nam kẻ sọc',320000,1),
(5,'Zara','Quần jean','Xanh nhạt','Jean nữ co giãn, ôm dáng, thoải mái','Nữ','jean_skinny.jpg','Quần jean nữ skinny',450000,2),
(6,'Zara','Quần short','Xanh','Quần short jean năng động, phù hợp mùa hè','Nữ','jean_short.jpg','Quần short jean nữ',350000,2),
(7,'Zara','Áo sơ mi','Trắng','Áo sơ mi công sở thanh lịch','Nữ','sominu_trang.jpg','Áo sơ mi trắng nữ',400000,2),
(8,'Zara','Váy','Hồng nhạt','Váy dáng dài chất liệu mềm nhẹ, dễ mặc','Nữ','vay_hoa.jpg','Váy hoa dáng dài',550000,2),
(9,'Uniqlo','Áo khoác','Xám','Chống gió nhẹ, gấp gọn dễ mang theo','Nam','aokhoac_xam.jpg','Áo khoác gió nam',700000,1),
(10,'Uniqlo','Áo sơ mi','Đỏ đen','Chất vải mịn, thích hợp mặc đi chơi','Nam','somi_caro.jpg','Áo sơ mi caro nam',390000,1),
(11,'Uniqlo','Quần dài','Be','Chất vải thoáng, phù hợp đi làm','Nam','kaki_be.jpg','Quần kaki nam',420000,1),
(12,'Uniqlo','Áo hoodie','Xanh navy','Áo hoodie trẻ trung, giữ ấm tốt','Nam','hoodie_navy.jpg','Áo hoodie nam',550000,1),
(13,'H&M','Áo len','Be','Áo len mềm, giữ ấm, form nữ tính','Nữ','len_be.jpg','Áo len cổ lọ nữ',490000,2),
(14,'H&M','Váy','Đen','Váy body công sở, co giãn nhẹ','Nữ','vay_den.jpg','Váy công sở',600000,2),
(15,'H&M','Áo khoác','Xám tro','Blazer form chuẩn, chất vải mịn','Nữ','blazer_xam.jpg','Áo blazer nữ',750000,2),
(16,'Yody','Áo thun','Xanh dương','Thấm hút mồ hôi, co giãn 4 chiều','Nam','aothun_xanh.jpg','Áo thun nam thể thao',290000,1),
(17,'Yody','Quần dài','Đen','Co giãn thoải mái, năng động','Nam','jogger_den.jpg','Quần jogger nam',420000,1),
(18,'Routine','Áo sơ mi','Xanh đậm','Áo caro form nhẹ nhàng, dễ phối','Nữ','sominu_xanh.jpg','Áo sơ mi caro nữ',380000,2),
(19,'Routine','Áo khoác','Kem','Blazer nhẹ, phù hợp mùa thu','Nữ','blazer_kem.jpg','Áo blazer nữ basic',720000,2),
(20,'qưe','eqwe','Xanh','123',NULL,'1760885667611_Screenshot 2025-10-10 104353.png','Nguyễn Hữu Trí',43123,1);

INSERT INTO `reviews` VALUES 
(1,'2025-01-20 16:30:00.000000','Áo thun cotton của N&M rất mát...',5,1,2),
(2,'2025-01-21 10:15:00.000000','Polo mặc rất đẹp...',4,4,2),
(3,'2025-01-22 14:20:00.000000','Áo khoác Uniqlo chống gió tốt...',5,9,2);

INSERT INTO `roles` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_USER'),(3,'ROLE_VENDOR');

INSERT INTO `shops` VALUES 
(1,'2024-01-15 10:30:00.000000','Shop chuyên quần áo phong cách đường phố...','UrbanWear','Active',4),
(2,'2024-02-20 14:00:00.000000','Shop thời trang cao cấp...','FashionHub','Active',5);

INSERT INTO `user_addresses` VALUES 
(1,'Giao hàng giờ hành chính','123 Nguyễn Trãi, Quận 1, TP.HCM','Tran Thi B','0903333444',2),
(2,'Gọi trước khi giao','789 Hai Bà Trưng, Ninh Kiều, Cần Thơ','Pham Thi D','0907777888',3),
(3,NULL,'456 Lê Duẩn, Hải Châu, Đà Nẵng','Le Van C','0905555666',4),
(4,'Giao cuối tuần','321 Lê Lợi, Huế','Nguyen Van E','0909999000',5);

INSERT INTO `user_voucher` VALUES 
(1,_binary '',2,1),(2,_binary '',2,2),(3,_binary '',3,3),(4,_binary '',3,4),
(5,_binary '',4,5),(6,_binary '',4,6),(7,_binary '',5,7),(8,_binary '',5,8);

INSERT INTO `users` VALUES 
(1,'Hà Nội','admin@gmail.com','Nguyen Van A','admin.jpg','$2a$10$6vakvPun5F6U9HAgHL3MWOfh1OuJjNqroSKIQQvgTjr4ooJDrZMTe','0901111222',1),
(2,'TP.HCM','user1@gmail.com','Tran Thi B','user1.jpg','$2a$10$6vakvPun5F6U9HAgHL3MWOfh1OuJjNqroSKIQQvgTjr4ooJDrZMTe','0903333444',2),
(3,'Cần Thơ','user2@gmail.com','Pham Thi D','user2.jpg','$2a$10$6vakvPun5F6U9HAgHL3MWOfh1OuJjNqroSKIQQvgTjr4ooJDrZMTe','0907777888',2),
(4,'Đà Nẵng','UrbanWear@gmail.com','Le Van C','vendor1.jpg','$2a$10$6vakvPun5F6U9HAgHL3MWOfh1OuJjNqroSKIQQvgTjr4ooJDrZMTe','0905555666',3),
(5,'Huế','FashionHub@gmail.com','Nguyen Van E','vendor2.jpg','$2a$10$6vakvPun5F6U9HAgHL3MWOfh1OuJjNqroSKIQQvgTjr4ooJDrZMTe','0909999000',3);

INSERT INTO `voucher` VALUES 
(1, '464367', 10, '2025-12-31 23:59:59.000000', 300000, '2025-01-01 00:00:00.000000', 'True', 1),
(2, '865475', 15, '2025-06-30 23:59:59.000000', 500000, '2025-01-01 00:00:00.000000', 'True', 1),
(3, '321353', 20, '2025-01-31 23:59:59.000000', 600000, '2025-01-01 00:00:00.000000', 'True', 1),
(4, '321533', 12, '2025-08-31 23:59:59.000000', 400000, '2025-06-01 00:00:00.000000', 'True', 1),
(5, '123456', 20, '2025-12-31 23:59:59.000000', 700000, '2025-01-01 00:00:00.000000', 'True', 2),
(6, '456879', 15, '2025-06-30 23:59:59.000000', 500000, '2025-01-01 00:00:00.000000', 'True', 2),
(7, '563124', 8, '2025-03-31 23:59:59.000000', 300000, '2025-01-01 00:00:00.000000', 'True', 2),
(8, '789535', 18, '2025-11-30 23:59:59.000000', 800000, '2025-09-01 00:00:00.000000', 'True', 2);