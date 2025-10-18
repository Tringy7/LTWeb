<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/admin/css/dashboard.css">

<div class="main-panel">
    <div class="content-wrapper">
        
        <!-- Page Header -->
        <div class="row">
            <div class="col-sm-6">
                <h3 class="mb-0 font-weight-bold">Dashboard Tổng Quan</h3>
                <p>Chào mừng bạn đến với trang quản trị</p>
            </div>
            <div class="col-sm-6">
                <div class="d-flex align-items-center justify-content-md-end">
                    <div class="mb-3 mb-xl-0 pr-1">
                        <button type="button" class="btn btn-sm bg-white btn-icon-text border">
                            <i class="typcn typcn-calendar-outline mr-2"></i>
                            ${currentDate}
                        </button>
                    </div>
                    <div class="pr-1 mb-3 mr-2 mb-xl-0">
                        <button type="button" class="btn btn-sm bg-white btn-icon-text border" onclick="window.location.reload()">
                            <i class="typcn typcn-refresh mr-2"></i>Làm mới
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Stats Cards -->
        <div class="row mt-4">
            <div class="col-xl-3 col-sm-6 grid-margin stretch-card">
                <div class="card stats-card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-9">
                                <div class="d-flex align-items-center align-self-start">
                                    <h3 class="mb-0">${dashboardStats.totalUsers}</h3>
                                    <c:if test="${dashboardStats.userGrowthPercent >= 0}">
                                        <p class="text-success ml-2 mb-0 font-weight-medium">+${dashboardStats.userGrowthPercent}%</p>
                                    </c:if>
                                    <c:if test="${dashboardStats.userGrowthPercent < 0}">
                                        <p class="text-danger ml-2 mb-0 font-weight-medium">${dashboardStats.userGrowthPercent}%</p>
                                    </c:if>
                                </div>
                                <h6 class="color-gray font-weight-normal mb-0">Tổng Người Dùng</h6>
                            </div>
                            <div class="col-3">
                                <div class="icon icon-box-success">
                                    <span class="typcn typcn-user-outline icon-item"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6 grid-margin stretch-card">
                <div class="card stats-card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-9">
                                <div class="d-flex align-items-center align-self-start">
                                    <h3 class="mb-0">${dashboardStats.totalShops}</h3>
                                    <c:if test="${dashboardStats.shopGrowthPercent >= 0}">
                                        <p class="text-success ml-2 mb-0 font-weight-medium">+${dashboardStats.shopGrowthPercent}%</p>
                                    </c:if>
                                    <c:if test="${dashboardStats.shopGrowthPercent < 0}">
                                        <p class="text-danger ml-2 mb-0 font-weight-medium">${dashboardStats.shopGrowthPercent}%</p>
                                    </c:if>
                                </div>
                                <h6 class="color-gray font-weight-normal mb-0">Tổng Cửa Hàng</h6>
                            </div>
                            <div class="col-3">
                                <div class="icon icon-box-primary">
                                    <span class="typcn typcn-briefcase icon-item"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6 grid-margin stretch-card">
                <div class="card stats-card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-9">
                                <div class="d-flex align-items-center align-self-start">
                                    <h3 class="mb-0">${dashboardStats.totalProducts}</h3>
                                    <c:if test="${dashboardStats.productGrowthPercent >= 0}">
                                        <p class="text-success ml-2 mb-0 font-weight-medium">+${dashboardStats.productGrowthPercent}%</p>
                                    </c:if>
                                    <c:if test="${dashboardStats.productGrowthPercent < 0}">
                                        <p class="text-danger ml-2 mb-0 font-weight-medium">${dashboardStats.productGrowthPercent}%</p>
                                    </c:if>
                                </div>
                                <h6 class="color-gray font-weight-normal mb-0">Tổng Sản Phẩm</h6>
                            </div>
                            <div class="col-3">
                                <div class="icon icon-box-warning">
                                    <span class="typcn typcn-shopping-bag icon-item"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-3 col-sm-6 grid-margin stretch-card">
                <div class="card stats-card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-9">
                                <div class="d-flex align-items-center align-self-start">
                                    <h3 class="mb-0">
                                        <fmt:formatNumber value="${dashboardStats.totalRevenue}" type="currency" currencySymbol="₫"/>
                                    </h3>
                                    <c:if test="${dashboardStats.revenueGrowthPercent >= 0}">
                                        <p class="text-success ml-2 mb-0 font-weight-medium">+${dashboardStats.revenueGrowthPercent}%</p>
                                    </c:if>
                                    <c:if test="${dashboardStats.revenueGrowthPercent < 0}">
                                        <p class="text-danger ml-2 mb-0 font-weight-medium">${dashboardStats.revenueGrowthPercent}%</p>
                                    </c:if>
                                </div>
                                <h6 class="color-gray font-weight-normal mb-0">Doanh Thu Tháng</h6>
                            </div>
                            <div class="col-3">
                                <div class="icon icon-box-danger">
                                    <span class="typcn typcn-chart-line-outline icon-item"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Charts and Detailed Stats -->
        <div class="row">
            <!-- Recent Orders -->
            <div class="col-lg-8 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-wrap justify-content-between">
                            <h4 class="card-title mb-3">Đơn Hàng Gần Đây</h4>
                            <a href="/admin/order" class="btn btn-sm btn-primary">Xem Tất Cả</a>
                        </div>
                        
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>Mã Đơn</th>
                                        <th>Khách Hàng</th>
                                        <th>Cửa Hàng</th>
                                        <th>Tổng Tiền</th>
                                        <th>Trạng Thái</th>
                                        <th>Ngày Tạo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${recentOrders}" varStatus="status">
                                        <c:if test="${status.index < 5}">
                                            <tr>
                                                <td>#${order.id}</td>
                                                <td>
                                                    <div class="customer-info">
                                                        <span class="font-weight-bold">${order.user.fullName}</span>
                                                        <small class="text-muted d-block">${order.user.email}</small>
                                                    </div>
                                                </td>
                                                <td>${order.shop.shopName}</td>
                                                <td>
                                                    <span class="font-weight-bold text-success">
                                                        <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫"/>
                                                    </span>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${order.status == 'New'}">
                                                            <span class="badge badge-warning">Mới</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'PROCESSING'}">
                                                            <span class="badge badge-info">Đang Xử Lý</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'DELIVERED'}">
                                                            <span class="badge badge-success">Đã Giao</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'CANCELLED'}">
                                                            <span class="badge badge-danger">Đã Hủy</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-secondary">${order.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty order.createdAt}">
                                                            ${order.createdAt.toString().substring(0, 16).replace('T', ' ')}
                                                        </c:when>
                                                        <c:otherwise>
                                                            N/A
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                    
                                    <c:if test="${empty recentOrders}">
                                        <tr>
                                            <td colspan="6" class="text-center text-muted">
                                                <i class="typcn typcn-inbox"></i>
                                                Chưa có đơn hàng nào
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions & Stats -->
            <div class="col-lg-4 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title mb-3">Thao Tác Nhanh</h4>
                        
                        <div class="d-grid gap-2 mb-4">
                            <a href="/admin/user/add" class="btn btn-outline-primary">
                                <i class="typcn typcn-user-add mr-2"></i>Thêm Người Dùng
                            </a>
                            <a href="/admin/product/add" class="btn btn-outline-success">
                                <i class="typcn typcn-plus mr-2"></i>Thêm Sản Phẩm
                            </a>
                            <a href="/admin/commission/calculate-this-month" class="btn btn-outline-info">
                                <i class="typcn typcn-calculator mr-2"></i>Tính Hoa Hồng
                            </a>
                        </div>

                        <hr>

                        <h6 class="mb-3">Thống Kê Chi Tiết</h6>
                        
                        <!-- Order Status Distribution -->
                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-2">
                                <small>Đơn Mới</small>
                                <small class="text-primary">${orderStats.newOrders}</small>
                            </div>
                            <div class="progress progress-md">
                                <div class="progress-bar bg-primary" role="progressbar" 
                                     data-width="${orderStats.newOrdersPercent}"></div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-2">
                                <small>Đang Xử Lý</small>
                                <small class="text-info">${orderStats.processingOrders}</small>
                            </div>
                            <div class="progress progress-md">
                                <div class="progress-bar bg-info" role="progressbar" 
                                     data-width="${orderStats.processingOrdersPercent}"></div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-2">
                                <small>Đã Giao</small>
                                <small class="text-success">${orderStats.deliveredOrders}</small>
                            </div>
                            <div class="progress progress-md">
                                <div class="progress-bar bg-success" role="progressbar" 
                                     data-width="${orderStats.deliveredOrdersPercent}"></div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <div class="d-flex justify-content-between mb-2">
                                <small>Đã Hủy</small>
                                <small class="text-danger">${orderStats.cancelledOrders}</small>
                            </div>
                            <div class="progress progress-md">
                                <div class="progress-bar bg-danger" role="progressbar" 
                                     data-width="${orderStats.cancelledOrdersPercent}"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Additional Stats Row -->
        <div class="row">
            <!-- Top Products -->
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <h4 class="card-title mb-3">
                            <i class="typcn typcn-star-outline mr-2"></i>
                            Sản Phẩm Mới Nhất
                        </h4>
                        
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Sản Phẩm</th>
                                        <th>Cửa Hàng</th>
                                        <th>Giá</th>
                                        <th>Danh Mục</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="product" items="${topProducts}" varStatus="status">
                                        <c:if test="${status.index < 10}">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <c:if test="${not empty product.image}">
                                                            <img src="/images/products/${product.image}" 
                                                                 alt="${product.name}" class="product-thumb mr-2">
                                                        </c:if>
                                                        <div>
                                                            <span class="font-weight-bold">${product.name}</span>
                                                            <c:if test="${not empty product.brand}">
                                                                <small class="text-muted d-block">${product.brand}</small>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>${product.shop.shopName}</td>
                                                <td>
                                                    <span class="font-weight-bold text-primary">
                                                        <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₫"/>
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="badge badge-outline-info">${product.category}</span>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                    
                                    <c:if test="${empty topProducts}">
                                        <tr>
                                            <td colspan="4" class="text-center text-muted">
                                                <i class="typcn typcn-shopping-bag"></i>
                                                Chưa có dữ liệu sản phẩm
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Commission Summary -->
        <div class="row">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-wrap justify-content-between mb-3">
                            <h4 class="card-title">
                                <i class="typcn typcn-chart-pie-outline mr-2"></i>
                                Tổng Quan Hoa Hồng
                            </h4>
                            <a href="/admin/commission" class="btn btn-sm btn-primary">
                                <i class="typcn typcn-calculator mr-1"></i>Quản Lý Hoa Hồng
                            </a>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-3">
                                <div class="commission-stat">
                                    <div class="stat-value text-primary">
                                        <fmt:formatNumber value="${commissionStats.totalCommissionAmount}" type="currency" currencySymbol="₫"/>
                                    </div>
                                    <div class="stat-label">Tổng Hoa Hồng</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="commission-stat">
                                    <div class="stat-value text-success">
                                        <fmt:formatNumber value="${commissionStats.collectedAmount}" type="currency" currencySymbol="₫"/>
                                    </div>
                                    <div class="stat-label">Đã Thu</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="commission-stat">
                                    <div class="stat-value text-warning">
                                        <fmt:formatNumber value="${commissionStats.pendingAmount}" type="currency" currencySymbol="₫"/>
                                    </div>
                                    <div class="stat-label">Chờ Thu</div>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="commission-stat">
                                    <div class="stat-value text-info">
                                        ${commissionStats.totalShops}
                                    </div>
                                    <div class="stat-label">Cửa Hàng Có Hoa Hồng</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Include Dashboard Scripts -->
<script src="/admin/vendors/js/vendor.bundle.base.js"></script>
<script src="/admin/js/off-canvas.js"></script>
<script src="/admin/js/hoverable-collapse.js"></script>
<script src="/admin/js/template.js"></script>

<script>
    // Initialize tooltips
    $(function () {
        $('[data-toggle="tooltip"]').tooltip();
    });
    
    // Set progress bar widths from data attributes
    $(document).ready(function() {
        $('.progress-bar[data-width]').each(function() {
            var width = $(this).data('width');
            $(this).css('width', width + '%');
        });
        
     
    });
</script>
