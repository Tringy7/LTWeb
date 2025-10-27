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
                                    <!-- Admin Status Badge -->
                                    <c:choose>
                                        <c:when test="${product.status == 'ACTIVE'}">
                                            <span class="badge badge-success mr-2">Hoạt động</span>
                                        </c:when>
                                        <c:when test="${product.status == 'HIDDEN'}">
                                            <span class="badge badge-warning mr-2">Đã ẩn</span>
                                        </c:when>
                                        <c:when test="${product.status == 'LOCKED'}">
                                            <span class="badge badge-danger mr-2">Bị khóa</span>
                                        </c:when>
                                    </c:choose>
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
                                                                <span
                                                                    class="badge badge-light">${product.category}</span>
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
                                                                <span
                                                                    class="badge badge-secondary">${product.gender}</span>
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
                                                            <fmt:formatNumber value="${product.price}" type="number"
                                                                maxFractionDigits="0" /> VNĐ
                                                        </h4>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="info-label">Cửa hàng</td>
                                                    <td>
                                                        <a href="/admin/product/shop/${product.shopId}"
                                                            class="text-decoration-none">
                                                            <strong>${product.shopName}</strong>
                                                        </a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="info-label">Trạng thái</td>
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
                                                                <span class="badge badge-secondary">Không xác
                                                                    định</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                <c:if test="${not empty product.violationType}">
                                                    <tr>
                                                        <td class="info-label">Loại vi phạm</td>
                                                        <td><span class="text-danger">${product.violationType}</span>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                                <c:if test="${not empty product.adminNotes}">
                                                    <tr>
                                                        <td class="info-label">Ghi chú admin</td>
                                                        <td><span class="text-muted">${product.adminNotes}</span></td>
                                                    </tr>
                                                </c:if>
                                                <c:if test="${not empty product.lastModifiedByAdmin}">
                                                    <tr>
                                                        <td class="info-label">Chỉnh sửa lần cuối</td>
                                                        <td>
                                                            <c:set var="dateTime"
                                                                value="${product.lastModifiedByAdmin}" />
                                                            <c:if test="${not empty dateTime}">
                                                                ${dateTime.dayOfMonth}/${dateTime.monthValue}/${dateTime.year}
                                                                ${dateTime.hour}:${dateTime.minute < 10 ? '0' : ''
                                                                    }${dateTime.minute} </c:if>
                                                        </td>


                                                    </tr>
                                                </c:if>
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

                            <!-- Admin Action Buttons -->
                            <div class="row mt-4">
                                <div class="col-12 text-center">
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
                                            <!-- Activate Product -->
                                            <form action="/admin/product/${product.id}/activate" method="POST"
                                                style="display: inline;"
                                                onsubmit="return confirm('Bạn có chắc chắn muốn kích hoạt lại sản phẩm này?')">
                                                <button type="submit" class="btn btn-success mr-2">
                                                    <i class="typcn typcn-tick mr-1"></i> Kích hoạt lại
                                                </button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>

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
            <div class="modal fade" id="violationModal" tabindex="-1" role="dialog"
                aria-labelledby="violationModalLabel" aria-hidden="true">
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