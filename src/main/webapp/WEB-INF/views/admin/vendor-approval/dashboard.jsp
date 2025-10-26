<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/user-base.css">
<link rel="stylesheet" href="/admin/css/user-table.css">

<div class="main-panel">
    <div class="content-wrapper">
        
        <!-- Flash Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="typcn typcn-warning mr-2"></i>
                ${error}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        </c:if>
        
        <!-- Main Header -->
        <div class="search-card">
            <h4 class="mb-3">
                <i class="typcn typcn-user-outline mr-2"></i>
                Quản lý duyệt cửa hàng
            </h4>
            
            <div class="row">
                <div class="col-md-12">
                    <p class="text-muted mb-0">
                        Quản lý và duyệt đơn đăng ký cửa hàng từ các vendor
                    </p>
                </div>
            </div>
        </div>
        
        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-3">
                <div class="stats-card" style="border-left-color: #007bff;">
                    <div class="row">
                        <div class="col-8">
                            <h6 class="mb-1 text-muted">Tổng đơn đăng ký</h6>
                            <h3 class="text-primary mb-0">${statistics.totalApplications}</h3>
                        </div>
                        <div class="col-4 text-right">
                            <i class="typcn typcn-document-text text-primary" style="font-size: 2rem;"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="stats-card" style="border-left-color: #ffc107;">
                    <div class="row">
                        <div class="col-8">
                            <h6 class="mb-1 text-muted">Chờ duyệt</h6>
                            <h3 class="text-warning mb-0">${statistics.pendingApplications}</h3>
                        </div>
                        <div class="col-4 text-right">
                            <i class="typcn typcn-time text-warning" style="font-size: 2rem;"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="stats-card" style="border-left-color: #28a745;">
                    <div class="row">
                        <div class="col-8">
                            <h6 class="mb-1 text-muted">Đã duyệt</h6>
                            <h3 class="text-success mb-0">${statistics.approvedVendors}</h3>
                        </div>
                        <div class="col-4 text-right">
                            <i class="typcn typcn-tick text-success" style="font-size: 2rem;"></i>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="stats-card" style="border-left-color: #dc3545;">
                    <div class="row">
                        <div class="col-8">
                            <h6 class="mb-1 text-muted">Đã từ chối</h6>
                            <h3 class="text-danger mb-0">${statistics.rejectedApplications}</h3>
                        </div>
                        <div class="col-4 text-right">
                            <i class="typcn typcn-times text-danger" style="font-size: 2rem;"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Actions -->
        <div class="table-container mb-4">
            <h5 class="mb-3">
                <i class="typcn typcn-flash mr-2"></i>
                Hành động nhanh
            </h5>
            
            <div class="row">
                <div class="col-md-6 col-lg-3 mb-3">
                    <a href="/admin/vendor-approval/pending" class="btn btn-outline-warning btn-block">
                        <i class="typcn typcn-time mr-2"></i>
                        Xem chờ duyệt
                        <c:if test="${statistics.pendingApplications > 0}">
                            <span class="badge badge-warning ml-2">${statistics.pendingApplications}</span>
                        </c:if>
                    </a>
                </div>
                
                <div class="col-md-6 col-lg-3 mb-3">
                    <a href="/admin/vendor-approval/approved" class="btn btn-outline-success btn-block">
                        <i class="typcn typcn-tick mr-2"></i>
                        Đã duyệt
                        <c:if test="${statistics.approvedVendors > 0}">
                            <span class="badge badge-success ml-2">${statistics.approvedVendors}</span>
                        </c:if>
                    </a>
                </div>
                
                <div class="col-md-6 col-lg-3 mb-3">
                    <a href="/admin/vendor-approval/rejected" class="btn btn-outline-danger btn-block">
                        <i class="typcn typcn-times mr-2"></i>
                        Đã từ chối
                        <c:if test="${statistics.rejectedApplications > 0}">
                            <span class="badge badge-danger ml-2">${statistics.rejectedApplications}</span>
                        </c:if>
                    </a>
                </div>
                
                <div class="col-md-6 col-lg-3 mb-3">
                    <a href="/admin/vendor-approval/pending" class="btn btn-primary btn-block">
                        <i class="typcn typcn-zoom mr-2"></i>
                        Xem tất cả
                    </a>
                </div>
            </div>
        </div>

        <!-- Recent Pending Applications -->
        <div class="table-container">
            <h5 class="mb-3">
                <i class="typcn typcn-list mr-2"></i>
                Đơn đăng ký mới nhất
            </h5>
            
            <c:choose>
                <c:when test="${not empty pendingApplications}">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Tên cửa hàng</th>
                                    <th>Chủ cửa hàng</th>
                                    <th>Email</th>
                                    <th>Ngày đăng ký</th>
                                    <th>Trạng thái</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${pendingApplications}" var="app" begin="0" end="4">
                                    <tr>
                                        <td>
                                            <strong>${app.shopName}</strong>
                                            <c:if test="${not empty app.description}">
                                                <br>
                                                <small class="text-muted">${fn:substring(app.description, 0, 50)}${fn:length(app.description) > 50 ? '...' : ''}</small>
                                            </c:if>
                                        </td>
                                        <td>${app.user.fullName}</td>
                                        <td>
                                            <a href="mailto:${app.user.email}">${app.user.email}</a>
                                        </td>
                                        <td>
                                            <c:set var="dateTime" value="${app.createdAt}" />
                                            <c:if test="${not empty dateTime}">
                                                ${dateTime.dayOfMonth}/${dateTime.monthValue}/${dateTime.year}
                                                <br>
                                                <small class="text-muted">
                                                    ${dateTime.hour}:${dateTime.minute < 10 ? '0' : ''}${dateTime.minute}
                                                </small>
                                            </c:if>
                                        </td>
                                        <td>
                                            <span class="role-badge" style="background-color: #ffc107; color: #000;">
                                                Chờ duyệt
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="/admin/vendor-approval/details/${app.id}" 
                                                   class="btn btn-info btn-sm" 
                                                   title="Xem chi tiết">
                                                    <i class="typcn typcn-eye"></i>
                                                </a>
                                                <button type="button" 
                                                        class="btn btn-success btn-sm" 
                                                        onclick="quickApprove('${app.id}', '${fn:escapeXml(app.shopName)}')"
                                                        title="Duyệt nhanh">
                                                    <i class="typcn typcn-tick"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    
                    <c:if test="${fn:length(pendingApplications) > 5}">
                        <div class="text-center mt-3">
                            <a href="/admin/vendor-approval/pending" class="btn btn-outline-primary">
                                <i class="typcn typcn-arrow-right mr-1"></i>
                                Xem tất cả (${statistics.pendingApplications})
                            </a>
                        </div>
                    </c:if>
                </c:when>
                <c:otherwise>
                    <div class="no-results">
                        <i class="typcn typcn-inbox"></i>
                        <h5>Không có đơn đăng ký nào</h5>
                        <p class="text-muted">Hiện tại không có đơn đăng ký cửa hàng nào cần xử lý.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- Quick Approve Modal -->
<div class="modal fade" id="quickApproveModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="typcn typcn-tick mr-2"></i>
                    Xác nhận duyệt cửa hàng
                </h5>
                <button type="button" class="close" data-dismiss="modal">
                    <span>&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p>Bạn có chắc chắn muốn duyệt cửa hàng <strong id="approveShopName"></strong>?</p>
                <div class="alert alert-info">
                    <i class="typcn typcn-info mr-2"></i>
                    Sau khi duyệt, người dùng sẽ trở thành vendor và có thể quản lý cửa hàng.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">
                    <i class="typcn typcn-times mr-1"></i> Hủy
                </button>
                <form id="quickApproveForm" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-success">
                        <i class="typcn typcn-tick mr-1"></i> Xác nhận duyệt
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function quickApprove(shopId, shopName) {
    document.getElementById('approveShopName').textContent = shopName;
    document.getElementById('quickApproveForm').action = '/admin/vendor-approval/approve/' + shopId;
    $('#quickApproveModal').modal('show');
}
</script>
