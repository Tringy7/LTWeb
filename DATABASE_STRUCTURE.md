# Cấu trúc Database - Shop Management System

## Tổng quan

Database được thiết kế cho hệ thống quản lý shop bán hàng trực tuyến với các chức năng:
- Quản lý người dùng và phân quyền
- Quản lý shop/vendor
- Quản lý sản phẩm và kho
- Giỏ hàng và đặt hàng
- Voucher và khuyến mãi
- Đánh giá sản phẩm
- Tính hoa hồng cho shop

## Danh sách các bảng

### 1. **Roles** - Quản lý vai trò
- `id`: Primary Key
- `name`: Tên vai trò (ADMIN, VENDOR, USER)

**Quan hệ:**
- 1 Role có nhiều Users (1:N)

---

### 2. **Users** - Quản lý người dùng
- `id`: Primary Key
- `fullName`: Họ và tên
- `email`: Email (unique, dùng để đăng nhập)
- `password`: Mật khẩu (đã hash)
- `phone`: Số điện thoại
- `address`: Địa chỉ
- `image`: Ảnh đại diện
- `roleId`: Foreign Key tới Roles

**Quan hệ:**
- N Users thuộc 1 Role (N:1)
- 1 User có 1 Cart (1:1)
- 1 User có 1 UserAddress (1:1)
- 1 User có nhiều Orders (1:N)
- 1 User có nhiều UserVouchers (1:N)
- 1 User có nhiều Reviews (1:N)
- 1 User (VENDOR) có nhiều Shops (1:N)

---

### 3. **User_Addresses** - Địa chỉ giao hàng
- `id`: Primary Key
- `userId`: Foreign Key tới Users (unique)
- `receiverName`: Tên người nhận
- `receiverPhone`: SĐT người nhận
- `receiverAddress`: Địa chỉ giao hàng
- `note`: Ghi chú

**Quan hệ:**
- N UserAddresses thuộc 1 User (N:1)
- 1 UserAddress có thể được dùng cho nhiều Orders (1:N)

---

### 4. **Shops** - Quản lý cửa hàng
- `id`: Primary Key
- `userId`: Foreign Key tới Users (người quản lý shop)
- `shopName`: Tên shop
- `description`: Mô tả
- `status`: Trạng thái (Active/Inactive)
- `createdAt`: Ngày tạo

**Quan hệ:**
- N Shops thuộc 1 User (N:1)
- 1 Shop có nhiều Products (1:N)
- 1 Shop có nhiều Vouchers (1:N)
- 1 Shop có nhiều Orders (1:N)
- 1 Shop có nhiều Commissions (1:N)

---

### 5. **Products** - Quản lý sản phẩm
- `id`: Primary Key
- `shopId`: Foreign Key tới Shops
- `name`: Tên sản phẩm
- `brand`: Thương hiệu
- `color`: Màu sắc
- `detailDesc`: Mô tả chi tiết
- `image`: Ảnh sản phẩm
- `price`: Giá
- `category`: Danh mục
- `gender`: Giới tính (Nam/Nữ/Unisex)

**Quan hệ:**
- N Products thuộc 1 Shop (N:1)
- 1 Product có nhiều ProductDetails (1:N)
- 1 Product có nhiều Reviews (1:N)
- 1 Product có nhiều CartDetails (1:N)
- 1 Product có nhiều OrderDetails (1:N)

---

### 6. **Product_Detail** - Chi tiết kho hàng theo size
- `id`: Primary Key
- `productId`: Foreign Key tới Products
- `size`: Kích thước (S, M, L, XL, etc.)
- `quantity`: Số lượng tồn kho
- `sold`: Số lượng đã bán

**Quan hệ:**
- N ProductDetails thuộc 1 Product (N:1)

---

### 7. **Reviews** - Đánh giá sản phẩm
- `id`: Primary Key
- `productId`: Foreign Key tới Products
- `userId`: Foreign Key tới Users
- `message`: Nội dung đánh giá
- `rating`: Điểm đánh giá (1-5 sao)
- `createdAt`: Ngày đánh giá

**Quan hệ:**
- N Reviews thuộc 1 Product (N:1)
- N Reviews được viết bởi 1 User (N:1)

---

### 8. **voucher** - Mã giảm giá
- `id`: Primary Key
- `code`: Mã voucher (unique)
- `discountPercent`: Phần trăm giảm giá
- `startDate`: Ngày bắt đầu
- `endDate`: Ngày kết thúc
- `status`: Trạng thái (active/inactive)
- `shop_id`: Foreign Key tới Shops

**Quan hệ:**
- N Vouchers thuộc 1 Shop (N:1)
- 1 Voucher có nhiều UserVouchers (1:N)
- 1 Voucher có thể được dùng trong nhiều CartDetails (1:N)
- 1 Voucher có thể được dùng trong nhiều OrderDetails (1:N)

---

### 9. **user_voucher** - Voucher của người dùng
- `id`: Primary Key
- `user_id`: Foreign Key tới Users
- `voucher_id`: Foreign Key tới voucher
- `status`: Trạng thái đã sử dụng (True/False)

**Quan hệ:**
- N UserVouchers thuộc 1 User (N:1)
- N UserVouchers thuộc 1 Voucher (N:1)

---

### 10. **Carts** - Giỏ hàng
- `id`: Primary Key
- `userId`: Foreign Key tới Users (unique)
- `totalPrice`: Tổng giá trị giỏ hàng

**Quan hệ:**
- 1 Cart thuộc 1 User (1:1)
- 1 Cart có nhiều CartDetails (1:N)

---

### 11. **Cart_Details** - Chi tiết giỏ hàng
- `id`: Primary Key
- `cartId`: Foreign Key tới Carts
- `productId`: Foreign Key tới Products
- `quantity`: Số lượng
- `size`: Kích thước
- `price`: Giá
- `voucherId`: Foreign Key tới voucher

**Quan hệ:**
- N CartDetails thuộc 1 Cart (N:1)
- N CartDetails thuộc 1 Product (N:1)
- N CartDetails có thể dùng 1 Voucher (N:1)

---

### 12. **Orders** - Đơn hàng
- `id`: Primary Key
- `userId`: Foreign Key tới Users
- `addressId`: Foreign Key tới User_Addresses
- `createdAt`: Ngày tạo đơn
- `paymentMethod`: Phương thức thanh toán
- `status`: Trạng thái (New, Processing, Shipped, Completed, Cancelled)
- `totalPrice`: Tổng giá trị đơn hàng
- `voucherCode`: Mã voucher đã dùng
- `shop_id`: Foreign Key tới Shops

**Quan hệ:**
- N Orders thuộc 1 User (N:1)
- N Orders thuộc 1 UserAddress (N:1)
- N Orders thuộc 1 Shop (N:1)
- 1 Order có nhiều OrderDetails (1:N)

---

### 13. **Order_Details** - Chi tiết đơn hàng
- `id`: Primary Key
- `orderId`: Foreign Key tới Orders
- `productId`: Foreign Key tới Products
- `shopId`: Foreign Key tới Shops
- `quantity`: Số lượng
- `size`: Kích thước
- `price`: Giá
- `voucherId`: Foreign Key tới voucher

**Quan hệ:**
- N OrderDetails thuộc 1 Order (N:1)
- N OrderDetails thuộc 1 Product (N:1)
- N OrderDetails thuộc 1 Shop (N:1)
- N OrderDetails có thể dùng 1 Voucher (N:1)

---

### 14. **commissions** - Hoa hồng của shop
- `id`: Primary Key
- `shop_id`: Foreign Key tới Shops
- `period_start`: Ngày bắt đầu kỳ tính
- `period_end`: Ngày kết thúc kỳ tính
- `total_revenue`: Tổng doanh thu
- `percent`: Phần trăm hoa hồng (mặc định 5%)
- `amount`: Số tiền hoa hồng
- `status`: Trạng thái (pending, paid)
- `created_at`: Ngày tính

**Quan hệ:**
- N Commissions thuộc 1 Shop (N:1)

---

## Sơ đồ quan hệ chính

```
Users (1) ──── (N) Shops (1) ──── (N) Products
  │                   │                  │
  │                   │                  └── (N) Product_Detail
  │                   │                  │
  │                   │                  └── (N) Reviews
  │                   │                  
  │                   ├── (N) Vouchers
  │                   │
  │                   └── (N) Commissions
  │
  ├── (1) Cart (1) ──── (N) Cart_Details
  │
  ├── (1) User_Address
  │
  ├── (N) Orders (1) ──── (N) Order_Details
  │
  └── (N) User_Voucher (N) ──── (1) Voucher
```

## Indexes được tạo

Để tối ưu hiệu năng truy vấn, các indexes sau được tạo:

1. **Users**: email, roleId
2. **Products**: shopId, category, gender, price
3. **Orders**: userId, addressId, shop_id, status, createdAt
4. **Voucher**: code, shop_id, status, dates
5. **Reviews**: productId, userId, rating, createdAt
6. **Commissions**: shop_id, status, period, created_at

## Lưu ý quan trọng

1. **Encoding**: Tất cả tables sử dụng `utf8mb4_unicode_ci` để hỗ trợ Unicode đầy đủ
2. **Engine**: InnoDB để hỗ trợ transactions và foreign keys
3. **ON DELETE**: 
   - CASCADE: Xóa dữ liệu liên quan khi xóa parent
   - SET NULL: Set NULL cho foreign key khi xóa parent
4. **Passwords**: Nên được hash bằng BCrypt trước khi lưu
5. **Decimal**: Sử dụng DECIMAL(15,2) cho tiền tệ và DECIMAL(5,2) cho phần trăm

## Hướng dẫn sử dụng

### Tạo database:
```bash
mysql -u root -p < database_schema.sql
```

### Hoặc trong MySQL:
```sql
SOURCE d:/Document/Project/LTWeb/database_schema.sql;
```

### Cấu hình Spring Boot (application.properties):
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/shop_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
spring.datasource.username=root
spring.datasource.password=your_password
spring.jpa.hibernate.ddl-auto=validate
spring.jpa.show-sql=true
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
```

## Tài khoản mặc định

Script đã tạo sẵn 3 tài khoản:

1. **Admin**
   - Email: admin@shop.com
   - Password: admin123
   - Role: ADMIN

2. **Vendor**
   - Email: vendor@shop.com
   - Password: vendor123
   - Role: VENDOR

3. **User**
   - Email: user@shop.com
   - Password: user123
   - Role: USER

**Lưu ý**: Đổi mật khẩu ngay sau khi cài đặt!
