<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html>

            <head>
                <title>Chi tiết đơn hàng #${order.id}</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>

            <body class="bg-light">

                <div class="container my-5">

                    <!-- Tiêu đề -->
                    <h2 class="mb-4 text-center text-primary">Chi tiết sản phẩm #${detail.id}</h2>

                    <!-- Card thông tin tổng hợp -->
                    <div class="card mb-4 shadow-sm">
                        <div class="card-header bg-info text-white">Thông tin đơn hàng & sản phẩm</div>
                        <div class="card-body">

                            <!-- Khách hàng & địa chỉ -->
                            <div class="mb-3">
                                <h5 class="text-primary">Thông tin khách hàng</h5>
                                <p><strong>Tên:</strong> ${detail.order.user.fullName}</p>
                                <p><strong>SĐT:</strong> ${detail.order.user.phone}</p>
                                <p><strong>Địa chỉ:</strong>
                                    <c:choose>
                                        <c:when test="${not empty detail.order.address}">
                                            ${detail.order.address.receiverAddress}
                                        </c:when>
                                        <c:otherwise>
                                            <em>Không có địa chỉ</em>
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                            </div>

                            <!-- Shop & sản phẩm -->
                            <div class="mb-3">
                                <p><strong>Cửa hàng:</strong> ${detail.order.shop.shopName}</p>
                                <table class="table table-bordered text-center align-middle mt-2 mb-2">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Sản phẩm</th>
                                            <th>Số lượng</th>
                                            <th>Giá</th>
                                            <th>Thành tiền</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>${detail.product.name}</td>
                                            <td>${detail.quantity}</td>
                                            <td>
                                                <fmt:formatNumber value="${detail.price}" type="currency"
                                                    currencySymbol="₫" />
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${detail.price * detail.quantity}"
                                                    type="currency" currencySymbol="₫" />
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>

                                <p class="text-end"><strong>Phương thức thanh toán:</strong>
                                    ${detail.order.paymentMethod}</p>
                                <p class="fs-5 fw-bold text-danger text-end">
                                    Thành tiền:
                                    <fmt:formatNumber value="${detail.price * detail.quantity}" type="currency"
                                        currencySymbol="₫" />
                                </p>
                            </div>

                        </div>
                    </div>

                    <div class="text-center">
                        <a href="${pageContext.request.contextPath}/shipper/order" class="btn btn-secondary">← Quay lại
                            danh sách</a>
                    </div>

                </div>



            </body>

            </html>