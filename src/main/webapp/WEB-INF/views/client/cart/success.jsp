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
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">Đặt Hàng Thành Công</h1>
            <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
                <li class="breadcrumb-item"><a href="/">Trang Chủ</a></li>
                <li class="breadcrumb-item"><a href="/shop">Cửa Hàng</a></li>
                <li class="breadcrumb-item active text-white">Thành Công</li>
            </ol>
        </div>
        <!-- Single Page Header End -->

        <!-- Success Start -->
        <div class="container-fluid py-5">
            <div class="container py-5 text-center wow fadeInUp" data-wow-delay="0.1s">
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <i class="bi bi-check-circle display-1 text-primary"></i>
                        <h1 class="display-1">Thành Công!</h1>
                        <h1 class="mb-4">Đơn hàng của bạn đã được đặt!</h1>
                        <p class="mb-4">Cảm ơn bạn đã mua hàng. Chúng tôi đã nhận được đơn hàng của bạn và đang xử lý.
                        </p>
                        <a class="btn btn-secondary rounded-pill py-3 px-5 mx-2" href="/shop">Tiếp Tục Mua Sắm</a>
                        <a class="btn btn-primary rounded-pill py-3 px-5 mx-2" href="/order">Xem Lịch Sử Mua Hàng</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Success End -->

        <!-- JavaScript Libraries -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/client/lib/wow/wow.min.js"></script>
        <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>


        <!-- Template Javascript -->
        <script src="/client/js/main.js"></script>
    </body>

    </html>