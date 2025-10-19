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
            </head>

            <body class="bg-light">
                <div class="container py-5">
                    <div class="card shadow-lg" style="max-width: 900px; margin: auto; border-radius: 12px;">
                        <div class="card-header bg-success text-white text-center">
                            <h4 class="mb-0">Thêm sản phẩm mới</h4>
                        </div>

                        <form:form action="/vendor/product/add" method="post" modelAttribute="product"
                            enctype="multipart/form-data">
                            <div class="card-body p-4">
                                <div class="row">
                                    <!-- Cột trái: Hình ảnh -->
                                    <div class="col-md-5 text-center border-right">
                                        <label class="form-label font-weight-bold mb-2">Hình ảnh sản phẩm</label>
                                        <div class="mb-3">
                                            <img id="addProductImagePreview" src="" alt="Hình sản phẩm"
                                                class="img-fluid rounded shadow-sm border"
                                                style="width: 100%; height: 280px; object-fit: cover;">
                                        </div>
                                        <div class="custom-file" style="max-width: 250px; margin: 0 auto;">
                                            <input type="file" name="imageFile" class="custom-file-input"
                                                id="addImageFileInput">
                                            <label class="custom-file-label btn btn-success text-white text-center"
                                                for="addImageFileInput"
                                                style="border-radius: 8px; width: 100%; cursor: pointer;">
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
                                            <div class="form-group col-md-6">
                                                <label class="form-label">Thương hiệu</label>
                                                <form:input path="brand" cssClass="form-control"
                                                    placeholder="Ví dụ: Nike" />
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="form-label">Danh mục</label>
                                                <form:input path="category" cssClass="form-control"
                                                    placeholder="Ví dụ: Áo thun" />
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group col-md-6">
                                                <label class="form-label">Màu sắc</label>
                                                <form:select path="color" cssClass="form-control">
                                                    <form:option value="" label="Chọn màu" />
                                                    <form:option value="Đỏ" />
                                                    <form:option value="Xanh" />
                                                    <form:option value="Đen" />
                                                    <form:option value="Trắng" />
                                                </form:select>
                                            </div>
                                            <div class="form-group col-md-6">
                                                <label class="form-label">Giá (VND)</label>
                                                <form:input path="price" cssClass="form-control" type="number"
                                                    placeholder="Nhập giá sản phẩm" />
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
                                <button type="submit" class="btn btn-success px-4 text-white font-weight-bold">Lưu sản
                                    phẩm</button>
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