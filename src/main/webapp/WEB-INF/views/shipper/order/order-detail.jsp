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
                    <h2 class="mb-4 text-center text-primary">Chi tiết đơn hàng #${order.id}</h2>

                    <!-- Thông tin khách hàng -->
                    <div class="card mb-4 shadow-sm">
                        <div class="card-header bg-primary text-white">Thông tin khách hàng</div>
                        <div class="card-body">
                            <p><strong>Tên:</strong> ${order.user.fullName}</p>
                            <p><strong>SĐT:</strong> ${order.user.phone}</p>
                            <p><strong>Địa chỉ:</strong>
                                <c:choose>
                                    <c:when test="${not empty order.address}">
                                        ${order.address.receiverAddress}
                                    </c:when>
                                    <c:otherwise>
                                        <em>Không có địa chỉ</em>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>

                    <!-- Thông tin đơn -->
                    <div class="card mb-4 shadow-sm">
                        <div class="card-header bg-success text-white">Thông tin đơn hàng</div>
                        <div class="card-body">
                            <p><strong>Shop gửi:</strong> ${order.shop.shopName}</p>

                            <!-- Danh sách sản phẩm -->
                            <table class="table table-bordered text-center align-middle mt-3">
                                <thead class="table-light">
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Số lượng</th>
                                        <th>Giá</th>
                                        <th>Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="detail" items="${orderDetails}">
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
                                    </c:forEach>
                                </tbody>
                            </table>

                            <!-- Tổng tiền -->
                            <div class="text-end mt-3">
                                <p><strong>Phương thức thanh toán:</strong> ${order.paymentMethod}</p>
                                <p class="fs-5 fw-bold text-danger">
                                    Tổng tiền:
                                    <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" />
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