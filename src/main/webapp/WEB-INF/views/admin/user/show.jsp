<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

                <!-- Include CSS Files -->
                <link rel="stylesheet" href="/admin/css/user-base.css">
                <link rel="stylesheet" href="/admin/css/user-search.css">
                <link rel="stylesheet" href="/admin/css/user-table.css">

                <div class="main-panel">
                    <div class="content-wrapper">

                        <!-- Flash Messages -->
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <i class="typcn typcn-tick mr-2"></i>
                                ${successMessage}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </c:if>

                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                <i class="typcn typcn-warning mr-2"></i>
                                ${errorMessage}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </c:if>

                        <!-- Search Card -->
                        <div class="search-card">
                            <h4 class="mb-3">
                                <i class="typcn typcn-user-outline mr-2"></i>
                                Quản lý người dùng
                            </h4>

                            <form:form method="GET" action="/admin/user" modelAttribute="searchForm"
                                cssClass="search-form">
                                <div class="row align-items-end">
                                    <div class="col-md-4">
                                        <label for="keyword" class="form-label">Từ khóa tìm kiếm</label>
                                        <form:input path="keyword" cssClass="form-control"
                                            placeholder="Tên, email hoặc số điện thoại..." id="keyword" />
                                    </div>

                                    <div class="col-md-3">
                                        <label for="roleId" class="form-label">Loại người dùng</label>
                                        <form:select path="roleId" cssClass="form-control">
                                            <form:option value="">-- Tất cả --</form:option>
                                            <form:options items="${roles}" itemValue="id" itemLabel="name" />
                                        </form:select>
                                    </div>

                                    <div class="col-md-5">
                                        <button type="submit" class="btn btn-light">
                                            <i class="typcn typcn-zoom mr-1"></i> Tìm kiếm
                                        </button>
                                        <a href="/admin/user/clear" class="btn btn-outline-light">
                                            <i class="typcn typcn-refresh mr-1"></i> Làm mới
                                        </a>
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
                                                                    <img src="/admin/images/user/${user.image}"
                                                                        alt="Avatar" class="user-avatar">
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
                                                                    <a href="tel:${user.phone}"
                                                                        class="text-decoration-none">
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
                                                                        ${user.address.length() > 30 ?
                                                                        user.address.substring(0, 30).concat('...') :
                                                                        user.address}
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Chưa có</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${user.roleName == 'ROLE_ADMIN'}">
                                                                    <span class="role-badge role-admin">Admin</span>
                                                                </c:when>
                                                                <c:when test="${user.roleName == 'ROLE_VENDOR'}">
                                                                    <span class="role-badge role-vendor">Vendor</span>
                                                                </c:when>
                                                                <c:when test="${user.roleName == 'ROLE_USER'}">
                                                                    <span class="role-badge role-customer">User</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="role-badge"
                                                                        style="background-color: #6c757d; color: white;">${user.roleName}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="text-center">
                                                            <div class="action-buttons">
                                                                <!-- View User - Direct Link -->
                                                                <a href="/admin/user/detail/${user.id}"
                                                                    class="btn btn-sm btn-outline-info"
                                                                    title="Xem chi tiết">
                                                                    <i class="typcn typcn-eye"></i>
                                                                </a>

                                                                <!-- Edit User - Direct Link -->
                                                                <a href="/admin/user/edit/${user.id}"
                                                                    class="btn btn-sm btn-outline-warning"
                                                                    title="Chỉnh sửa">
                                                                    <i class="typcn typcn-edit"></i>
                                                                </a>

                                                                <!-- Delete User - Form Submission -->
                                                                <form action="/admin/user/delete/${user.id}"
                                                                    method="POST" style="display: inline;"
                                                                    onsubmit="return confirmDelete('${user.fullName}')">
                                                                    <button type="submit"
                                                                        class="btn btn-sm btn-outline-danger"
                                                                        title="Xóa">
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

                <!-- Include Base Scripts -->
                <script src="/admin/vendors/js/vendor.bundle.base.js"></script>
                <script src="/admin/js/off-canvas.js"></script>
                <script src="/admin/js/hoverable-collapse.js"></script>
                <script src="/admin/js/template.js"></script>
                <script src="/admin/js/todolist.js"></script>


                <script src="/admin/js/user/user-actions.js"></script>