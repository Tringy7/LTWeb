<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

                <!-- Include CSS Files -->
                <link rel="stylesheet" href="/admin/css/shipper-assignment-base.css">

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

                        <!-- Header Section -->
                        <div class="search-card">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4 class="mb-0">
                                    <i class="typcn typcn-business-card mr-2"></i>
                                    Chi tiết nhà vận chuyển
                                </h4>
                                <div>
                                    <a href="/admin/shipper-assignment" class="btn btn-outline-secondary btn-sm">
                                        <i class="typcn typcn-arrow-back mr-1"></i>
                                        Quay lại danh sách
                                    </a>
                                    <a href="/admin/shipper-assignment?search=" class="btn btn-outline-info btn-sm">
                                        <i class="typcn typcn-zoom mr-1"></i>
                                        Tìm kiếm carriers
                                    </a>
                                    <c:if test="${not empty unassignedOrders}">
                                        <form action="/admin/shipper-assignment/auto-assign/carrier" method="POST"
                                            style="display: inline;">
                                            <input type="hidden" name="carrierId" value="${carrierId}" />
                                            <button type="submit" class="btn btn-warning"
                                                onclick="return confirm('Bạn có chắc chắn muốn tự động phân công ${unassignedOrders.size()} đơn hàng chưa được phân công?')">
                                                <i class="typcn typcn-flash mr-1"></i>
                                                Tự động phân công (${unassignedOrders.size()})
                                            </button>
                                        </form>
                                    </c:if>
                                </div>
                            </div>
                        </div>

                        <!-- Available Shippers Section -->
                        <div class="stats-card">
                            <h5 class="mb-3">
                                <i class="typcn typcn-group mr-2"></i>
                                Danh sách Shipper có sẵn
                            </h5>

                            <c:choose>
                                <c:when test="${not empty availableShippers}">
                                    <div class="row">
                                        <c:forEach var="shipper" items="${availableShippers}" varStatus="status">
                                            <div class="col-md-4 mb-3">
                                                <div class="card shipper-card">
                                                    <div class="card-body">
                                                        <div class="d-flex align-items-center mb-2">
                                                            <div class="shipper-avatar">
                                                                <c:choose>
                                                                    <c:when test="${not empty shipper.user.image}">
                                                                        <img src="/admin/images/user/${shipper.user.image}"
                                                                            alt="Shipper Avatar" class="rounded-circle"
                                                                            width="40" height="40">
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="avatar-placeholder rounded-circle d-flex align-items-center justify-content-center"
                                                                            style="width: 40px; height: 40px; background: linear-gradient(45deg, #667eea, #764ba2); color: white; font-weight: bold;">
                                                                            ${shipper.name.substring(0,
                                                                            1).toUpperCase()}
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                            <div class="ml-3">
                                                                <h6 class="mb-1">${shipper.name}</h6>
                                                                <span class="badge badge-success">Có sẵn</span>
                                                            </div>
                                                        </div>

                                                        <div class="shipper-info">
                                                            <c:if test="${not empty shipper.phone}">
                                                                <div class="mb-1">
                                                                    <i class="typcn typcn-phone mr-1"></i>
                                                                    <small>${shipper.phone}</small>
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${not empty shipper.vehicleNumber}">
                                                                <div class="mb-1">
                                                                    <i class="typcn typcn-device-desktop mr-1"></i>
                                                                    <small>Xe: ${shipper.vehicleNumber}</small>
                                                                </div>
                                                            </c:if>

                                                            <!-- Current workload -->
                                                            <div class="mt-2">
                                                                <small class="text-muted">Đơn hàng hiện tại:</small>
                                                                <c:set var="currentOrders" value="0" />
                                                                <c:if test="${not empty shipper.orders}">
                                                                    <c:forEach var="order" items="${shipper.orders}">
                                                                        <c:if
                                                                            test="${order.status != 'DELIVERED' && order.status != 'CANCELLED'}">
                                                                            <c:set var="currentOrders"
                                                                                value="${currentOrders + 1}" />
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </c:if>
                                                                <span class="badge badge-info">${currentOrders}</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning">
                                        <i class="typcn typcn-warning mr-2"></i>
                                        Không có shipper nào có sẵn cho nhà vận chuyển này.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Unassigned Orders for this Carrier -->
                        <div class="table-container">
                            <h5 class="mb-3">
                                <i class="typcn typcn-shopping-cart mr-2"></i>
                                Đơn hàng chưa được phân công
                            </h5>

                            <c:choose>
                                <c:when test="${not empty unassignedOrders}">
                                    <div class="table-responsive">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Sản phẩm</th>
                                                    <th>Shop</th>
                                                    <th>Số lượng</th>
                                                    <th>Giá trị</th>
                                                    <th>Trạng thái</th>
                                                    <th>Địa chỉ giao hàng</th>
                                                    <th>Thời gian đặt</th>
                                                    <th class="text-center">Phân công</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="orderDetail" items="${unassignedOrders}"
                                                    varStatus="status">
                                                    <tr>
                                                        <td><strong>#${orderDetail.id}</strong></td>
                                                        <td>
                                                            <div class="font-weight-bold">${orderDetail.product.name}
                                                            </div>
                                                            <c:if test="${not empty orderDetail.size}">
                                                                <small class="text-muted">Size:
                                                                    ${orderDetail.size}</small>
                                                            </c:if>
                                                        </td>
                                                        <td>${orderDetail.shop.shopName}</td>
                                                        <td>${orderDetail.quantity}</td>
                                                        <td>
                                                            <strong>
                                                                <fmt:formatNumber value="${orderDetail.finalPrice}"
                                                                    type="currency" currencySymbol="₫" />
                                                            </strong>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${orderDetail.status == 'CONFIRMED'}">
                                                                    <span class="badge badge-warning">Đã xác nhận</span>
                                                                </c:when>
                                                                <c:when test="${orderDetail.status == 'PROCESSING'}">
                                                                    <span class="badge badge-info">Đang xử lý</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="badge badge-secondary">${orderDetail.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty orderDetail.address}">
                                                                    <c:set var="fullAddress"
                                                                        value="${orderDetail.address.receiverAddress}${not empty orderDetail.address.receiverDistrict ? ', '.concat(orderDetail.address.receiverDistrict) : ''}" />
                                                                    <span title="${fullAddress}">
                                                                        ${fullAddress.length() > 40 ?
                                                                        fullAddress.substring(0, 40).concat('...') :
                                                                        fullAddress}
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Chưa có địa chỉ</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:set var="dateTime"
                                                                value="${orderDetail.order.createdAt}" />
                                                            <c:if test="${not empty dateTime}">
                                                                ${dateTime.dayOfMonth}/${dateTime.monthValue}/${dateTime.year}
                                                                ${dateTime.hour}:${dateTime.minute < 10 ? '0' : ''
                                                                    }${dateTime.minute} </c:if>
                                                        </td>

                                                        <td class="text-center">
                                                            <c:choose>
                                                                <c:when test="${not empty availableShippers}">
                                                                    <div class="dropdown">
                                                                        <button
                                                                            class="btn btn-sm btn-outline-primary dropdown-toggle"
                                                                            type="button"
                                                                            id="shipperDropdown${orderDetail.id}"
                                                                            data-toggle="dropdown" aria-haspopup="true"
                                                                            aria-expanded="false">
                                                                            <i class="typcn typcn-user-add mr-1"></i>
                                                                            Chọn Shipper
                                                                        </button>
                                                                        <div class="dropdown-menu"
                                                                            aria-labelledby="shipperDropdown${orderDetail.id}">
                                                                            <c:forEach var="shipper"
                                                                                items="${availableShippers}">
                                                                                <form
                                                                                    action="/admin/shipper-assignment/assign"
                                                                                    method="POST"
                                                                                    style="display: inline;">
                                                                                    <input type="hidden"
                                                                                        name="orderDetailId"
                                                                                        value="${orderDetail.id}" />
                                                                                    <input type="hidden"
                                                                                        name="shipperId"
                                                                                        value="${shipper.id}" />
                                                                                    <input type="hidden"
                                                                                        name="carrierId"
                                                                                        value="${carrierId}" />
                                                                                    <button type="submit"
                                                                                        class="dropdown-item"
                                                                                        onclick="return confirm('Phân công đơn hàng #${orderDetail.id} cho ${shipper.name}?')">
                                                                                        <div
                                                                                            class="d-flex align-items-center">
                                                                                            <c:choose>
                                                                                                <c:when
                                                                                                    test="${not empty shipper.user.image}">
                                                                                                    <img src="${shipper.user.image}"
                                                                                                        alt="Avatar"
                                                                                                        class="rounded-circle mr-2"
                                                                                                        width="20"
                                                                                                        height="20">
                                                                                                </c:when>
                                                                                                <c:otherwise>
                                                                                                    <div class="avatar-placeholder rounded-circle mr-2 d-flex align-items-center justify-content-center"
                                                                                                        style="width: 20px; height: 20px; background: linear-gradient(45deg, #667eea, #764ba2); color: white; font-size: 10px; font-weight: bold;">
                                                                                                        ${shipper.name.substring(0,
                                                                                                        1).toUpperCase()}
                                                                                                    </div>
                                                                                                </c:otherwise>
                                                                                            </c:choose>
                                                                                            <div>
                                                                                                <div
                                                                                                    class="font-weight-bold">
                                                                                                    ${shipper.name}
                                                                                                </div>
                                                                                                <c:if
                                                                                                    test="${not empty shipper.vehicleNumber}">
                                                                                                    <small
                                                                                                        class="text-muted">${shipper.vehicleNumber}</small>
                                                                                                </c:if>
                                                                                            </div>
                                                                                        </div>
                                                                                    </button>
                                                                                </form>
                                                                            </c:forEach>
                                                                        </div>
                                                                    </div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="text-muted">Không có shipper</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-results">
                                        <i class="typcn typcn-tick"></i>
                                        <h5>Tất cả đơn hàng đã được phân công</h5>
                                        <p class="text-muted">
                                            Không có đơn hàng nào cần phân công cho nhà vận chuyển này.
                                        </p>
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
                    $(document).ready(function () {
                        // Initialize tooltips
                        $('[title]').tooltip();

                        // Auto-hide success messages after 5 seconds
                        setTimeout(function () {
                            $('.alert-success').fadeOut();
                        }, 5000);

                        // Enhanced dropdown functionality
                        $('.dropdown-toggle').dropdown();
                    });
                </script>

                <style>
                    .shipper-card {
                        transition: transform 0.2s ease-in-out;
                        border: 1px solid #e3f2fd;
                    }

                    .shipper-card:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    }

                    .dropdown-menu {
                        max-height: 300px;
                        overflow-y: auto;
                    }

                    .dropdown-item {
                        padding: 0.75rem 1rem;
                        border-bottom: 1px solid #f8f9fa;
                    }

                    .dropdown-item:hover {
                        background-color: #f8f9fa;
                    }

                    .dropdown-item:last-child {
                        border-bottom: none;
                    }

                    .table-warning {
                        background-color: #fff3cd !important;
                    }

                    .avatar-placeholder {
                        flex-shrink: 0;
                    }
                </style>