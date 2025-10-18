<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/product-base.css">
<link rel="stylesheet" href="/admin/css/product-detail.css">

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
                        <a href="/admin/product/shop/${product.shopId}">
                            Cửa hàng ${product.shopName}
                        </a>
                    </li>
                    <li class="breadcrumb-item active" aria-current="page">
                        Chi tiết sản phẩm
                    </li>
                </ol>
            </nav>
        </div>
        
        <!-- Product Detail Card -->
        <div class="detail-card">
            <div class="card-header">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h4 class="mb-0">
                            <i class="typcn typcn-shopping-bag mr-2"></i>
                            Chi tiết sản phẩm #${product.id}
                        </h4>
                    </div>
                    <div class="col-md-4 text-md-right">
                        <a href="/admin/product/${product.id}/edit" class="btn btn-warning">
                            <i class="typcn typcn-edit mr-1"></i> Chỉnh sửa
                        </a>
                        <a href="/admin/product/shop/${product.shopId}" class="btn btn-outline-secondary">
                            <i class="typcn typcn-arrow-left mr-1"></i> Quay lại
                        </a>
                    </div>
                </div>
            </div>
            
            <div class="card-body">
                <div class="row">
                    <!-- Product Image -->
                    <div class="col-md-4">
                        <div class="product-image-container">
                            <c:choose>
                                <c:when test="${not empty product.image}">
                                    <img src="/admin/images/product/${product.image}" alt="${product.name}" 
                                         class="img-fluid product-detail-image">
                                </c:when>
                                <c:otherwise>
                                    <div class="no-image-placeholder">
                                        <i class="typcn typcn-image"></i>
                                        <p>Chưa có hình ảnh</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    <!-- Product Information -->
                    <div class="col-md-8">
                        <div class="product-info">
                            <table class="table table-bordered">
                                <tbody>
                                    <tr>
                                        <td class="info-label">ID sản phẩm</td>
                                        <td><strong>#${product.id}</strong></td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Tên sản phẩm</td>
                                        <td><strong class="text-primary">${product.name}</strong></td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Thương hiệu</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.brand}">
                                                    ${product.brand}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa có thông tin</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Danh mục</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.category}">
                                                    <span class="badge badge-light">${product.category}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa có thông tin</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Màu sắc</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.color}">
                                                    ${product.color}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa có thông tin</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Giới tính</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.gender}">
                                                    <span class="badge badge-secondary">${product.gender}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa có thông tin</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Giá</td>
                                        <td>
                                            <h4 class="text-success mb-0">
                                                <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/> VNĐ
                                            </h4>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="info-label">Cửa hàng</td>
                                        <td>
                                            <a href="/admin/product/shop/${product.shopId}" class="text-decoration-none">
                                                <strong>${product.shopName}</strong>
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <!-- Product Description -->
                <c:if test="${not empty product.detailDesc}">
                    <div class="row mt-4">
                        <div class="col-12">
                            <h5>Mô tả chi tiết</h5>
                            <div class="description-box">
                                <p>${product.detailDesc}</p>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Action Buttons -->
                <div class="row mt-4">
                    <div class="col-12 text-center">
                        <a href="/admin/product/${product.id}/edit" class="btn btn-warning mr-2">
                            <i class="typcn typcn-edit mr-1"></i> Chỉnh sửa sản phẩm
                        </a>
                        <form action="/admin/product/${product.id}/delete" method="POST" style="display: inline;" 
                              onsubmit="return confirmDelete('${product.name}')">
                            <button type="submit" class="btn btn-danger mr-2">
                                <i class="typcn typcn-trash mr-1"></i> Xóa sản phẩm
                            </button>
                        </form>
                        <a href="/admin/product/shop/${product.shopId}" class="btn btn-secondary">
                            <i class="typcn typcn-arrow-left mr-1"></i> Quay lại danh sách
                        </a>
                    </div>
                </div>
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

<!-- Include JavaScript for confirmation dialogs -->
<script>
    function confirmDelete(productName) {
        return confirm('Bạn có chắc chắn muốn xóa sản phẩm "' + productName + '"?\nHành động này không thể hoàn tác.');
    }
</script>