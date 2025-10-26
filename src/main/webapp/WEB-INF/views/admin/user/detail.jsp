<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/user-base.css">
<link rel="stylesheet" href="/admin/css/user-forms.css">

<style>
    .user-detail-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 30px;
        border-radius: 15px;
        margin-bottom: 30px;
        text-align: center;
    }
    
    .user-avatar-large {
        width: 120px;
        height: 120px;
        border-radius: 50%;
        object-fit: cover;
        border: 4px solid #fff;
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        margin-bottom: 20px;
    }
    
    .info-card {
        background: white;
        border-radius: 10px;
        padding: 25px;
        margin-bottom: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        border-left: 4px solid #007bff;
    }
    
    .info-item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 12px 0;
        border-bottom: 1px solid #f0f0f0;
    }
    
    .info-item:last-child {
        border-bottom: none;
    }
    
    .info-label {
        font-weight: 600;
        color: #495057;
        min-width: 120px;
    }
    
    .info-value {
        color: #212529;
        flex: 1;
        text-align: right;
    }
    
    .action-buttons {
        text-align: center;
        margin-top: 30px;
    }
    
    .action-buttons .btn {
        margin: 0 10px;
        padding: 12px 30px;
        border-radius: 25px;
        font-weight: 600;
        transition: all 0.3s ease;
    }
    
    .action-buttons .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }
</style>

<div class="main-panel">
    <div class="content-wrapper">
        
        <!-- User Detail Header -->
        <div class="user-detail-header">
            <c:choose>
                <c:when test="${not empty user.image}">
                    <c:choose>
                        <c:when test="${user.image.startsWith('/admin/images/user/')}">
                            <!-- New format: Full path already included -->
                            <img src="${user.image}" alt="Avatar" class="user-avatar-large">
                        </c:when>
                        <c:otherwise>
                            <!-- Old format: Just filename, add path -->
                            <img src="/admin/images/user/${user.image}" alt="Avatar" class="user-avatar-large">
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <div class="user-avatar-large d-inline-flex align-items-center justify-content-center mx-auto" 
                         style="background: linear-gradient(45deg, #fff, #f0f0f0); color: #667eea; font-weight: bold; font-size: 2.5rem;">
                        ${user.fullName.substring(0, 1).toUpperCase()}
                    </div>
                </c:otherwise>
            </c:choose>
            <h2 class="mb-2">${user.fullName}</h2>
            <p class="mb-0">
                <c:choose>
                    <c:when test="${user.role.name == 'ROLE_ADMIN'}">
                        <span class="badge badge-danger" style="font-size: 1rem; padding: 8px 20px;">Admin</span>
                    </c:when>
                    <c:when test="${user.role.name == 'ROLE_VENDOR'}">
                        <span class="badge badge-warning" style="font-size: 1rem; padding: 8px 20px;">Vendor</span>
                    </c:when>
                    <c:when test="${user.role.name == 'ROLE_USER'}">
                        <span class="badge badge-success" style="font-size: 1rem; padding: 8px 20px;">User</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge badge-secondary" style="font-size: 1rem; padding: 8px 20px;">${user.role.name}</span>
                    </c:otherwise>
                </c:choose>
            </p>
        </div>
        
        <!-- User Information -->
        <div class="row">
            <div class="col-md-6">
                <div class="info-card">
                    <h5 class="mb-3">
                        <i class="typcn typcn-user mr-2"></i>
                        Thông tin cá nhân
                    </h5>
                    
                    <div class="info-item">
                        <span class="info-label">ID người dùng:</span>
                        <span class="info-value"><strong>#${user.id}</strong></span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Họ và tên:</span>
                        <span class="info-value">${user.fullName}</span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Email:</span>
                        <span class="info-value">
                            <a href="mailto:${user.email}" class="text-decoration-none">
                                ${user.email}
                            </a>
                        </span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Số điện thoại:</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${not empty user.phone}">
                                    <a href="tel:${user.phone}" class="text-decoration-none">
                                        ${user.phone}
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Chưa cập nhật</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Vai trò:</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${user.role.name == 'ROLE_ADMIN'}">
                                    <span class="role-badge role-admin">Admin</span>
                                </c:when>
                                <c:when test="${user.role.name == 'ROLE_VENDOR'}">
                                    <span class="role-badge role-vendor">Vendor</span>
                                </c:when>
                                <c:when test="${user.role.name == 'ROLE_USER'}">
                                    <span class="role-badge role-customer">User</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="role-badge" style="background-color: #6c757d; color: white;">${user.role.name}</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>
            
            <div class="col-md-6">
                <div class="info-card">
                    <h5 class="mb-3">
                        <i class="typcn typcn-location mr-2"></i>
                        Thông tin địa chỉ
                    </h5>
                    
                    <div class="info-item">
                        <span class="info-label">Địa chỉ:</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${not empty user.address}">
                                    ${user.address}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Chưa cập nhật</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
                
                <!-- Additional Information Card -->
                <div class="info-card">
                    <h5 class="mb-3">
                        <i class="typcn typcn-info mr-2"></i>
                        Thông tin khác
                    </h5>
                    
                    <div class="info-item">
                        <span class="info-label">Hình đại diện:</span>
                        <span class="info-value">
                            <c:choose>
                                <c:when test="${not empty user.image}">
                                    <span class="text-success">Đã cập nhật</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Chưa cập nhật</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    
                    <div class="info-item">
                        <span class="info-label">Trạng thái:</span>
                        <span class="info-value">
                            <span class="badge badge-success">Hoạt động</span>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Action Buttons -->
        <div class="action-buttons">
            <!-- Edit button - Only for admin's own account -->
            <c:if test="${user.id == currentAdminId}">
                <a href="/admin/user/edit/${user.id}" class="btn btn-warning">
                    <i class="typcn typcn-edit mr-1"></i>
                    Chỉnh sửa tài khoản
                </a>
            </c:if>
            
            <!-- Delete button - Only for other users (not admin's own account) -->
            <c:if test="${user.id != currentAdminId}">
                <button class="btn btn-danger" onclick="deleteUser('${user.id}', '${user.fullName}')">
                    <i class="typcn typcn-trash mr-1"></i>
                    Xóa người dùng
                </button>
            </c:if>
            
            <!-- Back button - Always available -->
            <a href="/admin/user" class="btn btn-secondary">
                <i class="typcn typcn-arrow-back mr-1"></i>
                Quay lại
            </a>
        </div>
        
    </div>
</div>

<!-- Include Base Scripts -->
<script src="/admin/vendors/js/vendor.bundle.base.js"></script>
<script src="/admin/js/off-canvas.js"></script>
<script src="/admin/js/hoverable-collapse.js"></script>
<script src="/admin/js/template.js"></script>
<script src="/admin/js/todolist.js"></script>

<!-- Include User Management Scripts -->
<script src="/admin/js/user/user-actions.js"></script>
<script src="/admin/js/user/user-notifications.js"></script>
<script src="/admin/js/user/user-init.js"></script>
