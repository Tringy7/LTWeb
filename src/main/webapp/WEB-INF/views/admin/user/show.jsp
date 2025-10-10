<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<style>
    .main-panel {
        padding: 20px;
    }
    
    .search-card {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        border-radius: 10px;
        padding: 20px;
        margin-bottom: 20px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }
    
    .search-form .form-control {
        border-radius: 25px;
        border: none;
        padding: 10px 20px;
        margin-bottom: 10px;
    }
    
    .search-form .btn {
        border-radius: 25px;
        padding: 10px 30px;
        font-weight: 600;
        margin-right: 10px;
        margin-bottom: 10px;
        transition: all 0.3s ease;
    }
    
    .search-form .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }
    
    .stats-card {
        background: #f8f9fa;
        border-radius: 10px;
        padding: 15px;
        margin-bottom: 20px;
        border-left: 4px solid #007bff;
    }
    
    .table-container {
        background: white;
        border-radius: 10px;
        padding: 20px;
        box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    
    .table th {
        background-color: #f8f9fa;
        border: none;
        font-weight: 600;
        color: #495057;
        padding: 15px;
        vertical-align: middle;
    }
    
    .table td {
        border: none;
        padding: 15px;
        vertical-align: middle;
        border-bottom: 1px solid #dee2e6;
    }
    
    .table tbody tr:hover {
        background-color: #f8f9fa;
        transition: all 0.3s ease;
    }
    
    .user-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        object-fit: cover;
        border: 2px solid #fff;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    
    .role-badge {
        font-size: 0.75rem;
        padding: 5px 12px;
        border-radius: 15px;
        font-weight: 500;
    }
    
    .role-admin {
        background-color: #dc3545;
        color: white;
    }
    
    .role-vendor {
        background-color: #fd7e14;
        color: white;
    }
    
    .role-customer {
        background-color: #28a745;
        color: white;
    }
    
    .role-staff {
        background-color: #17a2b8;
        color: white;
    }
    
    .action-buttons .btn {
        margin-right: 5px;
        margin-bottom: 5px;
        border-radius: 5px;
        font-size: 0.8rem;
        padding: 5px 12px;
    }
    
    .search-result-info {
        background: #e7f3ff;
        border: 1px solid #b3d9ff;
        border-radius: 5px;
        padding: 10px 15px;
        margin-bottom: 15px;
        color: #0066cc;
    }
    
    .no-results {
        text-align: center;
        padding: 40px;
        color: #6c757d;
    }
    
    .no-results i {
        font-size: 3rem;
        margin-bottom: 15px;
        color: #dee2e6;
    }
</style>

<div class="main-panel">
    <div class="content-wrapper">
        
        <!-- Search Card -->
        <div class="search-card">
            <h4 class="mb-3">
                <i class="typcn typcn-user-outline mr-2"></i>
                Quản lý người dùng
            </h4>
            
            <form:form method="POST" action="/admin/user/search" modelAttribute="searchForm" cssClass="search-form">
                <div class="row align-items-end">
                    <div class="col-md-4">
                        <label for="keyword" class="form-label">Từ khóa tìm kiếm</label>
                        <form:input path="keyword" cssClass="form-control" 
                                   placeholder="Tên, email hoặc số điện thoại..." 
                                   id="keyword"/>
                    </div>
                    
                    <div class="col-md-3">
                        <label for="roleId" class="form-label">Loại người dùng</label>
                        <form:select path="roleId" cssClass="form-control">
                            <form:option value="">-- Tất cả --</form:option>
                            <form:options items="${roles}" itemValue="id" itemLabel="name"/>
                        </form:select>
                    </div>
                    
                    <div class="col-md-5">
                        <button type="submit" class="btn btn-light">
                            <i class="typcn typcn-zoom mr-1"></i> Tìm kiếm
                        </button>
                        <a href="/admin/user/clear" class="btn btn-outline-light">
                            <i class="typcn typcn-refresh mr-1"></i> Làm mới
                        </a>
                        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addUserModal">
                            <i class="typcn typcn-plus mr-1"></i> Thêm người dùng
                        </button>
                    </div>
                </div>
            </form:form>
        </div>
        
        <!-- Statistics -->
        <div class="stats-card">
            <div class="row">
                <div class="col-md-6">
                    <h6 class="mb-1">Tổng số người dùng</h6>
                    <h3 class="text-primary mb-0">${totalUsers}</h3>
                </div>
                <div class="col-md-6 text-md-right">
                    <c:if test="${searchPerformed}">
                        <span class="badge badge-info">Kết quả tìm kiếm</span>
                    </c:if>
                </div>
            </div>
        </div>
        
        <!-- Search Result Info -->
        <c:if test="${searchPerformed}">
            <div class="search-result-info">
                <i class="typcn typcn-info mr-1"></i>
                Tìm thấy ${totalUsers} người dùng
                
                <c:choose>
                    <c:when test="${not empty searchForm.keyword and not empty searchForm.roleId}">
                        <!-- Both keyword and role specified -->
                        với từ khóa "<strong>${searchForm.keyword}</strong>"
                        <c:forEach var="role" items="${roles}">
                            <c:if test="${role.id == searchForm.roleId}">
                                trong nhóm <strong>${role.name}</strong>
                            </c:if>
                        </c:forEach>
                    </c:when>
                    <c:when test="${not empty searchForm.keyword}">
                        <!-- Only keyword specified -->
                        với từ khóa "<strong>${searchForm.keyword}</strong>"
                    </c:when>
                    <c:when test="${not empty searchForm.roleId}">
                        <!-- Only role specified -->
                        <c:forEach var="role" items="${roles}">
                            <c:if test="${role.id == searchForm.roleId}">
                                thuộc nhóm <strong>${role.name}</strong>
                            </c:if>
                        </c:forEach>
                    </c:when>
                </c:choose>
            </div>
        </c:if>
        
        <!-- Users Table -->
        <div class="table-container">
            <c:choose>
                <c:when test="${not empty users}">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Avatar</th>
                                    <th>ID</th>
                                    <th>Họ và tên</th>
                                    <th>Email</th>
                                    <th>Số điện thoại</th>
                                    <th>Địa chỉ</th>
                                    <th>Vai trò</th>
                                    <th class="text-center">Hành động</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${users}" varStatus="status">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty user.image}">
                                                    <img src="/images/users/${user.image}" alt="Avatar" class="user-avatar">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="user-avatar d-flex align-items-center justify-content-center" 
                                                         style="background: linear-gradient(45deg, #667eea, #764ba2); color: white; font-weight: bold;">
                                                        ${user.fullName.substring(0, 1).toUpperCase()}
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><strong>#${user.id}</strong></td>
                                        <td>
                                            <div class="font-weight-bold">${user.fullName}</div>
                                        </td>
                                        <td>
                                            <a href="mailto:${user.email}" class="text-decoration-none">
                                                ${user.email}
                                            </a>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty user.phone}">
                                                    <a href="tel:${user.phone}" class="text-decoration-none">
                                                        ${user.phone}
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa có</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty user.address}">
                                                    <span title="${user.address}">
                                                        ${user.address.length() > 30 ? user.address.substring(0, 30).concat('...') : user.address}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Chưa có</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.role.name == 'Admin'}">
                                                    <span class="role-badge role-admin">${user.role.name}</span>
                                                </c:when>
                                                <c:when test="${user.role.name == 'Vendor'}">
                                                    <span class="role-badge role-vendor">${user.role.name}</span>
                                                </c:when>
                                                <c:when test="${user.role.name == 'Customer'}">
                                                    <span class="role-badge role-customer">${user.role.name}</span>
                                                </c:when>
                                                <c:when test="${user.role.name == 'Staff'}">
                                                    <span class="role-badge role-staff">${user.role.name}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="role-badge" style="background-color: #6c757d; color: white;">${user.role.name}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <div class="action-buttons">
                                                <button class="btn btn-sm btn-outline-info" onclick="viewUser('${user.id}')" title="Xem chi tiết">
                                                    <i class="typcn typcn-eye"></i>
                                                </button>
                                                <button class="btn btn-sm btn-outline-warning" onclick="editUser('${user.id}')" title="Chỉnh sửa">
                                                    <i class="typcn typcn-edit"></i>
                                                </button>
                                                <button class="btn btn-sm btn-outline-danger" onclick="deleteUser('${user.id}', '${user.fullName}')" title="Xóa">
                                                    <i class="typcn typcn-trash"></i>
                                                </button>
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
                        <i class="typcn typcn-user-outline"></i>
                        <h5>Không tìm thấy người dùng nào</h5>
                        <p class="text-muted">
                            <c:choose>
                                <c:when test="${searchPerformed}">
                                    Thử thay đổi từ khóa tìm kiếm hoặc bộ lọc.
                                </c:when>
                                <c:otherwise>
                                    Chưa có người dùng nào trong hệ thống.
                                </c:otherwise>
                            </c:choose>
                        </p>
                        <a href="/admin/user/clear" class="btn btn-outline-primary">
                            <i class="typcn typcn-refresh mr-1"></i> Làm mới
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        
    </div>
</div>

<!-- Scripts -->
<script src="/admin/vendors/js/vendor.bundle.base.js"></script>
<script src="/admin/js/off-canvas.js"></script>
<script src="/admin/js/hoverable-collapse.js"></script>
<script src="/admin/js/template.js"></script>
<script src="/admin/js/todolist.js"></script>

<script>
// JavaScript functions for user actions
function viewUser(userId) {
    // Redirect to user detail page
    window.location.href = '/admin/user/detail/' + userId;
}

function editUser(userId) {
    // Redirect to user edit page
    window.location.href = '/admin/user/edit/' + userId;
}

function deleteUser(userId, userName) {
    if (confirm('Bạn có chắc chắn muốn xóa người dùng "' + userName + '"?')) {
        // Send DELETE request
        fetch('/admin/user/delete/' + userId, {
            method: 'DELETE',
            headers: {
                'Content-Type': 'application/json',
            }
        })
        .then(response => {
            if (response.ok) {
                alert('Xóa người dùng thành công!');
                location.reload();
            } else {
                alert('Có lỗi xảy ra khi xóa người dùng!');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Có lỗi xảy ra khi xóa người dùng!');
        });
    }
}

// Auto-submit form when role changes
document.getElementById('roleId').addEventListener('change', function() {
    if (this.value !== '') {
        document.querySelector('.search-form').submit();
    }
});

// Enter key search
document.getElementById('keyword').addEventListener('keypress', function(e) {
    if (e.key === 'Enter') {
        e.preventDefault();
        document.querySelector('.search-form').submit();
    }
});

// Clear search when clicking clear button
function clearSearch() {
    document.getElementById('keyword').value = '';
    document.getElementById('roleId').value = '';
    window.location.href = '/admin/user';
}
</script>