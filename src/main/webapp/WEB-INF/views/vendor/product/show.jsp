<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
                <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                    <head>
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                    </head>

                    <style>
                        /* === Card bo tròn, bóng mượt === */
                        .card-custom {
                            border-radius: 15px;
                            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
                            overflow: hidden;
                            transition: transform 0.2s ease-in-out;
                            margin-bottom: 5px;
                        }

                        .card-custom:hover {
                            transform: translateY(-3px);
                        }

                        .card-header-custom {
                            background: linear-gradient(90deg, #4e73df 0%, #1cc88a 100%);
                            color: #fff;
                            font-weight: bold;
                            font-size: 1.2rem;
                        }

                        /* Nút hành động bo tròn, màu đẹp */
                        .action-btn {
                            width: 38px;
                            height: 38px;
                            border-radius: 50%;
                            display: inline-flex;
                            align-items: center;
                            justify-content: center;
                            transition: all 0.2s;
                            font-size: 16px;
                            border: 1px solid transparent;
                        }

                        .detail-btn {
                            color: #1d72b8;
                            border-color: #1d72b8;
                        }

                        .detail-btn:hover {
                            background-color: #1d72b8;
                            color: #fff;
                        }

                        .edit-btn {
                            color: #f0ad4e;
                            border-color: #f0ad4e;
                        }

                        .edit-btn:hover {
                            background-color: #f0ad4e;
                            color: #212529;
                        }

                        .delete-btn {
                            color: #dc3545;
                            border-color: #dc3545;
                        }

                        .delete-btn:hover {
                            background-color: #dc3545;
                            color: #fff;
                        }

                        /* Ảnh sản phẩm bo tròn và bóng */
                        .product-img {
                            width: 55px;
                            height: 55px;
                            object-fit: cover;
                            border-radius: 10px;
                            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.15);
                        }

                        /* Table bo tròn */
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

                        /* Badge count */
                        .product-count {
                            font-size: 0.95rem;
                            border-radius: 12px;
                        }

                        .btn-lift:hover {
                            transform: translateY(-3px);
                            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.25);
                        }

                        .btn-lift {
                            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
                        }

                        /* Custom Select Dropdown */
                        .form-select {
                            border: 2px solid #e0e6ed;
                            border-radius: 8px;
                            padding: 10px 15px;
                            font-size: 14px;
                            transition: all 0.3s ease;
                            background-color: #fff;
                            cursor: pointer;
                        }

                        .form-select:hover {
                            border-color: #396afc;
                            box-shadow: 0 0 0 3px rgba(57, 106, 252, 0.1);
                        }

                        .form-select:focus {
                            border-color: #396afc;
                            box-shadow: 0 0 0 4px rgba(57, 106, 252, 0.15);
                            outline: none;
                        }

                        .form-label {
                            font-size: 13px;
                            margin-bottom: 8px;
                            color: #5a6c7d;
                        }

                        /* Custom Search Input */
                        .input-group .form-control {
                            border: 2px solid #e0e6ed;
                            border-right: none;
                            border-radius: 8px 0 0 8px;
                            padding: 10px 15px;
                            transition: all 0.3s ease;
                        }

                        .input-group .form-control:focus {
                            border-color: #396afc;
                            box-shadow: 0 0 0 4px rgba(57, 106, 252, 0.15);
                            outline: none;
                        }

                        .input-group .btn-outline-primary {
                            border: 2px solid #396afc;
                            border-left: none;
                            border-radius: 0 8px 8px 0;
                            background-color: #396afc;
                            color: #fff;
                            padding: 10px 20px;
                            transition: all 0.3s ease;
                        }

                        .input-group .btn-outline-primary:hover {
                            background-color: #2948ff;
                            border-color: #2948ff;
                            transform: translateY(-2px);
                            box-shadow: 0 4px 12px rgba(57, 106, 252, 0.3);
                        }
                    </style>

                    <div class="main-panel">

                        <div class="content-wrapper">

                            <div class="row mb-2">
                                <div class="col-12">
                                    <!-- Card Header Quản lý sản phẩm -->
                                    <div class="card text-white w-100" style="border-radius: 15px 15px 0 0;">
                                        <div class="card-header card-header-custom d-flex justify-content-between align-items-center"
                                            style="background: linear-gradient(135deg, #396afc, #35edbc); 
                                                        border-radius: 15px 15px 0 0; 
                                                        padding: 20px 30px;">
                                            <h3 class="mb-0 fs-4"><i class="fas fa-box-open me-2"></i>QUẢN LÝ SẢN PHẨM
                                            </h3>
                                            <span class="badge bg-light text-dark product-count fs-6">
                                                <i class="fas fa-cubes me-1"></i> Tổng: ${fn:length(products)} sản phẩm
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <!-- Card Action -->
                                    <div class="card card-custom"
                                        style="border-radius: 0 0 15px 15px; margin-top: -5px;">
                                        <div class="card-body">
                                            <form method="get"
                                                action="${pageContext.request.contextPath}/vendor/product"
                                                class="row g-3 align-items-end mb-3">
                                                <div class="col-md-5">
                                                    <label class="form-label fw-bold">
                                                        <i class="fas fa-search me-1" style="color: #396afc;"></i>
                                                        Tìm kiếm nhanh
                                                    </label>
                                                    <div class="input-group">
                                                        <input type="text" name="keyword" class="form-control"
                                                            placeholder="Nhập tên, mã ID hoặc thương hiệu..."
                                                            value="${param.keyword}">
                                                        <button class="btn btn-outline-primary" type="submit">
                                                            <i class="fas fa-search"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                                <div class="col-md-4">
                                                    <label class="form-label fw-bold">
                                                        <i class="fas fa-filter me-1" style="color: #396afc;"></i>
                                                        Lọc theo Danh mục
                                                    </label>
                                                    <select name="category" class="form-select"
                                                        onchange="this.form.submit()">
                                                        <option value="">
                                                            <i class="fas fa-th-large"></i> -- Tất cả Danh mục --
                                                        </option>
                                                        <c:forEach var="cat" items="${categories}">
                                                            <option value="${cat}" ${param.category==cat ? 'selected'
                                                                :''}>
                                                                ${cat}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <div class="col-md-3">
                                                    <a href="${pageContext.request.contextPath}/vendor/product/add"
                                                        class="btn btn-success fw-bold w-100 shadow-sm btn-lift"
                                                        style="padding: 11px 20px; border-radius: 8px;">
                                                        <i class="fas fa-plus me-2"></i> Thêm Sản phẩm
                                                    </a>
                                                </div>
                                            </form>

                                            <hr class="custom-divider">
                                            <div class="table-responsive">
                                                <table class="table table-custom table-hover align-middle text-center">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Ảnh</th>
                                                            <th class="text-start">Tên sản phẩm</th>
                                                            <th>Giá bán</th>
                                                            <th>Thương hiệu</th>
                                                            <th>Hành động</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="product" items="${products}">
                                                            <tr>
                                                                <td class="text-muted fw-bold">#${product.id}</td>
                                                                <td>
                                                                    <img src="/resources/admin/images/product/${product.image}"
                                                                        alt="${product.name}" class="product-img">
                                                                </td>
                                                                <td class="text-start">${product.name}</td>
                                                                <td class="fw-bold text-success">
                                                                    <fmt:formatNumber value="${product.price}"
                                                                        type="number" pattern="#,##0" />₫
                                                                </td>
                                                                <td>${product.brand}</td>
                                                                <td>
                                                                    <a href="<c:url value='/vendor/product/detail?id=${product.id}'/>"
                                                                        class="btn action-btn detail-btn"
                                                                        data-bs-toggle="tooltip" title="Xem chi tiết"><i
                                                                            class="fas fa-eye"></i></a>
                                                                    <a href="${pageContext.request.contextPath}/vendor/product/edit/${product.id}"
                                                                        class="btn action-btn edit-btn"
                                                                        data-bs-toggle="tooltip" title="Chỉnh sửa"><i
                                                                            class="fas fa-edit"></i></a>
                                                                    <button type="button"
                                                                        class="btn action-btn delete-btn"
                                                                        data-id="${product.id}"
                                                                        data-name="${product.name}"
                                                                        data-bs-toggle="modal"
                                                                        data-bs-target="#deleteProductModal"
                                                                        aria-label="Xóa sản phẩm">
                                                                        <i class="fas fa-trash-alt"></i>
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                        <c:if test="${empty products}">
                                                            <tr>
                                                                <td colspan="6" class="text-center text-danger py-4"><i
                                                                        class="fas fa-exclamation-circle me-2"></i>Không
                                                                    tìm
                                                                    thấy sản phẩm nào.</td>
                                                            </tr>
                                                        </c:if>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal Xóa -->
                            <div class="modal fade" id="deleteProductModal" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content rounded-4 shadow-lg">
                                        <div class="modal-header bg-danger text-white">
                                            <h5 class="modal-title"><i class="fas fa-trash-alt"></i> Xác nhận Xóa Sản
                                                phẩm
                                            </h5>
                                            <button type="button" class="btn-close btn-close-white"
                                                data-bs-dismiss="modal"></button>
                                        </div>
                                        <form:form method="post"
                                            action="${pageContext.request.contextPath}/vendor/product/delete"
                                            modelAttribute="product">
                                            <form:hidden path="id" />
                                            <div class="modal-body text-center py-4">
                                                <i class="fas fa-question-circle text-warning fs-1 mb-3"></i>
                                                <p class="mb-3 fs-5">Bạn có chắc chắn muốn xóa sản phẩm <strong
                                                        id="deleteProductName" class="text-danger"></strong> không?</p>
                                                <p class="text-danger fw-bold">Dữ liệu sẽ bị xóa vĩnh viễn!</p>
                                            </div>
                                            <div class="modal-footer justify-content-center">
                                                <button type="button" class="btn btn-secondary fw-bold"
                                                    data-bs-dismiss="modal">Hủy</button>
                                                <button type="submit" class="btn btn-danger fw-bold">Xóa Vĩnh
                                                    Viễn</button>
                                            </div>
                                        </form:form>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- content-wrapper ends -->

                    </div>
                    <!-- main-panel ends -->

                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
                    <!-- <script>
                            $(document).ready(function () {
                                // Tooltips
                                var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                                tooltipTriggerList.map(function (el) { return new bootstrap.Tooltip(el); });

                                // Modal Delete
                                $('.delete-btn').click(function () {
                                    const id = $(this).data('id');
                                    const name = $(this).data('name');
                                    $('#deleteProductModal input[name="id"]').val(id);
                                    $('#deleteProductName').text(name);
                                });
                            });
                        </script> -->

                    <script>

                        $(document).ready(function () {
                            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
                            tooltipTriggerList.map(function (tooltipTriggerEl) {
                                return new bootstrap.Tooltip(tooltipTriggerEl, {
                                    delay: { "show": 100, "hide": 50 }, // hiện nhanh
                                    boundary: 'window',
                                    fallbackPlacements: ['top', 'bottom'], // đảm bảo tooltip không bị cắt
                                })
                            })

                            // Khắc phục: Lắng nghe sự kiện "show.bs.modal"
                            $('#deleteProductModal').on('show.bs.modal', function (event) {
                                // Lấy nút đã kích hoạt modal
                                var button = $(event.relatedTarget);

                                // Lấy dữ liệu từ các thuộc tính data- của nút
                                var productId = button.data('id');
                                var productName = button.data('name');

                                // Cập nhật nội dung modal và form ẩn
                                var modal = $(this);
                                modal.find('input[name="id"]').val(productId); // Cập nhật form:hidden
                                modal.find('#deleteProductName').text(productName); // Cập nhật tên SP trong modal
                            });
                        });
                    </script>