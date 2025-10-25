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
                    body {
                        background: linear-gradient(135deg, #c3ecb2, #7ee8fa);
                        font-family: 'Segoe UI', sans-serif;
                    }

                    .card {
                        border-radius: 16px;
                        overflow: hidden;
                        background: #ffffffee;
                        backdrop-filter: blur(6px);
                    }

                    .card-header {
                        background: linear-gradient(135deg, #00b09b, #96c93d);
                        border-bottom: none;
                        font-weight: bold;
                        letter-spacing: 1px;
                    }

                    .form-control,
                    select {
                        border-radius: 10px;
                        border: 1px solid #ccc;
                        transition: all 0.3s ease;
                    }

                    .form-control:focus {
                        border-color: #00b09b;
                        box-shadow: 0 0 5px rgba(0, 176, 155, 0.5);
                    }

                    .btn-success {
                        background: linear-gradient(135deg, #00b09b, #96c93d);
                        border: none;
                        border-radius: 10px;
                        transition: 0.3s;
                    }

                    .btn-success:hover {
                        background: linear-gradient(135deg, #96c93d, #00b09b);
                        transform: scale(1.05);
                    }

                    .btn-secondary {
                        border-radius: 10px;
                        transition: 0.3s;
                    }

                    .btn-secondary:hover {
                        background-color: #6c757d;
                        transform: scale(1.05);
                    }

                    .form-label {
                        font-weight: 600;
                    }

                    .img-preview-container {
                        border: 2px dashed #96c93d;
                        border-radius: 12px;
                        transition: 0.3s;
                    }

                    .img-preview-container:hover {
                        border-color: #00b09b;
                        transform: scale(1.02);
                    }

                    input.is-invalid,
                    select.is-invalid,
                    textarea.is-invalid {
                        border-color: #dc3545;
                        box-shadow: 0 0 4px rgba(220, 53, 69, 0.5);
                    }
                </style>
            </head>

            <body>
                <div class="container py-5">
                    <div class="card shadow-lg" style="max-width: 900px; margin: auto;">
                        <div class="card-header text-white text-center py-3">
                            <h4 class="mb-0"><i class="fas fa-plus-circle"></i> Thêm sản phẩm mới</h4>
                        </div>

                        <form:form action="/vendor/product/add" method="post" modelAttribute="product"
                            enctype="multipart/form-data">
                            <div class="card-body p-4">
                                <div class="row">
                                    <!-- Cột trái: Hình ảnh -->
                                    <div class="col-md-5 text-center border-right">
                                        <label class="form-label mb-2">Hình ảnh sản phẩm</label>
                                        <div class="mb-3 img-preview-container p-2">
                                            <img id="addProductImagePreview" src="" class="img-fluid rounded shadow-sm"
                                                style="width: 100%; height: 280px; object-fit: cover;">
                                        </div>

                                        <!-- Giữ nguyên phần chọn file -->
                                        <div class="custom-file" style="max-width: 250px; margin: 0 auto;">
                                            <input type="file" name="imageFile" class="custom-file-input"
                                                id="addImageFileInput">
                                            <label class="custom-file-label text-center" for="addImageFileInput">
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

                                        <!-- 3 ô nằm cùng hàng -->
                                        <div class="form-row">
                                            <div class="form-group col-md-3">
                                                <label class="form-label">Màu sắc</label>
                                                <form:select path="color" cssClass="form-control">
                                                    <form:option value="" label="Chọn màu" />
                                                    <form:option value="Đỏ" />
                                                    <form:option value="Xanh" />
                                                    <form:option value="Đen" />
                                                    <form:option value="Trắng" />
                                                </form:select>
                                            </div>

                                            <div class="form-group col-md-4">
                                                <label class="form-label">Giới tính</label>
                                                <form:select path="gender" cssClass="form-control">
                                                    <form:option value="" label="Chọn giới tính" />
                                                    <form:option value="Nam" />
                                                    <form:option value="Nữ" />
                                                    <form:option value="Khác" />
                                                </form:select>
                                            </div>

                                            <div class="form-group col-md-5">
                                                <label class="form-label">Giá (VND)</label>
                                                <form:input path="price" cssClass="form-control" type="number"
                                                    step="10000" placeholder="Nhập giá sản phẩm" />
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

                            <div class="card-footer text-center py-3">
                                <a href="<c:url value='/vendor/product'/>" class="btn btn-secondary px-4 mx-2">Hủy</a>
                                <button type="submit" class="btn btn-success px-4 mx-2 text-white font-weight-bold">
                                    <i class="fas fa-save"></i> Lưu sản phẩm
                                </button>
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

                <script>
                    // ===== VALIDATION FORM =====
                    document.querySelector("form").addEventListener("submit", function (e) {
                        let isValid = true;

                        // Xóa lỗi cũ
                        document.querySelectorAll(".text-danger").forEach(el => el.remove());
                        document.querySelectorAll(".is-invalid").forEach(el => el.classList.remove("is-invalid"));

                        const fields = {
                            name: document.querySelector("[name='name']"),
                            brand: document.querySelector("[name='brand']"),
                            category: document.querySelector("[name='category']"),
                            color: document.querySelector("[name='color']"),
                            gender: document.querySelector("[name='gender']"),
                            price: document.querySelector("[name='price']"),
                            detailDesc: document.querySelector("[name='detailDesc']"),
                            image: document.querySelector("#addImageFileInput")
                        };

                        // Hàm tạo thông báo lỗi
                        function showError(input, message) {
                            const error = document.createElement("div");
                            error.className = "text-danger mt-1 small";
                            error.textContent = message;
                            input.classList.add("is-invalid");  // ✅ thêm hiệu ứng viền đỏ
                            input.insertAdjacentElement("afterend", error);
                            isValid = false;
                        }

                        // Kiểm tra từng trường
                        if (!fields.name.value.trim()) showError(fields.name, "Tên sản phẩm không được để trống.");
                        else if (fields.name.value.length > 100) showError(fields.name, "Tên sản phẩm không được vượt quá 100 ký tự.");

                        if (!fields.brand.value.trim()) showError(fields.brand, "Thương hiệu không được để trống.");
                        else if (fields.brand.value.length > 50) showError(fields.brand, "Thương hiệu không được vượt quá 50 ký tự.");

                        if (!fields.category.value.trim()) showError(fields.category, "Danh mục không được để trống.");

                        if (!fields.color.value) showError(fields.color, "Vui lòng chọn màu sắc.");

                        if (!fields.gender.value) showError(fields.gender, "Vui lòng chọn giới tính.");

                        if (!fields.price.value.trim()) showError(fields.price, "Giá sản phẩm không được để trống.");
                        else if (isNaN(fields.price.value) || fields.price.value <= 0) showError(fields.price, "Giá sản phẩm phải là số dương hợp lệ.");

                        if (!fields.detailDesc.value.trim()) showError(fields.detailDesc, "Mô tả không được để trống.");
                        else if (fields.detailDesc.value.length > 1000) showError(fields.detailDesc, "Mô tả không được vượt quá 1000 ký tự.");

                        if (!fields.image.files[0]) {
                            const fileInputContainer = fields.image.closest(".custom-file");
                            const error = document.createElement("div");
                            error.className = "text-danger mt-1 small text-center";
                            error.textContent = "Vui lòng chọn hình ảnh sản phẩm.";
                            fileInputContainer.insertAdjacentElement("afterend", error);
                            fields.image.classList.add("is-invalid");  // ✅ thêm hiệu ứng viền đỏ cho input file
                            isValid = false;
                        }

                        if (!isValid) e.preventDefault();
                    });
                </script>


            </body>

            </html>