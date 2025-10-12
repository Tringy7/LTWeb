<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/product-base.css">
<link rel="stylesheet" href="/admin/css/product-form.css">

<div class="main-panel">
    <div class="content-wrapper">
        
        <!-- Breadcrumb -->
        <div class="breadcrumb-card">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="/admin/product">
                            <i class="typcn typcn-shopping-bag mr-1"></i>Quản lý sản phẩm
                        </a>
                    </li>
                    <li class="breadcrumb-item">
                        <a href="/admin/product/shop/${shop.id}">
                            Cửa hàng ${shop.shopName}
                        </a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">
                        Chỉnh sửa sản phẩm
                    </li>
                </ol>
            </nav>
        </div>
        
        <!-- Form Card -->
        <div class="form-card">
            <div class="card-header">
                <h4 class="mb-0">
                    <i class="typcn typcn-edit mr-2"></i>
                    Chỉnh sửa sản phẩm #${productUpdateDTO.id}
                </h4>
                <p class="text-muted mb-0">Cửa hàng: <strong>${shop.shopName}</strong></p>
            </div>
            
            <div class="card-body">
                <form:form method="POST" action="/admin/product/update" modelAttribute="productUpdateDTO" cssClass="edit-form">
                    <form:hidden path="id"/>
                    <form:hidden path="shopId"/>
                    
                    <div class="row">
                        <!-- Left Column -->
                        <div class="col-md-6">
                            <!-- Product Name -->
                            <div class="form-group">
                                <label for="name" class="form-label required">Tên sản phẩm</label>
                                <form:input path="name" cssClass="form-control" id="name" 
                                           placeholder="Nhập tên sản phẩm"/>
                                <form:errors path="name" cssClass="invalid-feedback d-block"/>
                            </div>
                            
                            <!-- Brand -->
                            <div class="form-group">
                                <label for="brand" class="form-label">Thương hiệu</label>
                                <form:input path="brand" cssClass="form-control" id="brand" 
                                           placeholder="Nhập thương hiệu"/>
                                <form:errors path="brand" cssClass="invalid-feedback d-block"/>
                            </div>
                            
                            <!-- Category -->
                            <div class="form-group">
                                <label for="category" class="form-label">Danh mục</label>
                                <form:input path="category" cssClass="form-control" id="category" 
                                           placeholder="Nhập danh mục"/>
                                <form:errors path="category" cssClass="invalid-feedback d-block"/>
                            </div>
                            
                            <!-- Color -->
                            <div class="form-group">
                                <label for="color" class="form-label">Màu sắc</label>
                                <form:input path="color" cssClass="form-control" id="color" 
                                           placeholder="Nhập màu sắc"/>
                                <form:errors path="color" cssClass="invalid-feedback d-block"/>
                            </div>
                        </div>
                        
                        <!-- Right Column -->
                        <div class="col-md-6">
                            <!-- Price -->
                            <div class="form-group">
                                <label for="price" class="form-label required">Giá (VNĐ)</label>
                                <form:input path="price" cssClass="form-control" id="price" type="number" 
                                           placeholder="Nhập giá sản phẩm" step="1000"/>
                                <form:errors path="price" cssClass="invalid-feedback d-block"/>
                            </div>
                            
                            <!-- Gender -->
                            <div class="form-group">
                                <label for="gender" class="form-label">Giới tính</label>
                                <form:select path="gender" cssClass="form-control" id="gender">
                                    <form:option value="">-- Chọn giới tính --</form:option>
                                    <form:option value="Nam">Nam</form:option>
                                    <form:option value="Nữ">Nữ</form:option>
                                    <form:option value="Unisex">Unisex</form:option>
                                </form:select>
                                <form:errors path="gender" cssClass="invalid-feedback d-block"/>
                            </div>
                            
                            <!-- Image -->
                            <div class="form-group">
                                <label for="image" class="form-label">Đường dẫn hình ảnh</label>
                                <form:input path="image" cssClass="form-control" id="image" 
                                           placeholder="Nhập đường dẫn hình ảnh"/>
                                <form:errors path="image" cssClass="invalid-feedback d-block"/>
                                <small class="form-text text-muted">
                                    Ví dụ: product-image.jpg (file sẽ được lưu trong thư mục /images/products/)
                                </small>
                            </div>
                            
                            <!-- Shop Info (Read-only) -->
                            <div class="form-group">
                                <label class="form-label">Cửa hàng</label>
                                <div class="form-control-plaintext border rounded p-2 bg-light">
                                    <strong>${shop.shopName}</strong>
                                    <br><small class="text-muted">${shop.ownerName} (${shop.ownerEmail})</small>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Description -->
                    <div class="row">
                        <div class="col-12">
                            <div class="form-group">
                                <label for="detailDesc" class="form-label">Mô tả chi tiết</label>
                                <form:textarea path="detailDesc" cssClass="form-control" id="detailDesc" 
                                              rows="4" placeholder="Nhập mô tả chi tiết cho sản phẩm"/>
                                <form:errors path="detailDesc" cssClass="invalid-feedback d-block"/>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <div class="form-actions">
                                <button type="submit" class="btn btn-success mr-2">
                                    <i class="typcn typcn-tick mr-1"></i> Cập nhật sản phẩm
                                </button>
                                <a href="/admin/product/${productUpdateDTO.id}" class="btn btn-info mr-2">
                                    <i class="typcn typcn-eye mr-1"></i> Xem chi tiết
                                </a>
                                <a href="/admin/product/shop/${shop.id}" class="btn btn-secondary">
                                    <i class="typcn typcn-arrow-left mr-1"></i> Hủy và quay lại
                                </a>
                            </div>
                        </div>
                    </div>
                </form:form>
            </div>
        </div>
        
    </div>
</div>

<!-- Include Base Scripts -->
<script src="/admin/vendors/js/vendor.bundle.base.js"></script>
<script src="/admin/js/off-canvas.js"></script>
<script src="/admin/js/hoverable-collapse.js"></script>
<script src="/admin/js/template.js"></script>
<script src="/admin/js/todolist.js"></script>

<!-- Form validation and interaction scripts -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add any client-side validation or form interaction here if needed
        // For pure Spring Boot MVC, keep it minimal
        
        // Format price input
        const priceInput = document.getElementById('price');
        if (priceInput) {
            priceInput.addEventListener('input', function() {
                // Remove any non-numeric characters except decimal point
                this.value = this.value.replace(/[^0-9.]/g, '');
            });
        }
    });
</script>
