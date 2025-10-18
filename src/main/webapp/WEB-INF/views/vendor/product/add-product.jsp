<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <meta charset="UTF-8">
                <title>Thêm sản phẩm mới</title>
                <link rel="stylesheet" href="<c:url value='/resources/vendor/bootstrap/css/bootstrap.min.css'/>">
                <link rel="stylesheet" href="<c:url value='/resources/vendor/fontawesome/css/all.min.css'/>">
                <style>
                    /* Card bo tròn và bóng */
                    .card-custom {
                        border-radius: 15px;
                        box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
                        overflow: hidden;
                        transition: transform 0.2s ease-in-out;
                    }

                    .card-custom:hover {
                        transform: translateY(-3px);
                    }

                    .card-header-custom {
                        background: linear-gradient(90deg, #4e73df 0%, #1cc88a 100%);
                        color: #fff;
                        font-weight: bold;
                        font-size: 1.3rem;
                        text-align: center;
                    }

                    /* Input, select, textarea bo tròn */
                    .form-control {
                        border-radius: 10px;
                    }

                    .form-select {
                        border-radius: 10px;
                    }

                    /* Buttons gradient & hover */
                    .btn-gradient {
                        background: linear-gradient(45deg, #1cc88a, #4e73df);
                        color: #fff;
                        font-weight: bold;
                        border: none;
                        transition: transform 0.2s ease, box-shadow 0.2s ease;
                    }

                    .btn-gradient:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.25);
                        color: #fff;
                    }

                    .btn-secondary {
                        border-radius: 10px;
                        transition: transform 0.2s ease, box-shadow 0.2s ease;
                    }

                    .btn-secondary:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                    }

                    /* Hình ảnh sản phẩm */
                    #addProductImagePreview {
                        border-radius: 12px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                    }

                    /* Label file upload */
                    .custom-file-label {
                        cursor: pointer;
                        border-radius: 8px;
                        width: 100%;
                    }
                </style>
            </head>

            <body class="bg-light">
                <div class="container py-5">
                    <div class="card card-custom" style="max-width: 900px; margin: auto;">
                        <div class="card-header card-header-custom">
                            <h4 class="mb-0">Thêm sản phẩm mới</h4>
                        </div>

                        <form:form action="/vendor/product/add" method="post" modelAttribute="product"
                            enctype="multipart/form-data">
                            <div class="card-body p-4">
                                <div class="row">
                                    <!-- Cột trái: Hình ảnh -->
                                    <div class="col-md-5 text-center border-end">
                                        <label class="form-label fw-bold mb-2">Hình ảnh sản phẩm</label>
                                        <div class="mb-3">
                                            <img id="addProductImagePreview" src="" class="img-fluid shadow-sm border"
                                                style="width: 100%; height: 280px; object-fit: cover;">
                                        </div>
                                        <div class="custom-file" style="max-width: 250px; margin: 0 auto;">
                                            <input type="file" name="imageFile" class="custom-file-input"
                                                id="addImageFileInput">
                                            <label class="custom-file-label btn btn-success text-white text-center"
                                                for="addImageFileInput">
                                                <i class="fas fa-upload"></i> Chọn hình ảnh
                                            </label>
                                        </div>
                                    </div>

                                    <!-- Cột phải: Thông tin -->
                                    <div class="col-md-7">
                                        <div class="mb-3">
                                            <label class="form-label">Tên sản phẩm</label>
                                            <form:input path="name" cssClass="form-control"
                                                placeholder="Nhập tên sản phẩm" />
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group col-md-6 mb-3">
                                                <label class="form-label">Thương hiệu</label>
                                                <form:input path="brand" cssClass="form-control"
                                                    placeholder="Ví dụ: Nike" />
                                            </div>
                                            <div class="form-group col-md-6 mb-3">
                                                <label class="form-label">Danh mục</label>
                                                <form:input path="category" cssClass="form-control"
                                                    placeholder="Ví dụ: Áo thun" />
                                            </div>
                                        </div>

                                        <div class="row">
                                            <!-- Giá chiếm nửa -->
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Giá (VND)</label>
                                                <form:input path="price" cssClass="form-control form-control-lg"
                                                    type="number" placeholder="Nhập giá sản phẩm" />
                                            </div>

                                            <!-- Màu sắc và Giới tính chiếm nửa còn lại, nằm ngang -->
                                            <div class="col-md-6">
                                                <div class="row">
                                                    <div class="col-md-6 mb-3">
                                                        <label class="form-label">Màu sắc</label>
                                                        <form:select path="color" cssClass="form-select form-select-lg">
                                                            <form:option value="" label="Chọn màu" />
                                                            <form:option value="Đỏ" />
                                                            <form:option value="Xanh" />
                                                            <form:option value="Đen" />
                                                            <form:option value="Trắng" />
                                                        </form:select>
                                                    </div>
                                                    <div class="col-md-6 mb-3">
                                                        <label class="form-label">Giới tính</label>
                                                        <form:select path="gender"
                                                            cssClass="form-select form-select-lg">
                                                            <form:option value="" label="Chọn giới tính" />
                                                            <form:option value="Nam" />
                                                            <form:option value="Nữ" />
                                                            <form:option value="Unisex" />
                                                        </form:select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>


                                        <div class="mb-3">
                                            <label class="form-label">Mô tả chi tiết</label>
                                            <form:textarea path="detailDesc" cssClass="form-control" rows="3"
                                                placeholder="Nhập mô tả sản phẩm..." />
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="card-footer text-center">
                                <a href="<c:url value='/vendor/product'/>" class="btn btn-secondary px-4">Hủy</a>
                                <button type="submit" class="btn btn-gradient px-4">Lưu sản phẩm</button>
                            </div>
                        </form:form>
                    </div>
                </div>

                <script src="<c:url value='/resources/vendor/jquery/jquery.min.js'/>"></script>
                <script src="<c:url value='/resources/vendor/bootstrap/js/bootstrap.bundle.min.js'/>"></script>
                <script>
                    // Hiển thị preview ảnh
                    document.getElementById('addImageFileInput').addEventListener('change', function (event) {
                        const file = event.target.files[0];
                        if (file) {
                            document.getElementById('addProductImagePreview').src = URL.createObjectURL(file);
                        }
                    });
                </script>
            </body>

            </html>