### 1. Cấu trúc dự án (tương tự mẫu Uteshop)

```
LTWeb/ (fashion_shop)
│── .git/
│── pom.xml                    # Quản lý dependencies Maven (packaging = war)
│── mvnw, mvnw.cmd             # Maven Wrapper
│── src/
│   ├── main/
│   │   ├── java/com/shop/shop/
│   │   │   ├── config/        # Cấu hình Spring, Security, email, jwt, vnpay
│   │   │   ├── controller/    # Controller (client, admin, shipper, vendor)
│   │   │   ├── domain/        # Entity / Model (User, Order, Product...)
│   │   │   ├── dto/           # DTOs
│   │   │   ├── mapper/        # Mapstruct/ModelMapper helpers
│   │   │   ├── repository/    # Spring Data JPA repositories
│   │   │   ├── service/       # Service interfaces
│   │   │   ├── service/impl/  # Service implementations
│   │   │   └── util/          # Helpers (UserAfterLogin, util functions)
│   │   ├── resources/
│   │   │   ├── application.properties  # Main config (DB, vnpay, jwt...)
│   │   │   └── fonts/                    
│   │   └── webapp/
│   │       ├── resources/                # static assets (admin, client folders)
│   │       │   ├── admin/
│   │       │   └── client/
│   │       └── WEB-INF/
│   │           ├── views/                 # JSP views
│   │           └── web.xml
│   └── test/                             # Unit tests (DAO, Service)
│
└── db/                                   # SQL scripts / seed data
```

### 2. Mô tả các thư mục (như bạn yêu cầu)

- `controller/` → Servlet / Controller nhận request từ client, gọi service.
- `repository/` (dao) → Tầng truy xuất DB (Spring Data JPA).
- `domain/` (model) → entity ánh xạ bảng DB.
- `service/` + `service/impl/` → Xử lý logic nghiệp vụ (gọi repository/dao).
- `util/` → Helper (ví dụ: `UserAfterLogin`, hash password, validate...).
- `webapp/WEB-INF/views/` → JSP pages.
- `resources/` → `application.properties`, font, các file cấu hình (vnpay, jwt).
- `assets/` (dưới webapp/resources) → CSS, JS, images.
- `test/` → JUnit test cho repository/service.

### 3. Yêu cầu & môi trường

- Java 22
- Maven (sử dụng `mvnw.cmd` trên Windows)
- MySQL 

### 4. Cài đặt 

1. Tạo database (MySQL) theo `application.properties`.

2. Sửa `src/main/resources/application.properties` cho phù hợp (DB url/username/password, VNPAY, JWT secret).

3. Chạy project (PowerShell):

```powershell
.\mvnw.cmd clean package -DskipTests
java -jar target\Design-0.0.1-SNAPSHOT.war
```

Hoặc chạy trực tiếp (dev):

```powershell
.\mvnw.cmd spring-boot:run
```

### 5. Hướng dẫn thanh toán VNPAY (như mẫu)

- Tại trang thanh toán chọn VNPAY → chọn phương thức thẻ nội địa.
- Dùng thông tin thẻ giả lập (sandbox) theo môi trường dev (xem `application.properties` cho `vnpay.*` keys).

### 6. Chức năng / Target (tương tự mẫu Uteshop)

Ứng dụng hỗ trợ các role: Guest, User, Vendor, Shipper, Admin.

- Guest: xem sản phẩm, tìm kiếm, xem chi tiết.
- User: quản lý profile, nhiều địa chỉ nhận hàng, giỏ hàng lưu DB, đặt hàng, thanh toán (COD, VNPAY,...), đánh giá.
- Vendor: quản lý shop, sản phẩm, đơn hàng, khuyến mãi.
- Shipper: nhận/giao đơn, cập nhật trạng thái.
- Admin: quản lý người dùng, shop, sản phẩm, khuyến mãi, vận chuyển.

Các điểm thực hiện/đã có sẵn: VNPAY sandbox, xuất báo cáo PDF, WebSocket liên lạc, đăng nhập Google.

### 7. Phân công (ví dụ từ mẫu)

- Bạn có thể giữ phần mô tả công việc nhóm như mẫu, hoặc cập nhật theo team hiện tại.

### 8. Thực hành an toàn & vận hành

- KHÔNG commit secrets (JWT secret, VNPAY, DB password). Sử dụng `application.properties.sample` và env vars.
- Tránh `spring.jpa.hibernate.ddl-auto=create` trên production.

### 9. Thêm đề xuất (tôi có thể giúp)

- Tạo `application.properties.sample` (với placeholder) và chuyển secrets ra biến môi trường.
- Viết `docker-compose.yml` để chạy app + MySQL.
- Thêm script seed SQL trong `db/` và README hướng dẫn khôi phục DB.
- Viết hướng dẫn debug cho IntelliJ / VS Code.

---

Nếu bạn muốn, tôi sẽ cập nhật file README hiện tại với các thay đổi trên (đã thực hiện) và có thể tiếp tục tạo:

- `application.properties.sample`
- `db/seed.sql` (ví dụ dữ liệu)
- `docker-compose.yml`

Chọn mục bạn muốn mình làm tiếp theo.
