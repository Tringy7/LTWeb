<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <title> Chi tiết sản phẩm - ${product.name}</title>
                    <meta name="viewport" content="width=device-width, initial-scale=1">
                    <link rel="stylesheet" href="<c:url value='/resources/vendor/css/bootstrap.min.css'/>">
                    <link rel="stylesheet"
                        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
                    <style>
                        body {
                            margin: 0;
                            padding: 0;
                            min-height: 100vh;
                            background-color: #f8f9fa;
                        }

                        .container.mt-3 {
                            margin-top: 1.5rem !important;
                            flex-grow: 1;
                        }

                        /* Card & Header */
                        .card {
                            border-radius: 15px;
                            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
                        }

                        .card-header {
                            background: linear-gradient(135deg, #396afc, #2948ff);
                            color: #fff;
                            border-radius: 15px 15px 0 0;
                            padding: 1rem 2rem;
                        }

                        /* Product Image */
                        .product-image-container {
                            border-radius: 15px;
                            overflow: hidden;
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                        }

                        .product-image-container img {
                            width: 100%;
                            object-fit: cover;
                            transition: transform 0.3s ease-in-out;
                        }

                        .product-image-container img:hover {
                            transform: scale(1.05);
                        }

                        /* Info */
                        .info-label {
                            color: #6c757d;
                            font-size: 0.9rem;
                            margin-bottom: 0.2rem;
                        }

                        .info-value {
                            font-size: 1.1rem;
                            font-weight: 500;
                            color: #343a40;
                            padding: 0.375rem 0.75rem;
                            border: 1px solid #dee2e6;
                            border-radius: 0.25rem;
                            background-color: #fff;
                        }

                        /* Description */
                        .description-box {
                            background-color: #fff;
                            border: 1px solid #dee2e6;
                            border-radius: 0.25rem;
                            padding: 1rem;
                            white-space: pre-wrap;
                        }

                        /* Table */
                        .table-responsive table {
                            border-radius: 12px;
                            overflow: hidden;
                            background-color: #fffaf0;
                        }

                        .table-responsive table thead {
                            background: linear-gradient(135deg, #396afc, #2948ff);
                            color: #fff;
                        }

                        .table-responsive table tbody tr:hover {
                            background-color: #f0f8ff;
                        }

                        /* Image nhỏ lại */
                        .product-image-container {
                            border-radius: 15px;
                            overflow: hidden;
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                            max-height: 300px;
                            /* giảm chiều cao */
                        }

                        .product-image-container img {
                            width: 100%;
                            height: 100%;
                            object-fit: cover;
                            transition: transform 0.3s ease-in-out;
                        }

                        /* Khoảng cách bảng gần hơn với phần trên */
                        .table-responsive {
                            margin-top: 0.5rem;
                            /* giảm khoảng cách so với trước */
                        }

                        .row.g-3.mb-4 {
                            margin-top: 2rem;
                            /* đẩy xuống */
                        }

                        .btn-back {
                            background-color: #ffffff;
                            /* Nền trắng */
                            color: #2948ff;
                            /* Chữ xanh giống nền card */
                            border: 1px solid #2948ff;
                            transition: all 0.3s ease;
                        }

                        .btn-back:hover {
                            /* Chữ trắng khi hover */
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                            transform: translateY(-2px);
                        }
                    </style>
                </head>

                <body>
                    <div class="container mt-3 mb-5">
                        <div class="card">
                            <!-- Header -->
                            <div class="card-header d-flex justify-content-between align-items-center">
                                <h4 class="mb-0 d-flex align-items-center">
                                    <i class="bi bi-box-seam"></i>&nbsp;Chi tiết sản phẩm #${product.id}

                                </h4>
                                <a href="<c:url value='/vendor/product'/>" class="btn btn-back btn-sm px-3">
                                    <i class="bi bi-arrow-left"></i> Quay lại danh sách
                                </a>

                            </div>

                            <div class="card-body p-5">
                                <form:form modelAttribute="product">
                                    <form:hidden path="id" />

                                    <div class="row">
                                        <!-- Image -->
                                        <div class="col-md-5 d-flex flex-column align-items-center mb-4">

                                            <div class="product-image-container w-100 mb-4">
                                                <img src="<c:url value='/resources/admin/images/product/${product.image}'/>"
                                                    alt="Hình sản phẩm" class="img-fluid">
                                            </div>
                                            <h3 class="display-6 fw-bolder mb-4 text-dark">${product.name}</h3>
                                        </div>

                                        <!-- Info -->
                                        <div class="col-md-7 ps-md-5 border-start">

                                            <div class="row g-3 mb-4">
                                                <div class="col-md-4">
                                                    <label class="info-label">Thương hiệu</label>
                                                    <p class="info-value">${product.brand}</p>
                                                </div>
                                                <div class="col-md-4">
                                                    <label class="info-label">Danh mục</label>
                                                    <p class="info-value">${product.category}</p>
                                                </div>
                                                <div class="col-md-4">
                                                    <label class="info-label">Giới tính</label>
                                                    <p class="info-value">${product.gender}</p>
                                                </div>
                                            </div>

                                            <div class="row g-3 mb-4">
                                                <div class="col-md-6">
                                                    <label class="info-label">Màu sắc</label>
                                                    <p class="info-value">${product.color}</p>
                                                </div>
                                                <div class="col-md-6">
                                                    <label class="info-label">Giá</label>
                                                    <p class="info-value">${product.price} VND</p>
                                                </div>
                                            </div>

                                            <div class="mb-4">
                                                <label class="form-label fw-bold">Mô tả chi tiết</label>
                                                <div class="description-box text-start">${product.detailDesc}</div>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
                                <!-- Kho hàng -->
                                <div class="table-responsive">
                                    <table
                                        class="table table-hover table-bordered shadow-sm rounded text-center align-middle">
                                        <thead class="fw-bold">
                                            <tr>
                                                <th style="width:33%">Size</th>
                                                <th style="width:33%">Tồn kho</th>
                                                <th style="width:33%">Số lượng đã bán</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:set var="sizes" value="${fn:split('S,M,L,XL', ',')}" />
                                            <c:forEach var="size" items="${sizes}">
                                                <c:set var="found" value="false" />
                                                <c:forEach var="d" items="${details}">
                                                    <c:if test="${d.size eq size}">
                                                        <tr style="background-color: #fffbee;">
                                                            <td><span
                                                                    class="fw-bold text-uppercase text-secondary">${d.size}</span>
                                                            </td>
                                                            <td><span class="fw-bold text-success">${d.quantity}</span>
                                                            </td>
                                                            <td><span class="fw-bold text-danger">${d.sold}</span></td>
                                                        </tr>
                                                        <c:set var="found" value="true" />
                                                    </c:if>
                                                </c:forEach>

                                                <c:if test="${not found}">
                                                    <tr style="background-color: #fffbee;">
                                                        <td><span
                                                                class="fw-bold text-uppercase text-secondary">${size}</span>
                                                        </td>
                                                        <td><span class="fw-bold text-success">0</span></td>
                                                        <td><span class="fw-bold text-danger">0</span></td>
                                                    </tr>
                                                </c:if>
                                            </c:forEach>
                                        </tbody>

                                    </table>
                                </div>

                            </div>
                        </div>
                    </div>

                    <script src="<c:url value='/resources/vendor/js/jquery.min.js'/>"></script>
                    <script src="<c:url value='/resources/vendor/js/bootstrap.bundle.min.js'/>"></script>
                </body>

                </html>