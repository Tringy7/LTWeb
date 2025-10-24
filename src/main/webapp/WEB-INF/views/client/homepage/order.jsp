<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

                <body>

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
                            <c:choose>
                                <c:when test="${not empty orders}">
                                    <c:set var="currentDate" value="" />
                                    <c:forEach var="order" items="${orders}">
                                        <c:set var="day" value="${order.createdAt.dayOfMonth}" />
                                        <c:set var="month" value="${order.createdAt.monthValue}" />
                                        <c:set var="year" value="${order.createdAt.year}" />
                                        <c:set var="formattedDay" value="${day < 10 ? '0' : ''}${day}" />
                                        <c:set var="formattedMonth" value="${month < 10 ? '0' : ''}${month}" />
                                        <c:set var="createdAtFormatted"
                                            value="${formattedDay}/${formattedMonth}/${year}" />

                                        <c:if test="${currentDate ne createdAtFormatted}">
                                            <c:if test="${not empty currentDate}">
                                                </tbody>
                                                </table>
                        </div>
                        </c:if>
                        <h3 class="mb-3 mt-4">Ngày: ${createdAtFormatted}</h3>
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
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:set var="currentDate" value="${createdAtFormatted}" />
                                    </c:if>

                                    <c:forEach var="detail" items="${order.orderDetails}" varStatus="loop">
                                        <tr>
                                            <th scope="row">
                                                <div class="d-flex align-items-center">
                                                    <img src="/admin/images/product/${detail.product.image}"
                                                        class="img-fluid me-3 rounded"
                                                        style="width: 80px; height: 80px;" alt="">
                                                </div>
                                            </th>
                                            <td>
                                                <p class="mb-0 mt-4"><a
                                                        href="/shop/product/${detail.product.id}">${detail.product.name}</a>
                                                </p>
                                            </td>
                                            <td>
                                                <p class="mb-0 mt-4">${detail.size}</p>
                                            </td>
                                            <td>
                                                <div class="mb-0 mt-4">
                                                    <c:if test="${not empty detail.voucher}">
                                                        <c:set var="originalUnitPrice"
                                                            value="${detail.price / detail.quantity}" />
                                                        <c:set var="discountedUnitPrice"
                                                            value="${originalUnitPrice * (1 - detail.voucher.discountPercent / 100)}" />
                                                        <del>
                                                            <fmt:formatNumber value="${originalUnitPrice}"
                                                                type="currency" currencySymbol="" minFractionDigits="0"
                                                                maxFractionDigits="0" /> VND
                                                        </del>
                                                        <p class="mb-0" style="color: red;">
                                                            <fmt:formatNumber value="${discountedUnitPrice}"
                                                                type="currency" currencySymbol="" minFractionDigits="0"
                                                                maxFractionDigits="0" /> VND
                                                        </p>
                                                    </c:if>
                                                    <c:if test="${empty detail.voucher}">
                                                        <p class="mb-0">
                                                            <fmt:formatNumber value="${detail.price / detail.quantity}"
                                                                type="currency" currencySymbol="" minFractionDigits="0"
                                                                maxFractionDigits="0" /> VND
                                                        </p>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td>
                                                <p class="mb-0 mt-4">${detail.quantity}</p>
                                            </td>
                                            <td>
                                                <div class="mb-0 mt-4">
                                                    <c:if test="${not empty detail.voucher}">
                                                        <c:set var="discountedTotalPrice"
                                                            value="${detail.price * (1 - detail.voucher.discountPercent / 100)}" />
                                                        <del>
                                                            <fmt:formatNumber value="${detail.price}" type="currency"
                                                                currencySymbol="" minFractionDigits="0"
                                                                maxFractionDigits="0" /> VND
                                                        </del>
                                                        <p class="mb-0" style="color: red;">
                                                            <fmt:formatNumber value="${discountedTotalPrice}"
                                                                type="currency" currencySymbol="" minFractionDigits="0"
                                                                maxFractionDigits="0" /> VND
                                                        </p>
                                                    </c:if>
                                                    <c:if test="${empty detail.voucher}">
                                                        <p class="mb-0">
                                                            <fmt:formatNumber value="${detail.price}" type="currency"
                                                                currencySymbol="" minFractionDigits="0"
                                                                maxFractionDigits="0" />
                                                            VND
                                                        </p>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <%-- Chỉ hiển thị cột Trạng thái và Thao tác cho dòng đầu tiên của mỗi đơn
                                                hàng --%>
                                                <c:if test="${loop.first}">
                                                    <td class="align-middle" rowspan="${fn:length(order.orderDetails)}">
                                                        <p class="mb-0">
                                                            <c:choose>
                                                                <c:when test="${order.status == 'PENDING'}">
                                                                    <span class="text-danger fw-bold">Đợi xác
                                                                        nhận</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'PENDING_PAYMENT'}">
                                                                    <span class="text-info fw-bold">Chờ thanh
                                                                        toán</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'SHIPPING'}">
                                                                    <span class="text-warning vfw-bold">Đang giao
                                                                        hàng</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'DELIVERED'}">
                                                                    <span class="text-success fw-bold">Đã giao
                                                                        hàng</span>
                                                                </c:when>
                                                                <c:otherwise>${order.status}</c:otherwise>
                                                            </c:choose>
                                                        </p>
                                                    </td>
                                                    <td class="align-middle" rowspan="${fn:length(order.orderDetails)}">
                                                        <div class="d-flex flex-column gap-2">
                                                            <c:if test="${order.status == 'PENDING_PAYMENT'}">
                                                                <a href="/checkout?orderId=${order.id}"
                                                                    class="btn btn-sm btn-primary">
                                                                    <i class="fas fa-credit-card me-1"></i>Thanh toán
                                                                </a>
                                                                <form action="/order/cancel/${order.id}" method="post"
                                                                    style="margin: 0;">
                                                                    <button type="submit"
                                                                        class="btn btn-sm btn-outline-danger w-100"
                                                                        onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');">
                                                                        <i class="fas fa-times me-1"></i>Hủy đơn
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                            <c:if test="${order.status == 'DELIVERED'}">
                                                                <a href="/review/create?orderId=${order.id}&productId=${detail.product.id}"
                                                                    class="btn btn-sm btn-outline-primary">
                                                                    <i class="fas fa-comment me-1"></i>Đánh giá
                                                                </a>
                                                                <a href="/return/request?orderId=${order.id}&productId=${detail.product.id}"
                                                                    class="btn btn-sm btn-outline-warning">
                                                                    <i class="fas fa-undo me-1"></i>Trả hàng
                                                                </a>
                                                            </c:if>
                                                            <c:if test="${order.status == 'PENDING'}">
                                                                <form action="/order/cancel/${order.id}" method="post"
                                                                    style="margin: 0;">
                                                                    <button type="submit"
                                                                        class="btn btn-sm btn-outline-danger w-100"
                                                                        onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng này?');">
                                                                        <i class="fas fa-times me-1"></i>Hủy đơn
                                                                    </button>
                                                                </form>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </c:if>
                                        </tr>
                                    </c:forEach>
                                    <!-- Voucher Info Row -->
                                    <c:set var="hasVoucher" value="false" />
                                    <c:set var="voucherCode" value="" />
                                    <c:set var="voucherDiscount" value="0" />
                                    <c:forEach var="detail" items="${order.orderDetails}">
                                        <c:if test="${not empty detail.voucher and not hasVoucher}">
                                            <c:set var="hasVoucher" value="true" />
                                            <c:set var="voucherCode" value="${detail.voucher.code}" />
                                            <c:set var="voucherDiscount" value="${detail.voucher.discountPercent}" />
                                        </c:if>
                                    </c:forEach>
                                    <tr class="table-light">
                                        <td colspan="5" class="text-end">
                                            <c:if test="${hasVoucher}">
                                                <div class="d-flex align-items-center">
                                                    <i class="fa fa-ticket-alt me-2 text-success"></i>
                                                    <strong>Giảm giá bởi mã: ${voucherCode} - Giảm
                                                        ${voucherDiscount}%</strong>
                                                </div>
                                            </c:if>
                                        </td>
                                        <td><strong>
                                                <fmt:formatNumber value="${order.totalPrice}" type="currency"
                                                    currencySymbol="" minFractionDigits="0" maxFractionDigits="0" /> VND
                                            </strong></td>
                                        <td colspan="2"><strong>
                                                <c:choose>
                                                    <c:when test="${order.paymentMethod == 'Direct Bank Transfer'}">
                                                        Thanh toán trực tuyến</c:when>
                                                    <c:when test="${order.paymentMethod == 'Cash On Delivery'}">Thanh
                                                        toán khi nhận hàng</c:when>
                                                    <c:otherwise>${order.paymentMethod}</c:otherwise>
                                                </c:choose>
                                            </strong></td>
                                    </tr>

                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-5">
                                <h4>Bạn chưa có đơn hàng nào!</h4>
                                <a href="/shop" class="btn btn-primary rounded-pill px-4 py-2 mt-3">Bắt đầu mua sắm</a>
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