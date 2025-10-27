<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!-- Include CSS Files -->
            <link rel="stylesheet" href="/admin/css/product-base.css">
            <link rel="stylesheet" href="/admin/css/product-search.css">
            <link rel="stylesheet" href="/admin/css/product-table.css">

<<<<<<< HEAD
            <div class="main-panel">
                <div class="content-wrapper">

                    <!-- Flash Messages -->
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="typcn typcn-tick mr-2"></i>
                            ${success}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
=======
<div class="main-panel">
    <div class="content-wrapper">
        
        <!-- Flash Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="typcn typcn-tick mr-2"></i>
                ${success}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="typcn typcn-warning mr-2"></i>
                ${error}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        
        <!-- Shop Info Card -->
        <div class="search-card">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h4 class="mb-2">
                        <i class="typcn typcn-shopping-bag mr-2"></i>
                        Sản phẩm của cửa hàng: <strong>${shop.shopName}</strong>
                    </h4>
                    <p class="text-muted mb-0">
                        <i class="typcn typcn-user mr-1"></i> Chủ cửa hàng: ${shop.ownerName} (${shop.ownerEmail})
                         <c:set var="dateTime" value="${shop.createdAt}" />
                                <c:if test="${not empty dateTime}">
                                    ${dateTime.dayOfMonth}/${dateTime.monthValue}/${dateTime.year}
                                    <c:set var="minuteValue" value="${dateTime.minute}" />
                                    ${dateTime.hour}:${minuteValue lt 10 ? '0' : ''}${minuteValue}
                                </c:if>
                    </p>
                </div>
                <div class="col-md-4 text-md-right">
                    <a href="/admin/product" class="btn btn-outline-secondary">
                        <i class="typcn typcn-arrow-left mr-1"></i> Quay lại danh sách
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Search Card -->
        <div class="search-card">
            <form method="GET" action="/admin/product/shop/${shop.id}" class="search-form">
                <div class="row align-items-end">
                    <div class="col-md-6">
                        <label for="keyword" class="form-label">Tìm kiếm sản phẩm</label>
                        <input type="text" name="keyword" value="${keyword}" class="form-control" 
                               placeholder="Tên sản phẩm, thương hiệu, danh mục..." id="keyword"/>
                    </div>
                    
                    <div class="col-md-6">
                        <button type="submit" class="btn btn-light">
                            <i class="typcn typcn-zoom mr-1"></i> Tìm kiếm
                        </button>
                        <a href="/admin/product/shop/${shop.id}" class="btn btn-outline-light">
                            <i class="typcn typcn-refresh mr-1"></i> Làm mới
                        </a>
                    </div>
                </div>
            </form>
        </div>
        
        <!-- Statistics -->
        <div class="stats-card">
            <div class="row">
                <div class="col-md-6">
                    <h6 class="mb-1">Tổng số sản phẩm</h6>
                    <h3 class="text-primary mb-0">${products.size()}</h3>
                </div>
                <div class="col-md-6 text-md-right">
                    <c:if test="${not empty keyword}">
                        <span class="badge badge-info">Kết quả tìm kiếm</span>
>>>>>>> anhvuDev
                    </c:if>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="typcn typcn-warning mr-2"></i>
                            ${error}
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                    </c:if>

                    <!-- Shop Info Card -->
                    <div class="search-card">
                        <div class="row align-items-center">
                            <div class="col-md-8">
                                <h4 class="mb-2">
                                    <i class="typcn typcn-shopping-bag mr-2"></i>
                                    Sản phẩm của cửa hàng: <strong>${shop.shopName}</strong>
                                </h4>
                                <p class="text-muted mb-0">
                                    <i class="typcn typcn-user mr-1"></i> Chủ cửa hàng: ${shop.ownerName}
                                    (${shop.ownerEmail})
                                    <c:set var="dateTime" value="${shop.createdAt}" />
                                    <c:if test="${not empty dateTime}">
                                        ${dateTime.dayOfMonth}/${dateTime.monthValue}/${dateTime.year}
                                        <c:set var="minuteValue" value="${dateTime.minute}" />
                                        ${dateTime.hour}:${minuteValue lt 10 ? '0' : ''}${minuteValue}
                                    </c:if>
                                </p>
                            </div>
                            <div class="col-md-4 text-md-right">
                                <a href="/admin/product" class="btn btn-outline-secondary">
                                    <i class="typcn typcn-arrow-left mr-1"></i> Quay lại danh sách
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Search Card -->
                    <div class="search-card">
                        <form method="GET" action="/admin/product/shop/${shop.id}" class="search-form">
                            <div class="row align-items-end">
                                <div class="col-md-6">
                                    <label for="keyword" class="form-label">Tìm kiếm sản phẩm</label>
                                    <input type="text" name="keyword" value="${keyword}" class="form-control"
                                        placeholder="Tên sản phẩm, thương hiệu, danh mục..." id="keyword" />
                                </div>

                                <div class="col-md-6">
                                    <button type="submit" class="btn btn-light">
                                        <i class="typcn typcn-zoom mr-1"></i> Tìm kiếm
                                    </button>
                                    <a href="/admin/product/shop/${shop.id}" class="btn btn-outline-light">
                                        <i class="typcn typcn-refresh mr-1"></i> Làm mới
                                    </a>
                                </div>
                            </div>
                        </form>
                    </div>

                    <!-- Statistics -->
                    <div class="stats-card">
                        <div class="row">
                            <div class="col-md-6">
                                <h6 class="mb-1">Tổng số sản phẩm</h6>
                                <h3 class="text-primary mb-0">${products.size()}</h3>
                            </div>
                            <div class="col-md-6 text-md-right">
                                <c:if test="${not empty keyword}">
                                    <span class="badge badge-info">Kết quả tìm kiếm</span>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Search Result Info -->
                    <c:if test="${not empty keyword}">
                        <div class="search-result-info">
                            <i class="typcn typcn-info mr-1"></i>
                            Tìm thấy ${products.size()} sản phẩm với từ khóa "<strong>${keyword}</strong>"
                        </div>
                    </c:if>

                    <!-- Products Table -->
                    <div class="table-container">
                        <c:choose>
                            <c:when test="${not empty products}">
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Hình ảnh</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Thương hiệu</th>
                                                <th>Danh mục</th>
                                                <th>Màu sắc</th>
                                                <th>Giá (VNĐ)</th>
                                                <th>Giới tính</th>
                                                <th class="text-center">Hành động</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="product" items="${products}" varStatus="status">
                                                <tr>
                                                    <td><strong>#${product.id}</strong></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty product.image}">
                                                                <img src="/admin/images/product/${product.image}"
                                                                    alt="Product Image" class="product-image"
                                                                    style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="product-image-placeholder"
                                                                    style="width: 50px; height: 50px; background-color: #f8f9fa; border: 1px solid #dee2e6; border-radius: 4px; display: flex; align-items: center; justify-content: center;">
                                                                    <i class="typcn typcn-image text-muted"></i>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="font-weight-bold">${product.name}</div>
                                                        <c:if test="${not empty product.detailDesc}">
                                                            <small class="text-muted">
                                                                ${product.detailDesc.length() > 30 ?
                                                                product.detailDesc.substring(0, 30).concat('...') :
                                                                product.detailDesc}
                                                            </small>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty product.brand}">
                                                                ${product.brand}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa có</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty product.category}">
                                                                <span
                                                                    class="badge badge-light">${product.category}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa có</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty product.color}">
                                                                ${product.color}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa có</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <span class="font-weight-bold text-primary">
                                                            <fmt:formatNumber value="${product.price}" type="number"
                                                                maxFractionDigits="0" />
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty product.gender}">
                                                                <span
                                                                    class="badge badge-secondary">${product.gender}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa có</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center">
                                                        <div class="action-buttons">
                                                            <!-- View Product -->
                                                            <a href="/admin/product/${product.id}"
                                                                class="btn btn-sm btn-outline-info"
                                                                title="Xem chi tiết">
                                                                <i class="typcn typcn-eye"></i>
                                                            </a>

                                                            <!-- Edit Product -->
                                                            <a href="/admin/product/${product.id}/edit"
                                                                class="btn btn-sm btn-outline-warning"
                                                                title="Chỉnh sửa">
                                                                <i class="typcn typcn-edit"></i>
                                                            </a>

                                                            <!-- Delete Product -->
                                                            <form action="/admin/product/${product.id}/delete"
                                                                method="POST" style="display: inline;"
                                                                onsubmit="return confirmDelete('${product.name}')">
                                                                <button type="submit"
                                                                    class="btn btn-sm btn-outline-danger" title="Xóa">
                                                                    <i class="typcn typcn-trash"></i>
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="no-results">
                                    <i class="typcn typcn-shopping-bag"></i>
                                    <h5>Không tìm thấy sản phẩm nào</h5>
                                    <p class="text-muted">
                                        <c:choose>
                                            <c:when test="${not empty keyword}">
                                                Thử thay đổi từ khóa tìm kiếm.
                                            </c:when>
                                            <c:otherwise>
                                                Cửa hàng này chưa có sản phẩm nào.
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <a href="/admin/product/shop/${shop.id}" class="btn btn-outline-primary">
                                        <i class="typcn typcn-refresh mr-1"></i> Làm mới
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                </div>
            </div>
<<<<<<< HEAD
=======
        </div>
        
        <!-- Search Result Info -->
        <c:if test="${not empty keyword}">
            <div class="search-result-info">
                <i class="typcn typcn-info mr-1"></i>
                Tìm thấy ${products.size()} sản phẩm với từ khóa "<strong>${keyword}</strong>"
            </div>
        </c:if>
        
        <!-- Products Table -->
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty products}">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Hình ảnh</th>
                                    <th>Tên sản phẩm</th>
                                    <th>Thương hiệu</th>
                                    <th>Danh mục</th>
                                    <th>Màu sắc</th>
                                    <th>Giá (VNĐ)</th>
                                    <th>Giới tính</th>
                                    <th>Trạng thái</th>
                                    <th class="text-center">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${products}" varStatus="status">
                                    <tr>
                                        <td><strong>#${product.id}</strong></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.image}">
                                                    <img src="/admin/images/product/${product.image}" alt="Product Image" 
                                                         class="product-image" style="width: 50px; height: 50px; object-fit: cover; border-radius: 4px;">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="product-image-placeholder" 
                                                         style="width: 50px; height: 50px; background-color: #f8f9fa; border: 1px solid #dee2e6; border-radius: 4px; display: flex; align-items: center; justify-content: center;">
                                                        <i class="typcn typcn-image text-muted"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="font-weight-bold">${product.name}</div>
                                            <c:if test="${not empty product.detailDesc}">
                                                <small class="text-muted">
                                                    ${product.detailDesc.length() > 30 ? product.detailDesc.substring(0, 30).concat('...') : product.detailDesc}
                                                </small>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.brand}">
                                                    ${product.brand}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa có</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.category}">
                                                    <span class="badge badge-light">${product.category}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa có</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.color}">
                                                    ${product.color}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa có</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <span class="font-weight-bold text-primary">
                                                <fmt:formatNumber value="${product.price}" type="number" maxFractionDigits="0"/>
                                            </span>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty product.gender}">
                                                    <span class="badge badge-secondary">${product.gender}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa có</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${product.status == 'ACTIVE'}">
                                                    <span class="badge badge-success">Hoạt động</span>
                                                </c:when>
                                                <c:when test="${product.status == 'HIDDEN'}">
                                                    <span class="badge badge-warning">Đã ẩn</span>
                                                </c:when>
                                                <c:when test="${product.status == 'LOCKED'}">
                                                    <span class="badge badge-danger">Bị khóa</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge badge-secondary">Không xác định</span>
                                                </c:otherwise>
                                            </c:choose>
                                            <c:if test="${not empty product.violationType}">
                                                <br><small class="text-muted">Vi phạm: ${product.violationType}</small>
                                            </c:if>
                                        </td>
                                        <td class="text-center">
                                            <div class="action-buttons">
                                                <!-- View Product -->
                                                <a href="/admin/product/${product.id}" class="btn btn-sm btn-outline-info" title="Xem chi tiết">
                                                    <i class="typcn typcn-eye"></i>
                                                </a>
                                                
                                                <!-- Admin Moderation Actions -->
                                                <c:choose>
                                                    <c:when test="${product.status == 'ACTIVE'}">
                                                         <!-- Hide Product -->
                                            <button type="button" class="btn btn-warning mr-2" data-id="${product.id}"
                                                data-action="hide" data-name="${product.name}"
                                                onclick="showViolationModal(this)">
                                                <i class="typcn typcn-eye-outline mr-1"></i> Ẩn sản phẩm
                                            </button>


                                            <!-- Lock Product -->
                                            <button type="button" class="btn btn-danger mr-2" data-id="${product.id}"
                                                data-action="lock" data-name="${product.name}"
                                                onclick="showViolationModal(this)">
                                                <i class="typcn typcn-lock-closed mr-1"></i> Khóa sản phẩm
                                            </button>

                                                    </c:when>
                                                    <c:otherwise>
                                                        <!-- Activate Product Button -->
                                                        <form action="/admin/product/${product.id}/activate" method="POST" style="display: inline;"
                                                              onsubmit="return confirm('Bạn có chắc chắn muốn kích hoạt lại sản phẩm này?')">
                                                            <button type="submit" class="btn btn-sm btn-outline-success" title="Kích hoạt lại">
                                                                <i class="typcn typcn-tick"></i>
                                                            </button>
                                                        </form>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <i class="typcn typcn-shopping-bag"></i>
                        <h5>Không tìm thấy sản phẩm nào</h5>
                        <p class="text-muted">
                            <c:choose>
                                <c:when test="${not empty keyword}">
                                    Thử thay đổi từ khóa tìm kiếm.
                                </c:when>
                                <c:otherwise>
                                    Cửa hàng này chưa có sản phẩm nào.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="/admin/product/shop/${shop.id}" class="btn btn-outline-primary">
                            <i class="typcn typcn-refresh mr-1"></i> Làm mới
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
    </div>
</div>
>>>>>>> anhvuDev

            <!-- Include Base Scripts -->
            <script src="/admin/vendors/js/vendor.bundle.base.js"></script>
            <script src="/admin/js/off-canvas.js"></script>
            <script src="/admin/js/hoverable-collapse.js"></script>
            <script src="/admin/js/template.js"></script>
            <script src="/admin/js/todolist.js"></script>

<<<<<<< HEAD
            <!-- Include JavaScript for confirmation dialogs -->
            <script>
                function confirmDelete(productName) {
                    return confirm('Bạn có chắc chắn muốn xóa sản phẩm "' + productName + '"?\nHành động này không thể hoàn tác.');
                }
            </script>
=======
<!-- Include JavaScript for confirmation dialogs -->
<script>
    function confirmDelete(productName) {
        return confirm('Bạn có chắc chắn muốn xóa sản phẩm "' + productName + '"?\nHành động này không thể hoàn tác.');
    }
    
    function showViolationModal(button) {
        
        const productId = button.getAttribute('data-id');
        const action = button.getAttribute('data-action');
        const productName = button.getAttribute('data-name');
        
        const modal = document.getElementById('violationModal');
        const form = document.getElementById('violationForm');
        const title = document.getElementById('modalTitle');
        const productNameSpan = document.getElementById('modalProductName');
        
        if (action === 'hide') {
            title.textContent = 'Ẩn sản phẩm vi phạm';
            form.action = '/admin/product/' + productId + '/hide';
        } else if (action === 'lock') {
            title.textContent = 'Khóa sản phẩm vi phạm';
            form.action = '/admin/product/' + productId + '/lock';
        }
         
        productNameSpan.textContent = productName;
        $('#violationModal').modal('show');
    }
    
</script>

<!-- Violation Modal -->
<div class="modal fade" id="violationModal" tabindex="-1" role="dialog" aria-labelledby="violationModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Xử lý vi phạm</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="violationForm" method="POST">
                <div class="modal-body">
                    <p>Sản phẩm: <strong id="modalProductName"></strong></p>
                    
                    <div class="form-group">
                        <label for="violationType">Loại vi phạm</label>
                        <select class="form-control" name="violationType" required>
                            <option value="">Chọn loại vi phạm</option>
                            <option value="COPYRIGHT">Vi phạm bản quyền</option>
                            <option value="PROHIBITED">Hàng hóa cấm</option>
                            <option value="MISLEADING">Thông tin sai lệch</option>
                            <option value="FAKE">Hàng giả</option>
                            <option value="INAPPROPRIATE">Nội dung không phù hợp</option>
                            <option value="OTHER">Khác</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="adminNotes">Ghi chú của admin</label>
                        <textarea class="form-control" name="adminNotes" rows="3" 
                                  placeholder="Mô tả chi tiết về vi phạm và lý do xử lý..." required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                    <button type="submit" class="btn btn-danger">Xác nhận</button>
                </div>
            </form>
        </div>
    </div>
</div>
>>>>>>> anhvuDev
