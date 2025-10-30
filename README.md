## LTWeb - Shop (Spring Boot + JSP)

Một ứng dụng web thương mại điện tử dựa trên Spring Boot, JSP và Hibernate/JPA.

### Tổng quan

- Packaging: WAR (hỗ trợ JSP)
- Java: 22
- Build: Maven (đã có Maven Wrapper `mvnw` / `mvnw.cmd`)
- DB: MySQL (mặc định cấu hình trong `src/main/resources/application.properties`)
- Templating / decorator: Sitemesh

### Những gì có trong repo

- `src/main/java` - mã nguồn Java
- `src/main/resources` - cấu hình, `application.properties`
- `src/main/webapp` - JSP/JS/CSS và tài nguyên web
- `pom.xml` - cấu hình Maven và dependencies

### Yêu cầu

- Java 22
- Maven hoặc sử dụng Maven Wrapper (`mvnw` / `mvnw.cmd`)
- MySQL (hoặc SQL Server nếu muốn đổi driver)

### Cấu hình nhanh (local)

Tệp cấu hình chính: `src/main/resources/application.properties`.
Một số giá trị mặc định (hãy sửa trước khi deploy):

- `spring.datasource.url=jdbc:mysql://localhost:3306/shop`
- `spring.datasource.username=root`
- `spring.datasource.password=171005` (thay bằng mật khẩu an toàn)
- `server.port=8080`

VNPAY và JWT keys cũng được cấu hình trong `application.properties` — KHÔNG để key thật vào repo công khai.

### Tạo database (MySQL) mẫu

Chạy trong MySQL:

```sql
CREATE DATABASE shop CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- tạo user nếu cần
-- CREATE USER 'shopuser'@'localhost' IDENTIFIED BY 'your_password';
-- GRANT ALL PRIVILEGES ON shop.* TO 'shopuser'@'localhost';
```

### Chạy project (Windows PowerShell)

1) Chạy trực tiếp (với Maven Wrapper, sẽ dùng embedded Tomcat):

```powershell
.\'mvnw.cmd' spring-boot:run
```

2) Hoặc build và chạy file WAR:

```powershell
.\'mvnw.cmd' clean package -DskipTests
java -jar target\Design-0.0.1-SNAPSHOT.war
```

Lưu ý: tên WAR dựa trên `artifactId` và `version` trong `pom.xml` (hiện tại `Design-0.0.1-SNAPSHOT.war`).

### Thử nghiệm & kiểm tra

- Chạy test (nếu có):

```powershell
.\'mvnw.cmd' test
```

### Cấu trúc quan trọng & đường dẫn

- Các controller client: `src/main/java/com/shop/shop/controller/client` (ví dụ: `CartController`)
- Mẫu view JSP: `src/main/webapp/WEB-INF/views/`
- Tài nguyên web (css/js/images): `src/main/webapp/resources/`
- File upload mặc định: `file.upload.dir=src/main/webapp/resources/admin/images/user` (cấu hình trong `application.properties`)

### Cảnh báo bảo mật / best practices

- Không commit secrets (JWT secret, VNPAY keys, DB password). Thay thế bằng environment variables hoặc externalized config khi deploy.
- Kiểm tra `spring.jpa.hibernate.ddl-auto` (hiện `update`) — không dùng `create` hoặc `create-drop` trên production.

### Thay đổi cấu hình bằng environment variables

Bạn có thể override giá trị trong `application.properties` bằng biến môi trường hoặc tham số JVM.
Ví dụ (PowerShell):

```powershell
$env:SPRING_DATASOURCE_URL='jdbc:mysql://localhost:3306/shop'
$env:SPRING_DATASOURCE_USERNAME='root'
$env:SPRING_DATASOURCE_PASSWORD='newpass'
.\'mvnw.cmd' spring-boot:run
```

Hoặc khi chạy jar:

```powershell
java -Dspring.datasource.password=securepass -jar target\Design-0.0.1-SNAPSHOT.war
```

### Vấn đề thường gặp

- JSP không hiển thị / 404 cho view: kiểm tra `spring.mvc.view.prefix=/WEB-INF/views/` và `spring.mvc.view.suffix=.jsp` trong `application.properties`.
- Thời gian build lâu, lỗi plugin JSP: đảm bảo `maven-war-plugin` cấu hình `warSourceDirectory` là `src/main/webapp`.

### Ghi chú thêm

- Dự án dùng Spring Security, JPA, VNPAY integration, email và WebSocket. Nếu muốn deploy trên môi trường cloud, hãy externalize secrets và cấu hình datasource.

---

Nếu muốn, tôi có thể:

- Thêm phần `ENV` cụ thể cho Docker/Docker Compose.
- Viết script SQL khởi tạo dữ liệu mẫu (users, roles, sample products).
- Tạo hướng dẫn debug cho IntelliJ / VS Code.

Hãy cho biết bạn muốn thêm phần nào nữa vào README.
