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
                        <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">Đăng ký bán hàng
                        </h1>
                        <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
                            <li class="breadcrumb-item"><a href="/">Home</a></li>
                            <li class="breadcrumb-item active text-white">Đăng ký Vendor</li>
                        </ol>
                    </div>
                </div>
                <!-- Single Page Header End -->

                <!-- Vendor Registration Page Start -->
                <div class="container-fluid bg-light overflow-hidden py-5">
                    <div class="container py-5">
                        <div class="row justify-content-center">
                            <!-- Vendor Registration Form -->
                            <div class="col-lg-9 wow fadeInUp" data-wow-delay="0.1s">

                                <!-- Success Message -->
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <!-- Error Message -->
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <!-- Info Banner -->
                                <div class="alert alert-info mb-4">
                                    <h5><i class="fas fa-info-circle me-2"></i>Trở thành người bán hàng trên Fashion
                                    </h5>
                                    <p class="mb-0">Hãy điền đầy đủ thông tin dưới đây để đăng ký trở thành người bán
                                        hàng. Chúng tôi sẽ xem xét và phản hồi trong vòng 24-48 giờ.</p>
                                </div>

                                <div class="card border-0 shadow-sm">
                                    <div class="card-body p-4">
                                        <form:form action="/registraion-sales" method="post" modelAttribute="shop"
                                            enctype="multipart/form-data">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <h2 class="mb-0"><i class="fas fa-store me-2 text-primary"></i>Thông tin
                                                    đăng ký</h2>

                                                <!-- Status Badge -->
                                                <c:if
                                                    test="${not empty shop.securityInfo and not empty shop.securityInfo.verificationStatus}">
                                                    <div>
                                                        <c:choose>
                                                            <c:when
                                                                test="${shop.securityInfo.verificationStatus == 'PENDING'}">
                                                                <span class="badge bg-warning text-dark px-3 py-2"
                                                                    style="font-size: 1rem;">
                                                                    <i class="fas fa-clock me-1"></i>Đang chờ duyệt
                                                                </span>
                                                            </c:when>
                                                            <c:when
                                                                test="${shop.securityInfo.verificationStatus == 'APPROVED'}">
                                                                <span class="badge bg-success px-3 py-2"
                                                                    style="font-size: 1rem;">
                                                                    <i class="fas fa-check-circle me-1"></i>Đã được
                                                                    duyệt
                                                                </span>
                                                            </c:when>
                                                            <c:when
                                                                test="${shop.securityInfo.verificationStatus == 'REJECTED'}">
                                                                <span class="badge bg-danger px-3 py-2"
                                                                    style="font-size: 1rem;">
                                                                    <i class="fas fa-times-circle me-1"></i>Bị từ chối
                                                                </span>
                                                            </c:when>
                                                            <c:when
                                                                test="${shop.securityInfo.verificationStatus == 'NOT REGISTERED'}">
                                                                <span class="badge bg-secondary px-3 py-2"
                                                                    style="font-size: 1rem;">
                                                                    <i class="fas fa-question-circle me-1"></i>Chưa đăng
                                                                    ký </span>
                                                            </c:when>
                                                        </c:choose>
                                                    </div>
                                                </c:if>
                                            </div>

                                            <form:hidden path="securityInfo.verificationStatus" />


                                            <div class="row g-4">
                                                <!-- Shop Information Section -->
                                                <div class="col-12">
                                                    <h5 class="text-primary "><i class="fas fa-building me-2"></i>Thông
                                                        tin cửa hàng</h5>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-item">
                                                        <label class="form-label">Tên cửa hàng <span
                                                                class="text-danger">*</span></label>
                                                        <form:input path="shopName" type="text" class="form-control"
                                                            placeholder="VD: Fashion Store ABC" required="required"
                                                            oninvalid="this.setCustomValidity('Vui lòng nhập tên cửa hàng')"
                                                            oninput="this.setCustomValidity('')" />
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <div class="form-item">
                                                        <label class="form-label">Mô tả cửa hàng <span
                                                                class="text-danger">*</span></label>
                                                        <form:textarea path="description" class="form-control" rows="4"
                                                            placeholder="Giới thiệu về cửa hàng của bạn, sản phẩm kinh doanh chính..."
                                                            required="required"
                                                            oninvalid="this.setCustomValidity('Vui lòng nhập mô tả cửa hàng')"
                                                            oninput="this.setCustomValidity('')" />
                                                    </div>
                                                </div>

                                                <!-- Business Information Section -->
                                                <div class="col-12 mt-5">
                                                    <h5 class="text-primary "><i class="fas fa-briefcase me-2"></i>Thông
                                                        tin kinh doanh</h5>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-item">
                                                        <label class="form-label">Loại hình kinh doanh <span
                                                                class="text-danger">*</span></label>
                                                        <form:select path="securityInfo.businessType"
                                                            class="form-select" required="required"
                                                            oninvalid="this.setCustomValidity('Vui lòng chọn loại hình kinh doanh')"
                                                            oninput="this.setCustomValidity('')">
                                                            <form:option value="">-- Chọn loại hình --</form:option>
                                                            <form:option value="individual">Cá nhân</form:option>
                                                            <form:option value="company">Công ty/Doanh nghiệp
                                                            </form:option>
                                                        </form:select>
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-item">
                                                        <label class="form-label">Mã số thuế (nếu có)</label>
                                                        <form:input path="securityInfo.taxCode" type="text"
                                                            class="form-control" placeholder="VD: 0123456789" />
                                                    </div>
                                                </div>

                                                <!-- Bank Information Section -->
                                                <div class="col-12 mt-5">
                                                    <h5 class="text-primary "><i
                                                            class="fas fa-university me-2"></i>Thông tin thanh toán</h5>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-item">
                                                        <label class="form-label">Ngân hàng <span
                                                                class="text-danger">*</span></label>
                                                        <form:input path="securityInfo.bankName" type="text"
                                                            class="form-control" placeholder="VD: Vietcombank"
                                                            required="required"
                                                            oninvalid="this.setCustomValidity('Vui lòng nhập tên ngân hàng')"
                                                            oninput="this.setCustomValidity('')" />
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-item">
                                                        <label class="form-label">Chi nhánh</label>
                                                        <form:input path="securityInfo.bankBranch" type="text"
                                                            class="form-control" placeholder="VD: Chi nhánh TP.HCM" />
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-item">
                                                        <label class="form-label">Số tài khoản <span
                                                                class="text-danger">*</span></label>
                                                        <form:input path="securityInfo.bankAccount" type="text"
                                                            class="form-control" placeholder="VD: 1234567890"
                                                            required="required"
                                                            oninvalid="this.setCustomValidity('Vui lòng nhập số tài khoản')"
                                                            oninput="this.setCustomValidity('')" />
                                                    </div>
                                                </div>

                                                <div class="col-md-6">
                                                    <div class="form-item">
                                                        <label class="form-label">Tên chủ tài khoản <span
                                                                class="text-danger">*</span></label>
                                                        <form:input path="securityInfo.bankAccountName" type="text"
                                                            class="form-control" placeholder="VD: NGUYEN VAN A"
                                                            required="required"
                                                            oninvalid="this.setCustomValidity('Vui lòng nhập tên chủ tài khoản')"
                                                            oninput="this.setCustomValidity('')" />
                                                    </div>
                                                </div>

                                                <!-- Submit Button -->
                                                <div class="col-12 mt-5">
                                                    <button type="submit" class="btn btn-primary btn-lg">
                                                        <i class="fas fa-paper-plane me-2"></i>Gửi đăng ký
                                                    </button>
                                                    <a href="/" class="btn btn-outline-secondary btn-lg px-5    ms-2">
                                                        <i class="fas fa-times me-2"></i>Hủy
                                                    </a>
                                                </div>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>

                                <!-- Help Section -->
                                <div class="alert alert-light border mt-5">
                                    <h6><i class="fas fa-question-circle me-2"></i>Cần hỗ trợ?</h6>
                                    <p class="mb-0">Nếu bạn có bất kỳ câu hỏi nào về việc đăng ký bán hàng, vui lòng
                                        liên hệ với chúng tôi qua email:
                                        <a href="mailto:vendor@fashion.com">admin@gmail.com</a> hoặc hotline:
                                        <strong>1900-xxxx</strong>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Vendor Registration Page End -->

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
                    function previewFile(event, previewId) {
                        const file = event.target.files[0];
                        if (file) {
                            const reader = new FileReader();
                            reader.onload = function (e) {
                                const preview = document.getElementById(previewId);
                                preview.src = e.target.result;
                                preview.style.display = 'block';
                            };
                            reader.readAsDataURL(file);
                        }
                    }

                    // Form validation
                    document.querySelector('form').addEventListener('submit', function (e) {
                        const phone = document.querySelector('input[name="phone"]').value;
                        const phoneRegex = /^[0-9]{10,11}$/;

                        if (!phoneRegex.test(phone)) {
                            e.preventDefault();
                            alert('Số điện thoại không hợp lệ! Vui lòng nhập 10-11 số.');
                            return false;
                        }

                        return confirm('Bạn có chắc chắn muốn gửi đăng ký này không?');
                    });
                </script>
            </body>

            </html>