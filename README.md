## 🧩 Giới thiệu
**Fashion Shop** là ứng dụng web thương mại điện tử mini được phát triển bằng **Spring Boot + JSP/JSTL + Bootstrap + JPA + MySQL + Sitemesh + JWT + WebSocket**, triển khai theo mô hình **MVC**.  
Mục tiêu của dự án là xây dựng nền tảng mua hàng và quản lý sàn thương mại điện tử mini chuyên về quần áo, hỗ trợ nhiều vai trò khác nhau như **Guest, User, Vendor, Shipper, Admin**.

---

## 📁 1. Cấu trúc dự án

```bash
LTWeb/ (fashion_shop)
│── .git/
│── pom.xml               # Quản lý dependencies Maven (packaging = war)
│── mvnw, mvnw.cmd
│── src/
│   ├── main/
│   │   ├── java/com/shop/shop/
│   │   │   ├── config/           # Cấu hình Spring, Security, email, jwt, vnpay
│   │   │   ├── controller/       # Controller (client, admin, shipper, vendor)
│   │   │   ├── domain/           # Entity / Model (User, Order, Product...)
│   │   │   ├── dto/              # DTOs
│   │   │   ├── mapper/           # MapStruct/ModelMapper helpers
│   │   │   ├── repository/       # Spring Data JPA repositories
│   │   │   ├── service/          # Service interfaces
│   │   │   ├── service/impl/     # Service implementations
│   │   │   └── util/             # Helpers (UserAfterLogin, utils, validation)
│   │   ├── resources/
│   │   │   ├── application.properties   # Cấu hình DB, JWT, VNPAY,...
│   │   │   └── fonts/
│   │   └── webapp/
│   │       ├── resources/        # static assets (admin, client)
│   │       │   ├── admin/
│   │       │   └── client/
│   │       └── WEB-INF/
│   │           ├── views/        # JSP pages
│   │           └── web.xml
│   └── test/                     # Unit tests (DAO, Service)
│
└── db/                           # SQL scripts / seed data
```

---

## 📚 2. Mô tả thư mục
- **controller/** → Nhận request từ client, gọi service xử lý.  
- **repository/** → Tầng truy xuất dữ liệu (Spring Data JPA).  
- **domain/** → Lớp entity ánh xạ các bảng trong cơ sở dữ liệu.  
- **service/, service/impl/** → Xử lý logic nghiệp vụ.  
- **util/** → Các tiện ích như hash password, validate, UserAfterLogin,…  
- **webapp/WEB-INF/views/** → Chứa các trang JSP.  
- **resources/** → Chứa `application.properties`, font và file cấu hình.  
- **webapp/resources/** → Chứa file tĩnh (CSS, JS, images).  
- **test/** → Kiểm thử JUnit cho repository và service.  

---

## ⚙️ 3. Yêu cầu môi trường
- **Java:** JDK 22  
- **Maven:** sử dụng `mvnw.cmd` (Windows)  
- **Database:** MySQL  

---

## 🚀 4. Cài đặt và chạy dự án

### 🧱 Bước 1. Tạo database MySQL
Tạo database theo tên được khai báo trong `application.properties`.

### ⚙️ Bước 2. Cấu hình ứng dụng
Mở file `src/main/resources/application.properties` và sửa thông tin:

- spring.datasource.url

- spring.datasource.username

- spring.datasource.password

- vnpay.*, jwt.secret


### 🏃 Bước 3. Build và chạy
**Cách 1 – Build WAR rồi chạy:**
.\mvnw.cmd clean package -DskipTests
java -jar target\Design-0.0.1-SNAPSHOT.war


**Cách 2 – Chạy trực tiếp (dev mode):**
.\mvnw.cmd spring-boot:run


---

## 💳 Hướng dẫn thanh toán VNPAY
- Tại trang thanh toán, chọn **VNPAY → Thẻ nội địa**, sau đó nhập thông tin thẻ giả lập (sandbox).
  - Nhập thông tin thanh toán vào Ngân hàng NCB

Số thẻ 9704198526191432198

Tên chủ thẻ NGUYEN VAN A

Ngày phát hành 07/15

Mật khẩu OTP 123456

- Các cấu hình được đặt trong `application.properties` theo key `vnpay.*`.

---

## 🧠 5. Chức năng hệ thống

Ứng dụng hỗ trợ các vai trò:  **Guest, User, Vendor, Shipper, Admin**

### 👤 Guest
- Xem sản phẩm bán nhiều nhất, xem giới thiệu sản phẩm
- Không thể mua hoặc đánh giá sản phẩm.  

### 👥 User
- Quản lý hồ sơ cá nhân, địa chỉ nhận hàng.
- Xem chi tiết sản phẩm, lưu sản phẩm vào giỏ hàng, đặt hàng sản phẩm
- Tìm kiếm, lọc sản phẩm theo các tiêu chí.  
- Đặt hàng và thanh toán (COD, VNPAY, MOMO).  
- Theo dõi lịch sử đơn hàng theo trạng thái (mới, xác nhận, đang giao, hoàn tất, hủy, hoàn tiền).  
- Thích, bình luận, đánh giá sản phẩm, sử dụng mã giảm giá khi thanh toántoán.  

### 🏪 Vendor (Chủ cửa hàng)
- Có quyền của User.  
- Đăng ký shop, quản lý sản phẩm, đơn hàng, khuyến mãi.  
- Theo dõi doanh thu, hiệu suất bán hàng theo thời gian.  

### 🚚 Shipper
- Nhận và giao đơn hàng được phân công.  
- Cập nhật trạng thái giao hàng.  
- Xem thống kê số lượng đơn đã giao.  

### 🛠️ Admin
- Quản lý người dùng, shop, sản phẩm, danh mục, khuyến mãi.  
- Quản lý nhà vận chuyển, phí giao hàng, chiết khấu hệ thống.  
- Theo dõi thống kê toàn hệ thống.  

---

## ✨ 7. Điểm nổi bật
- Hệ thống thân thiện với người dùng.
- Tích hợp thanh toán **VNPAY (sandbox)**  
- Thông báo thời gian thực qua **WebSocket**  
- Xuất báo cáo **PDF**  

---

## 👨‍💻 8. Phân công công việc

### **Chau Võ Minh Danh – Vendor + Shipper**
  - Vẽ và đặc tả use case liên quan đến Vendor và Shipper.  
  - Phân tích luồng nghiệp vụ cho hai actor.
  - Vẽ lược đồ tuần tự cho các chức năng Vendor và Shipper.  
  - Thiết kế giao diện sơ bộ cho các màn hình quản lý cửa hàng và giao hàng.
  - Xây dựng các chức năng của Vendor: quản lý sản phẩm, quản lý đơn hàng.
  - Hoàn thiện chức năng thống kê doanh thu cho Vendor.  
  - Phát triển và kiểm thử nghiệp vụ Shipper: nhận đơn, cập nhật trạng thái, xác nhận hoàn tất.  
  - Tinh chỉnh giao diện liên quan.

### **Nguyễn Hữu Trí – User + Guest**
  - Vẽ và đặc tả use case liên quan đến User và Guest.  
  - Phân tích hành vi người dùng và luồng đặt hàng.
  - Vẽ lược đồ tuần tự cho User và Guest.  
  - Thiết kế giao diện trang chính và trang sản phẩm.
  - Xây dựng chức năng Guest: xem, tìm kiếm, xem chi tiết sản phẩm.  
  - Xây dựng chức năng User: xem, tìm kiếm, xem chi tiết sản phẩm, quản lý giỏ hàng.
  - Phát triển các chức năng User nâng cao: đặt hàng, đánh giá sản phẩm.  
  - Hoàn thiện giao diện giỏ hàng và thanh toán.

### **Cao Nguyễn Anh Vũ – Admin**
  - Vẽ và đặc tả use case cho Admin.  
  - Thiết kế sơ đồ cơ sở dữ liệu tổng thể (bảng, khóa, quan hệ).
  - Vẽ lược đồ tuần tự cho Admin.  
  - Xây dựng hệ thống phân quyền người dùng.
  - Xây dựng chức năng Admin: quản lý người dùng, cửa hàng.
  - Hoàn thiện các chức năng quản trị.  
  - Tối ưu và hoàn thiện cơ sở dữ liệu.


---

## 🧰 9. Công nghệ sử dụng
| Thành phần | Công nghệ | Chức năng |
|-------------|------------|-----------|
| **Ngôn ngữ lập trình** | Java (JDK 22) | Xây dựng toàn bộ logic nghiệp vụ trong ứng dụng Spring Boot. |
| **Framework chính** | Spring Boot | Tổ chức cấu trúc dự án, quản lý dependency và điều phối toàn bộ hệ thống. |
| **Giao diện người dùng** | JSP, JSTL, HTML, CSS, Bootstrap 5 | Tạo giao diện động, thân thiện, responsive cho người dùng. |
| **Cơ sở dữ liệu** | MySQL | Lưu trữ thông tin người dùng, sản phẩm, đơn hàng, khuyến mãi,... |
| **Truy cập dữ liệu** | JPA (Spring Data JPA) | Kết nối, truy vấn và thao tác dữ liệu hiệu quả với ORM. |
| **Template Decorator** | Sitemesh | Quản lý layout tổng thể, giảm trùng lặp và tối ưu giao diện trang. |
| **Bảo mật** | JWT (JSON Web Token) | Xác thực và phân quyền người dùng an toàn, tránh truy cập trái phép. |
| **Giao tiếp real-time** | WebSocket | Cập nhật đơn hàng, chat và thông báo theo thời gian thực. |
| **Phân tích & thiết kế** | Enterprise Architect | Hỗ trợ mô hình hóa UML, thiết kế cơ sở dữ liệu và quy trình nghiệp vụ. |
| **Công cụ phát triển** | Visuel Studio Code | Môi trường phát triển tích hợp cho Spring, hỗ trợ debug và quản lý dự án. |
| **Quản lý mã nguồn** | Git + GitHub | Lưu trữ, quản lý phiên bản và cộng tác nhóm hiệu quả. |
