<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">
                    Kết quả thanh toán
                </h1>
                <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
                    <li class="breadcrumb-item"><a href="/">Home</a></li>
                    <li class="breadcrumb-item"><a href="/order">Orders</a></li>
                    <li class="breadcrumb-item active text-white">Payment Result</li>
                </ol>
            </div>
            <!-- Single Page Header End -->

            <!-- Payment Result Start -->
            <div class="container-fluid py-5">
                <div class="container py-5">
                    <div class="row justify-content-center">
                        <div class="col-lg-6">
                            <div class="card shadow-lg border-0">
                                <div class="card-body p-5 text-center">
                                    <c:choose>
                                        <c:when test="${success}">
                                            <div class="mb-4">
                                                <i class="fas fa-check-circle text-success"
                                                    style="font-size: 80px;"></i>
                                            </div>
                                            <h2 class="text-success mb-3">Thanh toán thành công!</h2>
                                            <p class="text-muted mb-4">${message}</p>
                                            <p class="mb-4">Mã đơn hàng: <strong>${orderId}</strong></p>
                                            <div class="d-flex gap-3 justify-content-center">
                                                <a href="/checkout?orderId=${orderId}"
                                                    class="btn btn-success px-4 py-2">
                                                    <i class="fas fa-shopping-cart me-2"></i>Tiếp tục đặt hàng
                                                </a>
                                                <!-- <a href="/order" class="btn btn-primary px-4 py-2">
                                                    <i class="fas fa-list me-2"></i>Xem đơn hàng
                                                </a>
                                                <a href="/" class="btn btn-outline-primary px-4 py-2">
                                                    <i class="fas fa-home me-2"></i>Về trang chủ
                                                </a> -->
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="mb-4">
                                                <i class="fas fa-times-circle text-danger" style="font-size: 80px;"></i>
                                            </div>
                                            <h2 class="text-danger mb-3">Thanh toán thất bại!</h2>
                                            <div class="d-flex gap-3 justify-content-center">
                                                <c:if test="${not empty orderId}">
                                                    <a href="/checkout?orderId=${orderId}"
                                                        class="btn btn-primary px-4 py-2">
                                                        <i class="fas fa-redo me-2"></i>Thử lại
                                                    </a>
                                                </c:if>
                                                <a href="/order" class="btn btn-outline-primary px-4 py-2">
                                                    <i class="fas fa-list me-2"></i>Xem đơn hàng
                                                </a>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Payment Result End -->

            <!-- JavaScript Libraries -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="/client/lib/wow/wow.min.js"></script>

            <!-- Template Javascript -->
            <script src="/client/js/main.js"></script>
        </body>