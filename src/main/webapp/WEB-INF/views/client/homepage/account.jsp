<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

            <body>
                <!-- Spinner Start -->
                <div id="spinner"
                    class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div>
                <!-- Spinner End -->

                <!-- Single Page Header start -->
                <div class="container-fluid page-header py-5"
                    style="background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url(/client/img/account-banner.jpg) center center no-repeat; background-size: cover;">
                    <div class="text-center">
                        <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">My Account</h1>
                        <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
                            <li class="breadcrumb-item"><a href="/">Home</a></li>
                            <li class="breadcrumb-item active text-white">Account</li>
                        </ol>
                    </div>
                </div>
                <!-- Single Page Header End -->

                <!-- Account Page Start -->
                <div class="container-fluid bg-light overflow-hidden py-5">
                    <div class="container py-5">
                        <div class="row justify-content-center">
                            <div class="col-lg-8 col-xl-6">
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        ${successMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                    </div>
                                </c:if>

                                <form:form action="/account/update-info" method="post" modelAttribute="user"
                                    enctype="multipart/form-data" class="wow fadeInUp" data-wow-delay="0.1s">
                                    <form:hidden path="id" />

                                    <!-- Avatar -->
                                    <div class="text-center mb-4">
                                        <img id="avatar-preview"
                                            src="<c:url value='/admin/images/user/${not empty user.image ? user.image : "
                                            default-avatar.png"}' />"
                                        class="img-fluid rounded-circle mb-3"
                                        style="width: 150px; height: 150px; object-fit: cover;" alt="Avatar">
                                        <div>
                                            <label for="avatar" class="btn btn-primary btn-sm">
                                                <i class="fa fa-camera me-2"></i>Thay đổi ảnh
                                            </label>
                                            <input type="file" id="avatar" name="avatarFile" class="d-none"
                                                accept="image/*" onchange="previewImage(event)">
                                        </div>
                                    </div>

                                    <!-- Thông tin tài khoản -->
                                    <h4 class="mb-4 text-primary">
                                        <i class="fa fa-user me-2"></i>Thông tin tài khoản
                                    </h4>

                                    <div class="form-item mb-3">
                                        <label class="form-label">Họ và tên</label>
                                        <form:input path="fullName" type="text" class="form-control"
                                            placeholder="Nhập họ và tên" />
                                    </div>

                                    <div class="form-item mb-3">
                                        <label class="form-label">Email</label>
                                        <form:input path="email" type="email" class="form-control" readonly="true" />
                                    </div>

                                    <div class="form-item mb-3">
                                        <label class="form-label">Số điện thoại</label>
                                        <form:input path="phone" type="tel" class="form-control"
                                            placeholder="Nhập số điện thoại của bạn" />
                                    </div>

                                    <div class="form-item mb-4">
                                        <label class="form-label">Địa chỉ</label>
                                        <form:input path="address" type="text" class="form-control"
                                            placeholder="Nhập địa chỉ của bạn" />
                                    </div>

                                    <!-- Địa chỉ nhận hàng -->
                                    <h4 class="mb-4 text-primary">
                                        <i class="fa fa-map-marker me-2"></i>Địa chỉ nhận hàng
                                    </h4>

                                    <div class="form-item mb-3">
                                        <label class="form-label">Tên người nhận <span
                                                class="text-danger">*</span></label>
                                        <form:input path="receiver.receiverName" type="text" class="form-control"
                                            placeholder="Nhập tên người nhận" />
                                    </div>

                                    <div class="form-item mb-3">
                                        <label class="form-label">Số điện thoại người nhận <span
                                                class="text-danger">*</span></label>
                                        <form:input path="receiver.receiverPhone" type="tel" class="form-control"
                                            placeholder="Nhập số điện thoại người nhận" />
                                    </div>

                                    <div class="form-item mb-3">
                                        <label class="form-label">Địa chỉ nhận hàng <span
                                                class="text-danger">*</span></label>
                                        <form:input path="receiver.receiverAddress" type="text" class="form-control"
                                            placeholder="Nhập địa chỉ nhận hàng" />
                                    </div>

                                    <div class="form-item mb-4">
                                        <div class="form-item">
                                            <label class="form-label my-3">Tỉnh/Thành <sup>*</sup></label>
                                            <form:select path="receiver.receiverDistrict" cssClass="form-control"
                                                required="required">
                                                <form:option value="">-- Chọn tỉnh/thành --</form:option>
                                                <form:option value="An Giang">An Giang</form:option>
                                                <form:option value="Bà Rịa - Vũng Tàu">Bà Rịa - Vũng Tàu
                                                </form:option>
                                                <form:option value="Bạc Liêu">Bạc Liêu</form:option>
                                                <form:option value="Bắc Giang">Bắc Giang</form:option>
                                                <form:option value="Bắc Ninh">Bắc Ninh</form:option>
                                                <form:option value="Bắc Kạn">Bắc Kạn</form:option>
                                                <form:option value="Bến Tre">Bến Tre</form:option>
                                                <form:option value="Bình Dương">Bình Dương</form:option>
                                                <form:option value="Bình Định">Bình Định</form:option>
                                                <form:option value="Bình Phước">Bình Phước</form:option>
                                                <form:option value="Bình Thuận">Bình Thuận</form:option>
                                                <form:option value="Cà Mau">Cà Mau</form:option>
                                                <form:option value="Cao Bằng">Cao Bằng</form:option>
                                                <form:option value="Đắk Lắk">Đắk Lắk</form:option>
                                                <form:option value="Đắk Nông">Đắk Nông</form:option>
                                                <form:option value="Điện Biên">Điện Biên</form:option>
                                                <form:option value="Đồng Nai">Đồng Nai</form:option>
                                                <form:option value="Đồng Tháp">Đồng Tháp</form:option>
                                                <form:option value="Gia Lai">Gia Lai</form:option>
                                                <form:option value="Hà Giang">Hà Giang</form:option>
                                                <form:option value="Hà Nam">Hà Nam</form:option>
                                                <form:option value="Hà Nội">Hà Nội</form:option>
                                                <form:option value="Hà Tĩnh">Hà Tĩnh</form:option>
                                                <form:option value="Hải Dương">Hải Dương</form:option>
                                                <form:option value="Hải Phòng">Hải Phòng</form:option>
                                                <form:option value="Hậu Giang">Hậu Giang</form:option>
                                                <form:option value="Hòa Bình">Hòa Bình</form:option>
                                                <form:option value="Hưng Yên">Hưng Yên</form:option>
                                                <form:option value="Khánh Hòa">Khánh Hòa</form:option>
                                                <form:option value="Kiên Giang">Kiên Giang</form:option>
                                                <form:option value="Kon Tum">Kon Tum</form:option>
                                                <form:option value="Lai Châu">Lai Châu</form:option>
                                                <form:option value="Lâm Đồng">Lâm Đồng</form:option>
                                                <form:option value="Lạng Sơn">Lạng Sơn</form:option>
                                                <form:option value="Lào Cai">Lào Cai</form:option>
                                                <form:option value="Long An">Long An</form:option>
                                                <form:option value="Nam Định">Nam Định</form:option>
                                                <form:option value="Nghệ An">Nghệ An</form:option>
                                                <form:option value="Ninh Bình">Ninh Bình</form:option>
                                                <form:option value="Ninh Thuận">Ninh Thuận</form:option>
                                                <form:option value="Phú Thọ">Phú Thọ</form:option>
                                                <form:option value="Phú Yên">Phú Yên</form:option>
                                                <form:option value="Quảng Bình">Quảng Bình</form:option>
                                                <form:option value="Quảng Nam">Quảng Nam</form:option>
                                                <form:option value="Quảng Ngãi">Quảng Ngãi</form:option>
                                                <form:option value="Quảng Ninh">Quảng Ninh</form:option>
                                                <form:option value="Quảng Trị">Quảng Trị</form:option>
                                                <form:option value="Sóc Trăng">Sóc Trăng</form:option>
                                                <form:option value="Sơn La">Sơn La</form:option>
                                                <form:option value="Tây Ninh">Tây Ninh</form:option>
                                                <form:option value="Thái Bình">Thái Bình</form:option>
                                                <form:option value="Thái Nguyên">Thái Nguyên</form:option>
                                                <form:option value="Thanh Hóa">Thanh Hóa</form:option>
                                                <form:option value="Thừa Thiên - Huế">Thừa Thiên - Huế
                                                </form:option>
                                                <form:option value="Tiền Giang">Tiền Giang</form:option>
                                                <form:option value="Trà Vinh">Trà Vinh</form:option>
                                                <form:option value="Tuyên Quang">Tuyên Quang</form:option>
                                                <form:option value="Vĩnh Long">Vĩnh Long</form:option>
                                                <form:option value="Vĩnh Phúc">Vĩnh Phúc</form:option>
                                                <form:option value="Yên Bái">Yên Bái</form:option>
                                                <form:option value="Thành phố Hồ Chí Minh">Thành phố Hồ Chí
                                                    Minh</form:option>
                                                <form:option value="Cần Thơ">Cần Thơ</form:option>
                                                <form:option value="Đà Nẵng">Đà Nẵng</form:option>
                                            </form:select>
                                        </div>
                                    </div>

                                    <!-- Submit Button -->
                                    <div class="text-center">
                                        <button type="submit" class="btn btn-primary py-3 px-5 text-uppercase w-100">
                                            <i class="fa fa-save me-2"></i>Lưu thay đổi
                                        </button>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Account Page End -->

                <!-- Back to Top -->
                <a href="#" class="btn btn-primary btn-lg-square back-to-top"><i class="fa fa-arrow-up"></i></a>

                <!-- JavaScript Libraries -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/wow/wow.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                <!-- Template Javascript -->
                <script src="/client/js/main.js"></script>

                <script>
                    function previewImage(event) {
                        const reader = new FileReader();
                        reader.onload = function () {
                            const output = document.getElementById('avatar-preview');
                            output.src = reader.result;
                        };
                        reader.readAsDataURL(event.target.files[0]);
                    }
                </script>
            </body>

            </html>