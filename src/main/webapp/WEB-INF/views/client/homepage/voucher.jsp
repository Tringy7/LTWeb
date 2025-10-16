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
                                                            <span>${voucher.shop.shopName}</span>
                                                        </div>
                                                        <div class="voucher-details">
                                                            <h5 class="voucher-title">Giảm ${voucher.discountPercent}%
                                                                cho đơn
                                                                hàng</h5>
                                                            <p class="voucher-code">
                                                                Mã:
                                                                <strong
                                                                    id="voucher-code-${voucher.code}">${voucher.code}</strong>
                                                                <span class="copy-icon" data-code="${voucher.code}"
                                                                    style="cursor: pointer;">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16"
                                                                        height="16" fill="currentColor"
                                                                        class="bi bi-copy" viewBox="0 0 16 16">
                                                                        <path fill-rule="evenodd"
                                                                            d="M4 2a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1zM2 5a1 1 0 0 0-1 1v8a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1v-1h1v1a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h1v1z" />
                                                                    </svg>
                                                                </span>
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
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // Lấy tất cả các biểu tượng "Sao chép"
                        const copyIcons = document.querySelectorAll('.copy-icon');

                        // Thêm sự kiện click cho từng biểu tượng
                        copyIcons.forEach(icon => {
                            icon.addEventListener('click', function () {
                                const code = this.getAttribute('data-code'); // Lấy mã voucher từ thuộc tính data-code

                                // Tạo một input tạm để sao chép mã
                                const tempInput = document.createElement('input');
                                tempInput.value = code;
                                document.body.appendChild(tempInput);
                                tempInput.select();
                                document.execCommand('copy');
                                document.body.removeChild(tempInput);
                            });
                        });
                    });
                </script>

            </body>

            </html>