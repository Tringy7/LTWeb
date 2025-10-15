<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

                <!DOCTYPE html>
                <html lang="vi">

                <head>
                    <meta charset="UTF-8">
                    <title>Chỉnh sửa sản phẩm</title>
                    <link rel="stylesheet" href="<c:url value='/resources/vendor/bootstrap/css/bootstrap.min.css'/>">
                    <link rel="stylesheet" href="<c:url value='/resources/vendor/fontawesome/css/all.min.css'/>">
                    <style>
                        body {
                            background-color: #f8f9fa;
                        }

                        .card {
                            border-radius: 15px;
                            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
                        }

                        .card-header {
                            border-radius: 15px 15px 0 0;
                            background: linear-gradient(135deg, #f59d00, #f0ad4e);
                            color: white;
                            font-weight: 600;
                            letter-spacing: 0.5px;
                        }

                        .form-label {
                            font-weight: 500;
                        }

                        .product-image-container img {
                            border-radius: 10px;
                            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                            transition: transform 0.3s ease-in-out;
                        }

                        .product-image-container img:hover {
                            transform: scale(1.05);
                        }

                        .table-container table {
                            border-radius: 12px;
                            overflow: hidden;
                            background-color: #fffaf0;
                        }

                        .table-container table thead {
                            background: linear-gradient(135deg, #f59d00, #f0ad4e);
                            color: white;
                        }

                        .table-container table tbody tr {
                            background-color: #fffbee;
                        }

                        .table-container table tbody tr:hover {
                            background-color: #fff2cc;
                        }

                        .table-container input {
                            border-radius: 5px;
                        }

                        .card-footer .btn {
                            min-width: 120px;
                            transition: all 0.3s ease;
                        }

                        .card-footer .btn-warning:hover {
                            transform: translateY(-2px);
                        }

                        .card-footer .btn-secondary:hover {
                            transform: translateY(-2px);
                        }

                        .mb-custom {
                            margin-bottom: 1.25rem;
                        }
                    </style>
                </head>

                <body>
                    <div class="container py-4">
                        <div class="card shadow-lg" style="max-width: 950px; margin: auto;">
                            <div class="card-header text-center">
                                <h4 class="mb-0"><i class="fas fa-edit me-2"></i>Chỉnh sửa sản phẩm</h4>
                            </div>

                            <form:form action="${pageContext.request.contextPath}/vendor/product/update" method="post"
                                modelAttribute="product">
                                <form:hidden path="id" />

                                <div class="card-body p-4">
                                    <div class="row g-4">
                                        <!-- Cột trái: Hình ảnh -->
                                        <div class="col-md-5 text-center">
                                            <label class="form-label fw-bold mb-2">Hình ảnh sản phẩm</label>
                                            <div class="product-image-container mb-3">
                                                <img id="productImagePreview"
                                                    src="<c:url value='/resources/admin/images/product/${product.image}'/>"
                                                    alt="Hình sản phẩm" class="img-fluid"
                                                    style="width: 100%; height: 280px; object-fit: cover;">
                                            </div>
                                        </div>

                                        <!-- Cột phải: Thông tin -->
                                        <div class="col-md-7">
                                            <div class="row g-3">
                                                <!-- Tên sản phẩm -->
                                                <div class="col-md-6 mb-custom">
                                                    <label class="form-label">Tên sản phẩm</label>
                                                    <form:input path="name" cssClass="form-control" />
                                                </div>
                                                <!-- Giới tính -->
                                                <div class="col-md-6 mb-custom">
                                                    <label class="form-label">Giới tính</label>
                                                    <form:input path="gender" cssClass="form-control" />
                                                </div>
                                                <!-- Thương hiệu -->
                                                <div class="col-md-6 mb-custom">
                                                    <label class="form-label">Thương hiệu</label>
                                                    <form:input path="brand" cssClass="form-control" />
                                                </div>
                                                <!-- Danh mục -->
                                                <div class="col-md-6 mb-custom">
                                                    <label class="form-label">Danh mục</label>
                                                    <form:input path="category" cssClass="form-control" />
                                                </div>
                                                <!-- Màu sắc -->
                                                <div class="col-md-6 mb-custom">
                                                    <label class="form-label">Màu sắc</label>
                                                    <form:select path="color" cssClass="form-control">
                                                        <form:option value="" label="Chọn màu" />
                                                        <form:option value="Đỏ" />
                                                        <form:option value="Xanh" />
                                                        <form:option value="Đen" />
                                                        <form:option value="Trắng" />
                                                    </form:select>
                                                </div>
                                                <!-- Giá -->
                                                <div class="col-md-6 mb-custom">
                                                    <label class="form-label">Giá (VND)</label>
                                                    <form:input path="price" cssClass="form-control" type="number" />
                                                </div>
                                            </div>

                                            <div class="mb-3 mt-3">
                                                <label class="form-label">Mô tả chi tiết</label>
                                                <form:textarea path="detailDesc" cssClass="form-control" rows="3" />
                                            </div>
                                        </div>
                                    </div>

                                    <!-- BẢNG SIZE & SỐ LƯỢNG -->
                                    <div class="table-container mt-4">
                                        <h3 class="text-center text-secondary mb-3">
                                            <i class="fas fa-ruler"></i> Size & Số lượng
                                        </h3>

                                        <div class="table-responsive">
                                            <table
                                                class="table table-hover table-bordered shadow-sm rounded text-center align-middle">
                                                <thead class="fw-bold"
                                                    style="background: linear-gradient(135deg, #f59d00, #f0ad4e); color: white;">
                                                    <tr>
                                                        <th style="width:50%">Size</th>
                                                        <th style="width:50%">Số lượng</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:set var="sizes" value="${fn:split('S,M,L,XL', ',')}" />
                                                    <c:forEach var="size" items="${sizes}">
                                                        <c:set var="found" value="false" />
                                                        <c:forEach var="d" items="${details}">
                                                            <c:if test="${d.size eq size}">
                                                                <tr style="background-color: #fffbee;">
                                                                    <td>
                                                                        <span
                                                                            class="fw-bold text-uppercase text-secondary">${d.size}</span>
                                                                        <input type="hidden" name="detailId[]"
                                                                            value="${d.id}" />
                                                                    </td>
                                                                    <td>
                                                                        <input type="number" name="quantity[]"
                                                                            value="${d.quantity}"
                                                                            class="form-control text-center fw-bold bg-white border"
                                                                            min="0" />
                                                                    </td>
                                                                </tr>
                                                                <c:set var="found" value="true" />
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:if test="${not found}">
                                                            <tr style="background-color: #fffbee;">
                                                                <td><span
                                                                        class="fw-bold text-uppercase text-secondary">${size}</span>
                                                                </td>
                                                                <td>
                                                                    <input type="number" name="quantity[]" value="0"
                                                                        class="form-control text-center fw-bold bg-white border"
                                                                        min="0" />
                                                                </td>
                                                            </tr>
                                                        </c:if>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>

                                </div>

                                <div class="card-footer text-center">
                                    <a href="<c:url value='/vendor/product'/>"
                                        class="btn btn-secondary px-4 me-3">Hủy</a>
                                    <button type="submit" class="btn btn-warning px-4 text-white fw-bold">Cập
                                        nhật</button>
                                </div>
                            </form:form>
                        </div>
                    </div>

                    <script src="<c:url value='/resources/vendor/jquery/jquery.min.js'/>"></script>
                    <script src="<c:url value='/resources/vendor/bootstrap/js/bootstrap.bundle.min.js'/>"></script>

                    <script>
                        $(document).ready(function () {
                            $('#imageFileInput').on('change', function (event) {
                                const file = event.target.files[0];
                                if (file) {
                                    $('#productImagePreview').attr('src', URL.createObjectURL(file));
                                }
                            });
                        });
                    </script>
                </body>

                </html>