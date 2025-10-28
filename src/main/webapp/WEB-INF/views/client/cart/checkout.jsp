<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
        <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>


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
                            <h1 class="text-center text-white display-6 wow fadeInUp" data-wow-delay="0.1s">Cheackout
                                Page
                            </h1>
                            <ol class="breadcrumb justify-content-center mb-0 wow fadeInUp" data-wow-delay="0.3s">
                                <li class="breadcrumb-item"><a href="/">Home</a></li>
                                <li class="breadcrumb-item"><a href="/cart">Cart</a></li>
                                <li class="breadcrumb-item active text-white">Cheackout</li>
                            </ol>
                        </div>
                        <!-- Single Page Header End -->

                        <!-- Searvices Start -->
                        <div class="container-fluid px-0">
                            <div class="row g-0">
                                <div class="col-6 col-md-4 col-lg-2 border-start border-end wow fadeInUp"
                                    data-wow-delay="0.1s">
                                    <div class="p-4">
                                        <div class="d-inline-flex align-items-center">
                                            <i class="fa fa-sync-alt fa-2x text-primary"></i>
                                            <div class="ms-4">
                                                <h6 class="text-uppercase mb-2">Free Return</h6>
                                                <p class="mb-0">30 days money back guarantee!</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.2s">
                                    <div class="p-4">
                                        <div class="d-flex align-items-center">
                                            <i class="fab fa-telegram-plane fa-2x text-primary"></i>
                                            <div class="ms-4">
                                                <h6 class="text-uppercase mb-2">Free Shipping</h6>
                                                <p class="mb-0">Free shipping on all order</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.3s">
                                    <div class="p-4">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-life-ring fa-2x text-primary"></i>
                                            <div class="ms-4">
                                                <h6 class="text-uppercase mb-2">Support 24/7</h6>
                                                <p class="mb-0">We support online 24 hrs a day</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.4s">
                                    <div class="p-4">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-credit-card fa-2x text-primary"></i>
                                            <div class="ms-4">
                                                <h6 class="text-uppercase mb-2">Receive Gift Card</h6>
                                                <p class="mb-0">Recieve gift all over oder $50</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.5s">
                                    <div class="p-4">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-lock fa-2x text-primary"></i>
                                            <div class="ms-4">
                                                <h6 class="text-uppercase mb-2">Secure Payment</h6>
                                                <p class="mb-0">We Value Your Security</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6 col-md-4 col-lg-2 border-end wow fadeInUp" data-wow-delay="0.6s">
                                    <div class="p-4">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-blog fa-2x text-primary"></i>
                                            <div class="ms-4">
                                                <h6 class="text-uppercase mb-2">Online Service</h6>
                                                <p class="mb-0">Free return products in 30 days</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Searvices End -->


                        <!-- Checkout Page Start -->
                        <div class="container-fluid bg-light overflow-hidden py-5">
                            <div class="container py-5">
                                <h1 class="mb-4 wow fadeInUp" data-wow-delay="0.1s">Thông tin nhận hàng</h1>
                                <form:form action="/checkout" method="post" modelAttribute="user">
                                    <!-- Ensure User id is submitted so controller receives user.id on update-receiver -->
                                    <form:hidden path="id" />
                                    <!-- Hidden fields: base total (order items), shipping fee and orderId -->
                                    <input type="hidden" id="baseTotal" name="baseTotal" value="${order.totalPrice}" />
                                    <input type="hidden" id="shippingFeeInput" name="shippingFee"
                                        value="${shippingFee}" />
                                    <input type="hidden" name="orderId" value="${order.id}" />

                                    <div class="row g-5">

                                        <div class="col-md-12 col-lg-6 col-xl-6 wow fadeInUp" data-wow-delay="0.1s">

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-item w-100">
                                                        <label class="form-label my-3">Tên người nhận
                                                            <sup>*</sup></label>
                                                        <form:input path="receiver.receiverName" type="text"
                                                            class="form-control" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md-7">
                                                    <div class="form-item">
                                                        <label class="form-label my-3">Địa chỉ <sup>*</sup></label>
                                                        <form:input path="receiver.receiverAddress" type="text"
                                                            class="form-control" />
                                                    </div>
                                                </div>
                                                <div class="col-md-5">
                                                    <div class="form-item">
                                                        <label class="form-label my-3">Tỉnh/Thành <sup>*</sup></label>
                                                        <form:select path="receiver.receiverDistrict"
                                                            cssClass="form-control" required="required">
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
                                            </div>
                                            <div class="form-item">
                                                <label class="form-label my-3">Số điện thoại người nhận
                                                    <sup>*</sup></label>
                                                <form:input path="receiver.receiverPhone" type="tel"
                                                    class="form-control" />
                                            </div>
                                            <div class="form-item">
                                                <label class="form-label my-3">Ghi chú cho người bán</label>
                                                <form:textarea path="receiver.note" name="text" class="form-control"
                                                    spellcheck="false" cols="30" rows="11" placeholder="Ghi chú" />
                                            </div>


                                        </div>
                                        <div class="col-md-12 col-lg-6 col-xl-6 wow fadeInUp" data-wow-delay="0.3s">
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr class="text-center">
                                                            <th scope="col">Image</th>
                                                            <th scope="col">Name</th>
                                                            <th scope="col">Size</th>
                                                            <th scope="col">Shop</th>
                                                            <th scope="col">Price</th>
                                                            <th scope="col">Quantity</th>
                                                            <th scope="col">Total</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td colspan="7">
                                                                <div style="max-height: 260px; overflow-y: auto;">
                                                                    <c:forEach var="item" items="${order.orderDetails}">
                                                                        <div class="row text-center mx-0">
                                                                            <div
                                                                                class="col-2 d-flex align-items-center">
                                                                                <img src="/admin/images/product/${item.product.image}"
                                                                                    class="img-fluid rounded"
                                                                                    style="width: 80px; height: 80px;"
                                                                                    alt="">
                                                                            </div>
                                                                            <div class="col-2 py-5">${item.product.name}
                                                                            </div>
                                                                            <div class="col-1 py-5">${item.size}</div>
                                                                            <div class="col-2 py-5">
                                                                                ${item.shop.shopName}</div>
                                                                            <div class="col-2 py-5">
                                                                                <%-- Logic to check if item is eligible
                                                                                    for discount --%>
                                                                                    <c:set var="isEligible"
                                                                                        value="${not empty order.voucher and (empty order.voucher.shop or (not empty item.shop and item.shop.id eq order.voucher.shop.id))}" />
                                                                                    <c:choose>
                                                                                        <c:when test="${isEligible}">
                                                                                            <c:set
                                                                                                var="discountedUnitPrice"
                                                                                                value="${item.product.price * (1 - order.voucher.discountPercent / 100)}" />
                                                                                            <del>
                                                                                                <fmt:formatNumber
                                                                                                    value="${item.product.price}"
                                                                                                    type="currency"
                                                                                                    currencySymbol=""
                                                                                                    minFractionDigits="0"
                                                                                                    maxFractionDigits="0" />
                                                                                                VND
                                                                                            </del>
                                                                                            <div style="color: red;">
                                                                                                <fmt:formatNumber
                                                                                                    value="${discountedUnitPrice}"
                                                                                                    type="currency"
                                                                                                    currencySymbol=""
                                                                                                    minFractionDigits="0"
                                                                                                    maxFractionDigits="0" />
                                                                                                VND
                                                                                            </div>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <fmt:formatNumber
                                                                                                value="${item.product.price}"
                                                                                                type="currency"
                                                                                                currencySymbol=""
                                                                                                minFractionDigits="0"
                                                                                                maxFractionDigits="0" />
                                                                                            VND
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                            </div>
                                                                            <div class="col-1 py-5">${item.quantity}
                                                                            </div>
                                                                            <div class="col-2 py-5">
                                                                                <%-- Re-use the isEligible variable --%>
                                                                                    <c:choose>
                                                                                        <c:when test="${isEligible}">
                                                                                            <c:set
                                                                                                var="discountedTotalPrice"
                                                                                                value="${item.price * (1 - order.voucher.discountPercent / 100)}" />
                                                                                            <del>
                                                                                                <fmt:formatNumber
                                                                                                    value="${item.price}"
                                                                                                    type="currency"
                                                                                                    currencySymbol=""
                                                                                                    minFractionDigits="0"
                                                                                                    maxFractionDigits="0" />
                                                                                                VND
                                                                                            </del>
                                                                                            <div style="color: red;">
                                                                                                <fmt:formatNumber
                                                                                                    value="${discountedTotalPrice}"
                                                                                                    type="currency"
                                                                                                    currencySymbol=""
                                                                                                    minFractionDigits="0"
                                                                                                    maxFractionDigits="0" />
                                                                                                VND
                                                                                            </div>
                                                                                        </c:when>
                                                                                        <c:otherwise>
                                                                                            <fmt:formatNumber
                                                                                                value="${item.price}"
                                                                                                type="currency"
                                                                                                currencySymbol=""
                                                                                                minFractionDigits="0"
                                                                                                maxFractionDigits="0" />
                                                                                            VND
                                                                                        </c:otherwise>
                                                                                    </c:choose>
                                                                            </div>
                                                                        </div>
                                                                    </c:forEach>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <!-- Voucher area (moved from cart) + messages -->
                                            <div class="mb-3">
                                                <c:if test="${not empty success}">
                                                    <div class="alert alert-success d-flex align-items-center"
                                                        role="alert">
                                                        <i class="fa fa-check-circle me-2"></i>
                                                        <div>
                                                            ${success}
                                                            <c:if test="${not empty voucherCodeApplied}">
                                                                <strong> Mã: ${voucherCodeApplied}</strong>
                                                            </c:if>
                                                            <c:if test="${not empty discountPercent}">
                                                                <span> - Giảm
                                                                    <strong>${discountPercent}%</strong></span>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <c:if test="${not empty error}">
                                                    <div class="alert alert-danger alert-dismissible fade show"
                                                        role="alert">
                                                        <i class="fa fa-exclamation-circle me-2"></i>${error}
                                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                                            aria-label="Close"></button>
                                                    </div>
                                                </c:if>

                                                <div
                                                    class="voucher-card bg-white p-3 rounded shadow-sm d-flex align-items-center justify-content-between">
                                                    <div class="d-flex align-items-center" style="gap:12px;">
                                                        <div class="input-group" style="max-width:420px;">
                                                            <input type="text" name="voucherCode" class="form-control"
                                                                placeholder="Nhập mã giảm giá" aria-label="Voucher code"
                                                                value="${not empty appliedVoucherCode ? appliedVoucherCode : ''}">
                                                            <button class="btn btn-outline-primary" type="submit"
                                                                formaction="/checkout/apply-voucher" formmethod="post">
                                                                <i class="fa fa-check me-1"></i>Áp dụng
                                                            </button>
                                                        </div>
                                                        <div class="d-none d-md-block text-muted small">Nhập mã và nhấn
                                                            Áp dụng để kiểm tra ưu đãi.</div>
                                                    </div>
                                                    <div class="btn-group">
                                                        <button class="btn btn-outline-danger" type="submit"
                                                            formaction="/checkout/remove-voucher" formmethod="post">
                                                            <i class="fa fa-times me-1"></i>Hủy
                                                        </button>
                                                        <a href="/voucher" class="btn btn-outline-secondary">
                                                            <i class="fa fa-ticket me-1"></i>Xem Voucher
                                                        </a>
                                                    </div>
                                                </div>
                                                <!-- Voucher Information Note (clean card, moved out of voucher-card) -->
                                                <div class="w-100 mt-3">
                                                    <div class="card border-0 shadow-sm p-3 bg-white">
                                                        <div class="d-flex align-items-start">
                                                            <div class="me-3">
                                                                <i class="fa fa-info-circle fa-2x text-primary"
                                                                    aria-hidden="true"></i>
                                                            </div>
                                                            <div>
                                                                <h6 class="mb-2">Lưu ý khi sử dụng mã giảm giá</h6>
                                                                <ul class="mb-0 ps-3 small text-muted">
                                                                    <li>Mã voucher chỉ áp dụng cho sản phẩm do cùng shop
                                                                        phát hành.</li>
                                                                    <li>Mã chỉ áp dụng cho sản phẩm hiện có trong đơn
                                                                        hàng của bạn.</li>
                                                                    <li>Khi áp dụng mã mới cho cùng shop, mã cũ sẽ tự
                                                                        động bị thay thế.</li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <!-- Shipping fee selection -->
                                                <div class="w-100 mt-3">
                                                    <div class="card border-0 shadow-sm p-3 bg-white">
                                                        <div class="d-flex align-items-start">
                                                            <div class="me-3">
                                                                <i class="fa fa-truck fa-2x text-primary"
                                                                    aria-hidden="true"></i>
                                                            </div>
                                                            <div class="flex-grow-1">
                                                                <h6 class="mb-2">Vận chuyển</h6>
                                                                <p class="mb-2 small text-muted">Phí vận chuyển sẽ được
                                                                    cộng vào tổng đơn.</p>
                                                                <div class="d-flex gap-3 flex-column flex-sm-column">
                                                                    <!-- Each option shows a small editable fee input on the right. -->
                                                                    <label
                                                                        class="form-check d-flex align-items-center p-2 rounded border">
                                                                        <div class="me-2">
                                                                            <div class="form-check-label fw-semibold">
                                                                                Phí vận chuyển</div>
                                                                            <div class="small text-muted">Thời gian: 4-5
                                                                                ngày</div>
                                                                        </div>
                                                                        <div class="ms-auto" style="max-width:150px;">
                                                                            <div class="input-group input-group-sm">
                                                                                <!-- Visible, formatted, readonly display (text) -->
                                                                                <input type="text"
                                                                                    class="form-control form-control-lg shipping-fee-field text-end fw-bold fs-5 bg-warning bg-opacity-10 text-dark"
                                                                                    value="<fmt:formatNumber value='${shippingFee}' type='number' groupingUsed='true' minFractionDigits='0' maxFractionDigits='0' />"
                                                                                    aria-label="fee" readonly
                                                                                    aria-readonly="true">
                                                                                <span
                                                                                    class="input-group-text">VND</span>
                                                                            </div>
                                                                        </div>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="d-flex justify-content-end align-items-center">
                                                <div class="me-4 text-end">
                                                    <h5 class="mb-0">Total:</h5>
                                                </div>
                                                <div
                                                    class="px-3 py-2 bg-primary text-white rounded shadow d-flex align-items-center">
                                                    <!-- store base total for client-side updates -->
                                                    <input type="hidden" id="baseTotal" value="${order.totalPrice}" />
                                                    <input type="hidden" name="shippingFee" id="shippingFeeInput"
                                                        value="${shippingFee}" />
                                                    <span id="displayTotal" class="h4 mb-0 fw-bold">
                                                        <fmt:formatNumber value="${order.totalPrice}" type="currency"
                                                            currencySymbol="" minFractionDigits="0"
                                                            maxFractionDigits="0" />
                                                        VND
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="row g-4 text-center align-items-center justify-content-center border-bottom py-2"
                                                data-wow-delay="0.1s">
                                                <div class="col-12">
                                                    <c:choose>
                                                        <c:when test="${isPaid}">
                                                            <!-- Hiển thị thông báo đã thanh toán -->
                                                            <div class="alert alert-success d-flex align-items-center"
                                                                role="alert">
                                                                <i class="fas fa-check-circle me-2"></i>
                                                                <div>
                                                                    <input type="hidden" name="paymentMethod"
                                                                        value="Direct Bank Transfer">
                                                                    <strong>Đơn hàng này đã được thanh toán!</strong>
                                                                    <br>
                                                                    <small>Phương thức: Thanh toán trực tuyến
                                                                        (VNPAY)</small>
                                                                </div>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- Hiển thị các phương thức thanh toán -->
                                                            <div class="form-check text-start my-2">
                                                                <input type="radio"
                                                                    class="form-check-input bg-primary border-0" checked
                                                                    id="Delivery-1" name="paymentMethod"
                                                                    value="Cash On Delivery">
                                                                <label class="form-check-label" for="Delivery-1">Thanh
                                                                    toán khi
                                                                    nhận hàng</label>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <c:if test="${!isPaid}">
                                                <div
                                                    class="row g-0 text-center align-items-center justify-content-center border-bottom py-2">
                                                    <div class="col-12">
                                                        <div class="form-check text-start my-2">
                                                            <input type="radio"
                                                                class="form-check-input bg-primary border-0"
                                                                id="Transfer-1" name="paymentMethod"
                                                                value="Direct Bank Transfer">
                                                            <label class="form-check-label" for="Transfer-1">Thanh toán
                                                                trực
                                                                tuyến</label>
                                                        </div>

                                                        <!-- Payment options container - hidden by default -->
                                                        <div id="onlinePaymentOptions" class="mt-3"
                                                            style="display: none;">
                                                            <p class="text-start mb-2">Chọn phương thức thanh toán:</p>

                                                            <!-- VNPAY Option -->
                                                            <div
                                                                class="d-flex justify-content-between align-items-center my-2 ps-4">
                                                                <div class="form-check">
                                                                    <input type="radio" class="form-check-input"
                                                                        id="vnpay-option" name="onlinePaymentType"
                                                                        value="VNPAY" checked>
                                                                    <label
                                                                        class="form-check-label d-flex align-items-center"
                                                                        for="vnpay-option">
                                                                        <span class="me-2">VNPAY</span>
                                                                        <small class="text-muted">(Ví điện tử, thẻ ATM,
                                                                            thẻ
                                                                            tín dụng)</small>
                                                                    </label>
                                                                </div>
                                                                <button type="button" id="vnpayButton"
                                                                    class="btn btn-sm btn-primary"
                                                                    data-order-id="${order.id}"
                                                                    data-total-price="${order.totalPrice}">
                                                                    <i class="fas fa-credit-card me-1"></i>Thanh toán
                                                                    VNPAY
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:if>
                                            <div
                                                class="row g-4 text-center align-items-center justify-content-center pt-4">
                                                <button type="submit"
                                                    class="btn btn-primary border-secondary py-3 px-4 text-uppercase w-100 text-primary">Đặt
                                                    hàng</button>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                            <!-- Checkout Page End -->

                            <!-- Back to Top -->
                            <a href="#" class="btn btn-primary btn-lg-square back-to-top"><i
                                    class="fa fa-arrow-up"></i></a>


                            <!-- JavaScript Libraries -->
                            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                            <script
                                src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                            <script src="/client/lib/wow/wow.min.js"></script>
                            <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>


                            <!-- Template Javascript -->
                            <script src="/client/js/main.js"></script>
                            <script src="/client/js/vnpay-payment.js"></script>
                            <script>
                                document.addEventListener('DOMContentLoaded', function () {
                                    const form = document.querySelector('form');
                                    const requiredFields = [
                                        { selector: 'input[name="receiver.receiverName"]', message: 'Tên người nhận là bắt buộc.' },
                                        { selector: 'input[name="receiver.receiverAddress"]', message: 'Địa chỉ người nhận là bắt buộc.' },
                                        { selector: 'select[name="receiver.receiverDistrict"]', message: 'Vui lòng chọn tỉnh/thành.' },
                                        { selector: 'input[name="receiver.receiverPhone"]', message: 'Số điện thoại người nhận là bắt buộc.' }
                                    ];

                                    form.addEventListener('submit', function (event) {
                                        let isValid = true;

                                        // Xóa thông báo lỗi cũ
                                        document.querySelectorAll('.error-message').forEach(el => el.remove());

                                        // Kiểm tra từng trường bắt buộc
                                        requiredFields.forEach(field => {
                                            const input = document.querySelector(field.selector);
                                            if (input && !input.value.trim()) {
                                                isValid = false;

                                                // Hiển thị thông báo lỗi
                                                const errorMessage = document.createElement('div');
                                                errorMessage.className = 'error-message text-danger mt-2';
                                                errorMessage.textContent = field.message;
                                                input.parentElement.appendChild(errorMessage);
                                            }
                                        });

                                        // Ngăn gửi biểu mẫu nếu có lỗi
                                        if (!isValid) {
                                            event.preventDefault();
                                        }
                                    });

                                    // Payment method toggle
                                    const paymentRadios = document.querySelectorAll('input[name="paymentMethod"]');
                                    const onlinePaymentOptions = document.getElementById('onlinePaymentOptions');
                                    const qrCodeContainer = document.getElementById('qrCodeContainer');
                                    const onlinePaymentTypeRadios = document.querySelectorAll('input[name="onlinePaymentType"]');

                                    // Function to toggle online payment options
                                    function togglePaymentOptions() {
                                        const selectedPayment = document.querySelector('input[name="paymentMethod"]:checked');
                                        if (selectedPayment && selectedPayment.value === 'Direct Bank Transfer') {
                                            onlinePaymentOptions.style.display = 'block';
                                        } else {
                                            onlinePaymentOptions.style.display = 'none';
                                            qrCodeContainer.style.display = 'none';
                                        }
                                    }

                                    // Function to toggle QR code based on online payment type
                                    function toggleQRCode() {
                                        const selectedOnlineType = document.querySelector('input[name="onlinePaymentType"]:checked');
                                        if (selectedOnlineType && selectedOnlineType.value === 'QR') {
                                            qrCodeContainer.style.display = 'block';
                                        } else {
                                            qrCodeContainer.style.display = 'none';
                                        }
                                    }

                                    // Add event listeners to payment method radio buttons
                                    paymentRadios.forEach(radio => {
                                        radio.addEventListener('change', togglePaymentOptions);
                                    });

                                    // Add event listeners to online payment type radio buttons
                                    onlinePaymentTypeRadios.forEach(radio => {
                                        radio.addEventListener('change', toggleQRCode);
                                    });

                                    // Shipping fee selection logic
                                    const baseTotalInput = document.getElementById('baseTotal');
                                    const displayTotal = document.getElementById('displayTotal');
                                    const shippingFeeInput = document.getElementById('shippingFeeInput');
                                    const shippingRadios = document.querySelectorAll('input[name="shippingOption"]');
                                    const vnFormatter = new Intl.NumberFormat('vi-VN');

                                    const getBaseTotal = () => {
                                        if (!baseTotalInput) return 0;
                                        const v = parseFloat(baseTotalInput.value);
                                        return isNaN(v) ? 0 : v;
                                    };

                                    // When the province select changes, submit the form to update receiver on server
                                    const provinceSelect = document.querySelector('select[name="receiver.receiverDistrict"]');
                                    if (provinceSelect) {
                                        provinceSelect.addEventListener('change', function () {
                                            const mainForm = document.querySelector('form');
                                            if (!mainForm) return;
                                            // Temporarily set action to update endpoint and submit
                                            const previousAction = mainForm.getAttribute('action');
                                            mainForm.setAttribute('action', '/checkout/update-receiver');
                                            mainForm.submit();
                                            // action will be reset on page reload after redirect
                                        });
                                    }

                                    function parseFeeFromRadio(radio) {
                                        if (!radio) return 0;
                                        // Try to read the nearby fee input first
                                        const label = radio.closest('label');
                                        if (label) {
                                            const feeInput = label.querySelector('.shipping-fee-field');
                                            if (feeInput && feeInput.value !== '') {
                                                const parsed = parseFloat(feeInput.value.replace(/,/g, ''));
                                                if (!isNaN(parsed)) return parsed;
                                            }
                                        }
                                        // fallback to data-fee
                                        return parseFloat(radio.dataset.fee || 0) || 0;
                                    }

                                    function updateTotalForFee(fee) {
                                        const base = getBaseTotal();
                                        const total = base + (Number(fee) || 0);
                                        if (displayTotal) displayTotal.textContent = vnFormatter.format(total) + ' VND';
                                        if (shippingFeeInput) shippingFeeInput.value = fee;
                                        // Update visible fee inputs (read-only) so UI reflects current selection
                                        document.querySelectorAll('.shipping-fee-field').forEach(function (el) {
                                            try {
                                                // show localized formatted value (e.g. 15.000)
                                                el.value = vnFormatter.format(Number(fee) || 0);
                                            } catch (e) { }
                                        });
                                    }

                                    shippingRadios.forEach(r => {
                                        // when radio selected
                                        r.addEventListener('change', function (e) {
                                            const fee = parseFeeFromRadio(this);
                                            updateTotalForFee(fee);
                                        });
                                        // when fee input changes, ensure radio is selected and update total
                                        const lbl = r.closest('label');
                                        if (lbl) {
                                            const feeInput = lbl.querySelector('.shipping-fee-field');
                                            if (feeInput) {
                                                feeInput.addEventListener('input', function (e) {
                                                    // ensure radio is checked when editing its fee
                                                    r.checked = true;
                                                    const val = parseFloat(this.value || 0) || 0;
                                                    updateTotalForFee(val);
                                                });
                                            }
                                        }
                                    });

                                    // initialize shipping selection
                                    const initialShipping = document.querySelector('input[name="shippingOption"]:checked');
                                    if (initialShipping) {
                                        updateTotalForFee(parseFeeFromRadio(initialShipping));
                                    }

                                    // Initial check on page load
                                    togglePaymentOptions();
                                });
                            </script>
                    </body>

                    </html>