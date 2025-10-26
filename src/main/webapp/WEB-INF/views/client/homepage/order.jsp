<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

                <body>
                    <style>
                        /* Card-like styling for each order row group */
                        .order-card-container {
                            background: #ffffff;
                            border: 1px solid #e9ecef;
                            border-radius: 8px;
                            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.04);
                            margin-bottom: 1.5rem;
                            /* Tăng khoảng cách giữa các đơn hàng */
                            overflow: hidden;
                            /* Đảm bảo bo góc được áp dụng cho table bên trong */
                        }

                        .order-card-container .table {
                            margin-bottom: 0;
                            /* Bỏ margin-bottom mặc định của table */
                        }

                        .order-card-container td,
                        .order-card-container th {
                            vertical-align: middle;
                        }

                        .order-card-container .table-warning {
                            background-color: #fff3cd;
                            /* Giữ màu nền cho dòng voucher */
                        }
                    </style>

                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                        <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
                    </div>
                    <!-- Spinner End -->

                    <!-- Single Page Header start -->
                    <div class="container-fluid page-header py-5"
                        style="background: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url(/client/img/order-banner.jpg) center center no-repeat; background-size: cover;">
                        <div class="text-center">
                            <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">My Orders
                            </h1>
                            <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
                                <li class="breadcrumb-item"><a href="/">Home</a></li>
                                <li class="breadcrumb-item active text-white">My Orders</li>
                            </ol>
                        </div>
                    </div>
                    <!-- Single Page Header End -->

                    <!-- Orders Page Start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <%-- Display success/error messages --%>
                                <c:if test="${not empty successMessage}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        ${successMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <c:if test="${not empty errorMessage}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${errorMessage}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <c:choose>
                                    <c:when test="${not empty orders}">
                                        <c:forEach var="order" items="${orders}">
                                            <div class="order-card-container">
                                                <div class="p-3 bg-light border-bottom">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <h5 class="mb-0">Đơn hàng #${order.id}</h5>
                                                        <c:set var="createdAtAsDate" value="${order.createdAt}" />
                                                        <span class="text-muted">Ngày đặt:
                                                            ${order.createdAt.toString().replace('T', ' ') }

                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="table-responsive">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">Sản phẩm</th>
                                                                <th scope="col">Tên</th>
                                                                <th scope="col">Size</th>
                                                                <th scope="col">Giá</th>
                                                                <th scope="col">Số lượng</th>
                                                                <th scope="col">Tổng</th>
                                                                <th scope="col">Trạng thái</th>
                                                                <th scope="col">Thao tác</th>
                                                                <th scope="col">Thanh toán</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>

                                                            <c:forEach var="orderDetail" items="${order.orderDetails}"
                                                                varStatus="loop">
                                                                <tr>
                                                                    <th scope="row">
                                                                        <div class="d-flex align-items-center">
                                                                            <img src="/admin/images/product/${orderDetail.product.image}"
                                                                                class="img-fluid me-3 rounded"
                                                                                style="width: 80px; height: 80px;"
                                                                                alt="">
                                                                        </div>
                                                                    </th>
                                                                    <td>
                                                                        <p class="mb-0 mt-4"><a
                                                                                href="/shop/product/${orderDetail.product.id}">${orderDetail.product.name}</a>
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <p class="mb-0 mt-4">${orderDetail.size}</p>
                                                                    </td>
                                                                    <td>
                                                                        <div class="mb-0 mt-4">
                                                                            <c:set var="isEligible"
                                                                                value="${not empty order.voucher and (empty order.voucher.shop or (not empty orderDetail.shop and orderDetail.shop.id eq order.voucher.shop.id))}" />
                                                                            <c:choose>
                                                                                <c:when test="${isEligible}">
                                                                                    <c:set var="originalUnitPrice"
                                                                                        value="${orderDetail.price / orderDetail.quantity}" />
                                                                                    <c:set var="discountedUnitPrice"
                                                                                        value="${originalUnitPrice * (1 - order.voucher.discountPercent / 100)}" />
                                                                                    <del>
                                                                                        <fmt:formatNumber
                                                                                            value="${originalUnitPrice}"
                                                                                            type="currency"
                                                                                            currencySymbol=""
                                                                                            minFractionDigits="0"
                                                                                            maxFractionDigits="0" />
                                                                                        VND
                                                                                    </del>
                                                                                    <p class="mb-0" style="color: red;">
                                                                                        <fmt:formatNumber
                                                                                            value="${discountedUnitPrice}"
                                                                                            type="currency"
                                                                                            currencySymbol=""
                                                                                            minFractionDigits="0"
                                                                                            maxFractionDigits="0" />
                                                                                        VND
                                                                                    </p>
                                                                                </c:when>
                                                                                <c:otherwise>
                                                                                    <p class="mb-0">
                                                                                        <fmt:formatNumber
                                                                                            value="${orderDetail.price / orderDetail.quantity}"
                                                                                            type="currency"
                                                                                            currencySymbol=""
                                                                                            minFractionDigits="0"
                                                                                            maxFractionDigits="0" />
                                                                                        VND
                                                                                    </p>
                                                                                </c:otherwise>
                                                                            </c:choose>
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <p class="mb-0 mt-4">${orderDetail.quantity}</p>
                                                                    </td>
                                                                    <td>
                                                                        <div class="mb-0 mt-4">
                                                                            <%-- Re-use the isEligible variable --%>
                                                                                <c:choose>
                                                                                    <c:when test="${isEligible}">
                                                                                        <c:set
                                                                                            var="discountedTotalPrice"
                                                                                            value="${orderDetail.price * (1 - order.voucher.discountPercent / 100)}" />
                                                                                        <del>
                                                                                            <fmt:formatNumber
                                                                                                value="${orderDetail.price}"
                                                                                                type="currency"
                                                                                                currencySymbol=""
                                                                                                minFractionDigits="0"
                                                                                                maxFractionDigits="0" />
                                                                                            VND
                                                                                        </del>
                                                                                        <p class="mb-0"
                                                                                            style="color: red;">
                                                                                            <fmt:formatNumber
                                                                                                value="${discountedTotalPrice}"
                                                                                                type="currency"
                                                                                                currencySymbol=""
                                                                                                minFractionDigits="0"
                                                                                                maxFractionDigits="0" />
                                                                                            VND
                                                                                        </p>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <p class="mb-0">
                                                                                            <fmt:formatNumber
                                                                                                value="${orderDetail.price}"
                                                                                                type="currency"
                                                                                                currencySymbol=""
                                                                                                minFractionDigits="0"
                                                                                                maxFractionDigits="0" />
                                                                                            VND
                                                                                        </p>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                        </div>
                                                                    </td>
                                                                    <%-- Hiển thị cột Trạng thái và Thao tác cho từng
                                                                        dòng chi tiết đơn hàng (không gộp) --%>
                                                                        <td class="align-middle">
                                                                            <p class="mb-0">
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'PENDING_PAYMENT'}">
                                                                                        <span
                                                                                            class="text-info fw-bold">Đợi
                                                                                            thanh
                                                                                            toán</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'PENDING'}">
                                                                                        <span
                                                                                            class="text-danger fw-bold">Đợi
                                                                                            xác
                                                                                            nhận</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'CONFIRMED'}">
                                                                                        <span
                                                                                            class="text-primary fw-bold">Đã
                                                                                            xác
                                                                                            nhận</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'SHIPPING'}">
                                                                                        <span
                                                                                            class="text-warning fw-bold">Đang
                                                                                            giao</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'DELIVERED'}">
                                                                                        <span
                                                                                            class="text-success fw-bold">Đã
                                                                                            giao</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'RETURN_REQUESTED'}">
                                                                                        <span
                                                                                            class="text-warning fw-bold">Yêu
                                                                                            cầu trả
                                                                                            hàng</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'RETURNED'}">
                                                                                        <span
                                                                                            class="text-secondary fw-bold">Đã
                                                                                            trả
                                                                                            hàng</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'REJECTED'}">
                                                                                        <span
                                                                                            class="text-danger fw-bold">Đơn
                                                                                            hàng bị từ
                                                                                            chối</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'REJECTED_RETURN'}">
                                                                                        <span
                                                                                            class="text-danger fw-bold">Yêu
                                                                                            cầu trả hàng
                                                                                            bị từ chối</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'CANCELLED'}">
                                                                                        <span
                                                                                            class="text-secondary fw-bold">Đã
                                                                                            hủy</span>
                                                                                    </c:when>
                                                                                    <c:otherwise>${orderDetail.status}
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </p>
                                                                        </td>
                                                                        <td class="align-middle">
                                                                            <div class="d-flex flex-column gap-2">
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'PENDING_PAYMENT'}">
                                                                                        <form
                                                                                            action="/order/cancel/${orderDetail.id}"
                                                                                            method="post"
                                                                                            style="margin: 0;">
                                                                                            <button type="submit"
                                                                                                class="btn btn-sm btn-outline-danger w-100"
                                                                                                onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');">
                                                                                                <i
                                                                                                    class="fas fa-times me-1"></i>Hủy
                                                                                                đơn
                                                                                            </button>
                                                                                        </form>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'PENDING'}">
                                                                                        <form
                                                                                            action="/order/cancel/${orderDetail.id}"
                                                                                            method="post"
                                                                                            style="margin: 0;">
                                                                                            <button type="submit"
                                                                                                class="btn btn-sm btn-outline-danger w-100"
                                                                                                onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');">
                                                                                                <i
                                                                                                    class="fas fa-times me-1"></i>Hủy
                                                                                                đơn
                                                                                            </button>
                                                                                        </form>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${orderDetail.status == 'DELIVERED'}">
                                                                                        <a href="/shop/product/${orderDetail.product.id}"
                                                                                            class="btn btn-sm btn-outline-primary">
                                                                                            <i
                                                                                                class="fas fa-comment me-1"></i>Đánh
                                                                                            giá
                                                                                        </a>
                                                                                        <form action="/order/request"
                                                                                            method="post"
                                                                                            style="margin: 0;">
                                                                                            <input type="hidden"
                                                                                                name="orderId"
                                                                                                value="${orderDetail.id}" />
                                                                                            <button type="submit"
                                                                                                class="btn btn-sm btn-outline-warning w-100">
                                                                                                <i
                                                                                                    class="fas fa-undo me-1"></i>Trả
                                                                                                hàng
                                                                                            </button>
                                                                                        </form>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <!-- No actions for other statuses (CONFIRMED, SHIPPING, RETURN_REQUESTED, RETURNED, REJECTED, REJECTED_RETURN, CANCELLED) -->
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </div>
                                                                        </td>

                                                                        <!-- Payment cell: render once per order using rowspan on the first orderDetail row -->
                                                                        <c:if test="${loop.first}">
                                                                            <td class="align-middle text-center"
                                                                                rowspan="${fn:length(order.orderDetails)}">
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${not order.paymentStatus}">
                                                                                        <a href="/checkout?orderId=${order.id}"
                                                                                            class="btn btn-sm btn-primary mb-2">
                                                                                            <i
                                                                                                class="fas fa-credit-card me-1"></i>Thanh
                                                                                            toán
                                                                                        </a>
                                                                                        <div>
                                                                                            <small
                                                                                                class="text-muted">Phương
                                                                                                thức:
                                                                                                <c:choose>
                                                                                                    <c:when
                                                                                                        test="${empty order.paymentMethod}">
                                                                                                        Chưa chọn
                                                                                                    </c:when>
                                                                                                    <c:when
                                                                                                        test="${order.paymentMethod == 'Direct Bank Transfer'}">
                                                                                                        Trực tuyến
                                                                                                    </c:when>
                                                                                                    <c:when
                                                                                                        test="${order.paymentMethod == 'Cash On Delivery'}">
                                                                                                        Thanh toán khi
                                                                                                        nhận</c:when>
                                                                                                    <c:otherwise>
                                                                                                        ${order.paymentMethod}
                                                                                                    </c:otherwise>
                                                                                                </c:choose>
                                                                                            </small>
                                                                                        </div>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <strong>
                                                                                            <c:choose>
                                                                                                <c:when
                                                                                                    test="${order.paymentMethod == 'Direct Bank Transfer'}">
                                                                                                    Thanh toán trực
                                                                                                    tuyến</c:when>
                                                                                                <c:when
                                                                                                    test="${order.paymentMethod == 'Cash On Delivery'}">
                                                                                                    Thanh toán khi nhận
                                                                                                    hàng</c:when>
                                                                                                <c:otherwise>
                                                                                                    ${order.paymentMethod}
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                        </strong>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </td>
                                                                        </c:if>

                                                                </tr>
                                                            </c:forEach>
                                                            <!-- Voucher Info Row -->
                                                            <c:set var="hasVoucher"
                                                                value="${not empty order.voucher}" />
                                                            <c:set var="voucherCode"
                                                                value="${not empty order.voucher ? order.voucher.code : ''}" />
                                                            <c:set var="voucherDiscount"
                                                                value="${not empty order.voucher ? order.voucher.discountPercent : 0}" />
                                                            <tr class="table-warning">
                                                                <td colspan="5" class="text-end">
                                                                    <c:if test="${hasVoucher}">
                                                                        <div class="d-flex align-items-center">
                                                                            <i
                                                                                class="fa fa-ticket-alt me-2 text-success"></i>
                                                                            <strong>Giảm giá bởi mã: ${voucherCode} -
                                                                                Giảm
                                                                                ${voucherDiscount}%</strong>
                                                                        </div>
                                                                    </c:if>
                                                                </td>
                                                                <td colspan="4"><strong class="text-dark fs-6">
                                                                        <fmt:formatNumber value="${order.totalPrice}"
                                                                            type="currency" currencySymbol=""
                                                                            minFractionDigits="0"
                                                                            maxFractionDigits="0" /> VND
                                                                    </strong></td>
                                                            </tr>

                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-5">
                                            <h4>Bạn chưa có đơn hàng nào!</h4>
                                            <a href="/shop" class="btn btn-primary rounded-pill px-4 py-2 mt-3">Bắt đầu
                                                mua sắm</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                        </div>
                    </div>
                    <!-- Orders Page End -->

                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/wow/wow.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>


                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>

                </body>