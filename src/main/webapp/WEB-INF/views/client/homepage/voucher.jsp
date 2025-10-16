<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

            <head>
                <style>
                    .voucher-card {
                        display: flex;
                        background-color: #fff;
                        border: 1px solid #e8e8e8;
                        border-radius: 8px;
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                        overflow: hidden;
                    }

                    .voucher-brand {
                        background-color: #f8f9fa;
                        color: var(--bs-secondary);
                        padding: 1.5rem 1rem;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-weight: bold;
                        font-size: 1.1rem;
                        writing-mode: vertical-rl;
                        text-orientation: mixed;
                        transform: rotate(180deg);
                        border-right: 2px dashed #e8e8e8;
                    }

                    .voucher-details {
                        padding: 1rem 1.25rem;
                        flex-grow: 1;
                    }

                    .voucher-title {
                        font-size: 1.1rem;
                        font-weight: 600;
                        color: #333;
                        margin-bottom: 0.5rem;
                    }

                    .voucher-code {
                        font-size: 1rem;
                        font-weight: 500;
                        color: #555;
                    }

                    .voucher-expiry {
                        font-size: 0.9rem;
                        color: #888;
                        margin-top: 0.25rem;
                    }

                    .voucher-actions {
                        display: flex;
                        align-items: center;
                        justify-content: flex-end;
                        padding: 1.5rem;
                        border-left: 1px solid #e0e0e0;
                    }
                </style>
            </head>

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
                    style="background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url(/client/img/voucher-banner.jpg) center center no-repeat; background-size: cover;">
                    <div class="text-center">
                        <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">My Voucher</h1>
                        <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
                            <li class="breadcrumb-item"><a href="/">Home</a></li>
                            <li class="breadcrumb-item"><a href="/account">Account</a></li>
                            <li class="breadcrumb-item active text-white">My Voucher</li>
                        </ol>
                    </div>
                </div>
                <!-- Single Page Header End -->

                <!-- Voucher Page Start -->
                <div class="container-fluid bg-light overflow-hidden py-5">
                    <div class="container py-5">
                        <div class="row justify-content-center">
                            <div class="col-lg-10 wow fadeInUp" data-wow-delay="0.1s">
                                <h2 class="mb-4">Voucher của bạn</h2>

                                <c:choose>
                                    <c:when test="${not empty vouchers}">
                                        <div class="row g-4">
                                            <c:forEach var="voucher" items="${vouchers}">
                                                <div class="col-md-6">
                                                    <div class="voucher-card h-100">
                                                        <div class="voucher-brand">
                                                            <span>SHOP</span>
                                                        </div>
                                                        <div class="voucher-details">
                                                            <h5 class="voucher-title">Giảm ${voucher.discountPercent}%
                                                                cho đơn
                                                                hàng</h5>
                                                            <p class="voucher-code">Mã:
                                                                <strong>${voucher.code}</strong>
                                                            </p>
                                                            <p class="voucher-expiry">
                                                                HSD:
                                                                ${voucher.endDate}
                                                            </p>
                                                        </div>
                                                        <div class="voucher-actions">
                                                            <a href="/cart" class="btn btn-primary">Dùng ngay</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-info text-center" role="alert">
                                            Bạn chưa có voucher nào.
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Voucher Page End -->

                <!-- Back to Top -->
                <a href="#" class="btn btn-primary btn-lg-square back-to-top"><i class="fa fa-arrow-up"></i></a>

                <!-- JavaScript Libraries -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/wow/wow.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                <!-- Template Javascript -->
                <script src="/client/js/main.js"></script>

            </body>

            </html>