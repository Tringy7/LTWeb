<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

                <!-- Include CSS Files -->
                <link rel="stylesheet" href="/admin/css/voucher-base.css">
                <link rel="stylesheet" href="/admin/css/voucher-search.css">
                <link rel="stylesheet" href="/admin/css/voucher-table.css">

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

                        <!-- Header Section -->
                        <div class="search-card">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4 class="mb-0">
                                    <i class="typcn typcn-ticket mr-2"></i>
                                    Quản lý Voucher
                                </h4>
                                <div>
                                    <a href="/admin/voucher/create" class="btn btn-primary">
                                        <i class="typcn typcn-plus mr-1"></i> Tạo Voucher Hệ Thống
                                    </a>
                                    <a href="/admin/voucher/moderation" class="btn btn-warning">
                                        <i class="typcn typcn-warning mr-1"></i> Kiểm Duyệt
                                    </a>
                                </div>
                            </div>

                            <!-- Search Form -->
                            <form method="GET" action="/admin/voucher" class="search-form">
                                <div class="row align-items-end">
                                    <div class="col-md-4">
                                        <label for="keyword" class="form-label"
                                        style="color: #2c2323; font-weight: 500;">Từ khóa tìm kiếm</label>
                                        <input type="text" name="keyword" value="${keyword}" class="form-control"
                                            placeholder="Mã voucher hoặc trạng thái..." id="keyword" />
                                    </div>

                                    <div class="col-md-3">
                                        <label for="status" class="form-label"
                                        style="color: #2c2323; font-weight: 500;">Trạng thái</label>

                                        <select name="status" class="form-control" onchange="this.form.submit()">
                                            <option value="ALL" ${status=='ALL' ? 'selected' : '' }>-- Tất cả --
                                            </option>
                                            <option value="Active" ${status=='Active' ? 'selected' : '' }>Hoạt động
                                            </option>
                                            <option value="Expired" ${status=='Expired' ? 'selected' : '' }>Không hoạt
                                                động</option>
                                        </select>
                                    </div>

                                    <div class="col-md-3">
                                        <label for="voucherType" class="form-label"
                                            style="color: #2c2323; font-weight: 500;">
                                            Loại voucher
                                        </label>
                                        <select name="voucherType" class="form-control">
                                            <option value="SYSTEM" ${voucherType=='SYSTEM' ? 'selected' : '' }>Voucher
                                                hệ thống</option>
                                            <option value="ALL" ${voucherType=='ALL' ? 'selected' : '' }>Tất cả voucher
                                            </option>
                                        </select>
                                    </div>

                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-light">
                                            <i class="typcn typcn-zoom mr-1"></i> Tìm kiếm
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Statistics -->
                        <div class="stats-card">
                            <div class="row">
                                <div class="col-md-6">
                                    <h6 class="mb-1">Tổng voucher hệ thống</h6>
                                    <h3 class="text-primary mb-0">${totalSystemVouchers}</h3>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="mb-1">Voucher đang hoạt động</h6>
                                    <h3 class="text-success mb-0">${activeSystemVouchers}</h3>
                                </div>
                            </div>
                        </div>

                        <!-- Vouchers Table -->
                        <div class="table-container">
                            <c:choose>
                                <c:when test="${not empty vouchers}">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Mã Voucher</th>
                                                    <th>Giảm giá</th>
                                                    <th>Ngày bắt đầu</th>
                                                    <th>Ngày kết thúc</th>
                                                    <th>Trạng thái</th>
                                                    <th>Loại</th>
                                                    <th>Shop</th>
                                                    <th class="text-center">Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="voucher" items="${vouchers}" varStatus="status">
                                                    <tr>
                                                        <td><strong>#${voucher.id}</strong></td>
                                                        <td>
                                                            <div class="voucher-code">${voucher.code}</div>
                                                            <c:if test="${voucher.expired}">
                                                                <span class="badge badge-secondary">Hết hạn</span>
                                                            </c:if>
                                                            <c:if test="${voucher.active}">
                                                                <span class="badge badge-success">Đang hoạt động</span>
                                                            </c:if>
                                                        </td>
                                                        <td>
                                                            <strong>${voucher.discountPercent}%</strong>
                                                        </td>
                                                        <td>
                                                            <c:set var="start" value="${voucher.startDate}" />
                                                            <c:if test="${not empty start}">
                                                                ${start.dayOfMonth}/${start.monthValue}/${start.year}
                                                                ${start.hour}:${start.minute < 10 ? '0' : ''
                                                                    }${start.minute} </c:if>
                                                        </td>

                                                        <td>
                                                            <c:set var="end" value="${voucher.endDate}" />
                                                            <c:if test="${not empty end}">
                                                                ${end.dayOfMonth}/${end.monthValue}/${end.year}
                                                                ${end.hour}:${end.minute < 10 ? '0' : '' }${end.minute}
                                                                    </c:if>
                                                        </td>

                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${voucher.status == 'Active'}">
                                                                    <span class="status-badge status-active">Hoạt
                                                                        động</span>
                                                                </c:when>
                                                                <c:when test="${voucher.status == 'Expired'}">
                                                                    <span class="status-badge status-inactive">Không
                                                                        hoạt động</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="status-badge">${voucher.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${voucher.voucherType == 'SYSTEM'}">
                                                                    <span class="type-badge type-system">Hệ thống</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="type-badge type-shop">Shop</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty voucher.shopName}">
                                                                    ${voucher.shopName}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">N/A</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="text-center">
                                                            <div class="action-buttons">
                                                                <!-- View Voucher -->
                                                                <a href="/admin/voucher/${voucher.id}"
                                                                    class="btn btn-sm btn-outline-info"
                                                                    title="Xem chi tiết">
                                                                    <i class="typcn typcn-eye"></i>
                                                                </a>

                                                                <!-- Edit Voucher (only for system vouchers) -->
                                                                <c:if test="${voucher.voucherType == 'SYSTEM'}">
                                                                    <a href="/admin/voucher/edit/${voucher.id}"
                                                                        class="btn btn-sm btn-outline-warning"
                                                                        title="Chỉnh sửa">
                                                                        <i class="typcn typcn-edit"></i>
                                                                    </a>

                                                                    <!-- Assign to All Users -->
                                                                    <form
                                                                        action="/admin/voucher/${voucher.id}/assign-to-all"
                                                                        method="POST" style="display: inline;"
                                                                        onsubmit="return confirmAssignToAll('${voucher.code}')">
                                                                        <button type="submit"
                                                                            class="btn btn-sm btn-outline-info"
                                                                            title="Gán cho tất cả người dùng">
                                                                            <i class="typcn typcn-user-add"></i>
                                                                        </button>
                                                                    </form>
                                                                </c:if>

                                                                <!-- Status Actions -->
                                                                <c:choose>
                                                                    <c:when test="${voucher.status == 'Expired'}">
                                                                        <form
                                                                            action="/admin/voucher/${voucher.id}/unlock"
                                                                            method="POST" style="display: inline;">
                                                                            <button type="submit"
                                                                                class="btn btn-sm btn-outline-success"
                                                                                title="Mở khóa">
                                                                                <i class="typcn typcn-lock-open"></i>
                                                                            </button>
                                                                        </form>
                                                                    </c:when>
                                                                    <c:when test="${voucher.status == 'Active'}">
                                                                        <form action="/admin/voucher/${voucher.id}/lock"
                                                                            method="POST" style="display: inline;"
                                                                            onsubmit="return confirmLock('${voucher.code}')">
                                                                            <button type="submit"
                                                                                class="btn btn-sm btn-outline-danger"
                                                                                title="Khóa vi phạm">
                                                                                <i class="typcn typcn-lock-closed"></i>
                                                                            </button>
                                                                        </form>
                                                                    </c:when>
                                                                </c:choose>

                                                                <!-- Delete (only for system vouchers) -->
                                                                <c:if test="${voucher.voucherType == 'SYSTEM'}">
                                                                    <form action="/admin/voucher/delete/${voucher.id}"
                                                                        method="POST" style="display: inline;"
                                                                        onsubmit="return confirmDelete('${voucher.code}')">
                                                                        <button type="submit"
                                                                            class="btn btn-sm btn-outline-danger"
                                                                            title="Xóa">
                                                                            <i class="typcn typcn-trash"></i>
                                                                        </button>
                                                                    </form>
                                                                </c:if>
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
                                        <i class="typcn typcn-ticket"></i>
                                        <h5>Không tìm thấy voucher nào</h5>
                                        <p class="text-muted">
                                            Thử thay đổi từ khóa tìm kiếm hoặc bộ lọc.
                                        </p>
                                        <a href="/admin/voucher" class="btn btn-outline-primary">
                                            <i class="typcn typcn-refresh mr-1"></i> Làm mới
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                    </div>
                </div>

                <!-- Include Base Scripts -->
                <script src="/admin/vendors/js/vendor.bundle.base.js"></script>
                <script src="/admin/js/off-canvas.js"></script>
                <script src="/admin/js/hoverable-collapse.js"></script>
                <script src="/admin/js/template.js"></script>
                <script src="/admin/js/todolist.js"></script>

                <script>
                    function confirmDelete(voucherCode) {
                        return confirm('Bạn có chắc chắn muốn xóa voucher "' + voucherCode + '"?');
                    }

                    function confirmLock(voucherCode) {
                        return confirm('Bạn có chắc chắn muốn khóa voucher "' + voucherCode + '" vì vi phạm chính sách?');
                    }
                </script>