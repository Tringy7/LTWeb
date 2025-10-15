<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Chi tiết đơn hàng</title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                <style>
                    body {
                        background: #f8f9fa;
                    }

                    .card-custom {
                        border-radius: 15px;
                        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
                        overflow: hidden;
                    }

                    .card-header-custom {
                        background: linear-gradient(90deg, #4e73df 0%, #1cc88a 100%);
                        color: #fff;
                        font-weight: bold;
                        font-size: 1.2rem;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 12px 20px;
                    }

                    .form-control[readonly] {
                        background-color: #fdfdfd !important;
                        border: 1px solid #dee2e6;
                        box-shadow: none;
                    }

                    .table-custom thead th {
                        background-color: #4e73df;
                        color: #fff;
                        text-align: center;
                        vertical-align: middle;
                    }

                    .table-custom tbody tr {
                        transition: background-color 0.2s;
                    }

                    .table-custom tbody tr:hover {
                        background-color: #f8f9fc;
                    }

                    .table-custom td,
                    .table-custom th {
                        vertical-align: middle;
                        padding: 12px;
                        border-top: 1px solid #dee2e6;
                    }

                    table img {
                        border-radius: 10px;
                        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
                        object-fit: cover;
                    }

                    .btn-light {
                        border: 1px solid #e9ecef;
                    }

                    .btn-light:hover {
                        background: #f1f3f5;
                    }

                    .card-footer-custom {
                        padding: 15px 20px;
                        background-color: #f8f9fa;
                        text-align: end;
                    }

                    .btn-lift:hover {
                                transform: translateY(-3px);
                                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.25);
                            }

                            .btn-lift {
                                transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
                            }
                </style>
            </head>

            <body>
                <div class="container mt-3 mb-3">
                    <div class="card card-custom shadow-lg">
                        <div class="card-header card-header-custom">
                            <h4 class="mb-0">Chi tiết đơn hàng</h4>
                        </div>
                        <div class="card-body p-4">

                            <!-- Thông tin đơn hàng -->
                            <div class="row mb-1">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Mã đơn hàng:</label>
                                    <input type="text" class="form-control" value="${order.id}" readonly>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Phương thức thanh toán:</label>
                                    <input type="text" class="form-control" value="${order.paymentMethod}" readonly>
                                </div>
                            </div>

                            <div class="row mb-1">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Trạng thái:</label>
                                    <input type="text" class="form-control" value="${order.status}" readonly>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label fw-semibold">Tổng tiền (VND):</label>
                                    <input type="text" class="form-control"
                                        value="<fmt:formatNumber value='${order.totalPrice}' type='number' groupingUsed='true'/>"
                                        readonly>
                                </div>
                            </div>

                            <!-- Danh sách sản phẩm -->
                            <div class="mt-4">
                                <label class="form-label fw-bold fs-5 mb-3">Sản phẩm trong đơn</label>
                                <div class="table-responsive">
                                    <table class="table table-hover table-custom align-middle text-center">
                                        <thead>
                                            <tr>
                                                <th>Hình ảnh</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Cửa hàng</th>
                                                <th>Số lượng</th>
                                                <th>Giá (VND)</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="d" items="${orderDetails}">
                                                <tr>
                                                    <td>
                                                        <img src="<c:url value='/resources/admin/images/product/${d.image}'/>"
                                                            alt="${d.productName}" width="80" height="80">
                                                    </td>
                                                    <td class="fw-medium">${d.productName}</td>
                                                    <td>${d.shopName}</td>
                                                    <td>${d.quantity}</td>
                                                    <td>
                                                        <fmt:formatNumber value="${d.price}" type="number"
                                                            groupingUsed="true" />
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </div>

                        <!-- Nút quay lại dưới cùng -->
                        <div class="card-footer card-footer-custom text-center">
                            <a href="${pageContext.request.contextPath}/vendor/order"
                                class="btn btn-primary btn-sm px-4 py-2 btn-lift">
                                <i class="fas fa-arrow-left me-1"></i> Quay lại
                            </a>
                        </div>

                    </div>
                </div>
            </body>

            </html>