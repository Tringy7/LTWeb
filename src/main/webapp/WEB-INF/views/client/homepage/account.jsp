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
                            <!-- Account Details Form -->
                            <div class="col-lg-8 wow fadeInUp" data-wow-delay="0.1s">
                                <h2 class="mb-4">Thông tin tài khoản</h2>
                                <form:form action="/account/update-info" method="post" modelAttribute="user"
                                    enctype="multipart/form-data">
                                    <form:hidden path="id" />
                                    <div class="row g-4">
                                        <div class="col-md-4">
                                            <div class="text-center">
                                                <img id="avatar-preview"
                                                    src="<c:url value='/admin/images/user/${not empty user.image ? user.image : "
                                                    default-avatar.png"}' />"
                                                class="img-fluid rounded-circle"
                                                style="width: 150px; height: 150px; object-fit: cover;" alt="Avatar">
                                                <label for="avatar" class="btn btn-primary btn-sm mt-3">Thay đổi
                                                    ảnh</label>
                                                <input type="file" id="avatar" name="avatarFile" class="d-none"
                                                    accept="image/*" onchange="previewImage(event)">
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="form-item">
                                                <label class="form-label my-3">Họ và tên</label>
                                                <form:input path="fullName" type="text" class="form-control" />
                                            </div>
                                            <div class="form-item">
                                                <label class="form-label my-3">Email</label>
                                                <form:input path="email" type="email" class="form-control"
                                                    readonly="true" />
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-item">
                                                <label class="form-label my-3">Số điện thoại</label>
                                                <form:input path="phone" type="tel" class="form-control"
                                                    placeholder="Nhập số điện thoại của bạn" />
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-item">
                                                <label class="form-label my-3">Địa chỉ</label>
                                                <form:input path="address" type="text" class="form-control"
                                                    placeholder="Nhập địa chỉ của bạn" />
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <button type="submit"
                                                class="btn btn-primary border-secondary py-3 px-4 text-uppercase">Lưu
                                                thay đổi</button>
                                        </div>
                                    </div>
                                </form:form>
                            </div>

                            <!-- Change Password Form -->
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