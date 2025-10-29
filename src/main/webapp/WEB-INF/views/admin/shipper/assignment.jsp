<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/shipper-assignment-base.css" />

<div class="main-panel">
  <div class="content-wrapper">
    <!-- Flash Messages -->
    <c:if test="${not empty successMessage}">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="typcn typcn-tick mr-2"></i>
        ${successMessage}
        <button
          type="button"
          class="close"
          data-dismiss="alert"
          aria-label="Close"
        >
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="typcn typcn-warning mr-2"></i>
        ${errorMessage}
        <button
          type="button"
          class="close"
          data-dismiss="alert"
          aria-label="Close"
        >
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    </c:if>

    <!-- Header Section -->
    <div class="search-card">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="mb-0">
          <i class="typcn typcn-user-outline mr-2"></i>
          Phân công Shipper
        </h4>
        <div>
          <c:if test="${hasUnassignedOrders}">
            <form
              action="/admin/shipper-assignment/auto-assign/all"
              method="POST"
              style="display: inline"
            >
              <button
                type="submit"
                class="btn btn-success"
                onclick="return confirm('Bạn có chắc chắn muốn tự động phân công tất cả đơn hàng chưa có shipper?')"
              >
                <i class="typcn typcn-flash mr-1"></i> Tự động phân công tất cả
              </button>
            </form>
          </c:if>
        </div>
      </div>

      <!-- Summary Information -->
      <div class="alert alert-info">
        <div class="row">
          <div class="col-md-6">
            <strong>Tổng số đơn hàng cần phân công:</strong>
            ${unassignedOrders.size()}
          </div>
          <div class="col-md-6">
            <strong>Số nhà vận chuyển hoạt động:</strong>
            <c:set var="activeCarriers" value="0" />
            <c:forEach var="carrier" items="${carriers}">
              <c:if test="${carrier.status == 'ACTIVE'}">
                <c:set var="activeCarriers" value="${activeCarriers + 1}" />
              </c:if>
            </c:forEach>
            ${activeCarriers}
          </div>
        </div>
      </div>
    </div>

    <!-- Carriers Overview -->
    <div class="stats-card">
      <h5 class="mb-3">
        <i class="typcn typcn-business-card mr-2"></i>
        Thông tin các nhà vận chuyển
      </h5>
      <div class="row">
        <c:forEach var="carrier" items="${carriers}" varStatus="status">
          <div class="col-md-4 mb-3">
            <div class="card">
              <div class="card-body">
                <div class="d-flex justify-content-between align-items-start">
                  <div>
                    <h6 class="card-title mb-1">${carrier.name}</h6>
                    <p class="text-muted small mb-2">${carrier.area}</p>
                    <div class="mb-2">
                      <span class="text-muted">Phí vận chuyển:</span>
                      <strong
                        ><fmt:formatNumber
                          value="${carrier.deliveryFee}"
                          type="currency"
                          currencySymbol="₫"
                      /></strong>
                    </div>
                    <div class="mb-2">
                      <span class="text-muted">Số lượng shipper:</span>
                      <strong>${carrier.shippers.size()}</strong>
                    </div>
                    <div class="mb-2">
                      <span class="text-muted">Trạng thái:</span>
                      <c:choose>
                        <c:when test="${carrier.status == 'ACTIVE'}">
                          <span class="badge badge-success">Hoạt động</span>
                        </c:when>
                        <c:otherwise>
                          <span class="badge badge-secondary"
                            >Không hoạt động</span
                          >
                        </c:otherwise>
                      </c:choose>
                    </div>
                  </div>
                </div>

                <c:if test="${carrier.status == 'ACTIVE'}">
                  <div class="mt-3">
                    <a
                      href="/admin/shipper-assignment/carrier?carrierId=${carrier.id}"
                      class="btn btn-outline-primary btn-sm"
                    >
                      <i class="typcn typcn-eye mr-1"></i>
                      Xem chi tiết
                    </a>

                    <!-- Count unassigned orders for this carrier -->
                    <c:set var="carrierUnassignedCount" value="0" />
                    <c:forEach var="order" items="${unassignedOrders}">
                      <c:if test="${order.carrier.id == carrier.id}">
                        <c:set
                          var="carrierUnassignedCount"
                          value="${carrierUnassignedCount + 1}"
                        />
                      </c:if>
                    </c:forEach>

                    <c:if test="${carrierUnassignedCount > 0}">
                      <form
                        action="/admin/shipper-assignment/auto-assign/carrier"
                        method="POST"
                        style="display: inline"
                        class="mt-2"
                      >
                        <input
                          type="hidden"
                          name="carrierId"
                          value="${carrier.id}"
                        />
                        <button
                          type="submit"
                          class="btn btn-warning btn-sm"
                          onclick="return confirm('Tự động phân công ${carrierUnassignedCount} đơn hàng cho ${carrier.name}?')"
                        >
                          <i class="typcn typcn-flash mr-1"></i>
                          Tự động phân công (${carrierUnassignedCount})
                        </button>
                      </form>
                    </c:if>
                  </div>
                </c:if>
              </div>
            </div>
          </div>
        </c:forEach>
      </div>
    </div>

    <!-- Unassigned Orders Overview -->
    <c:if test="${hasUnassignedOrders}">
      <div class="table-container">
        <h5 class="mb-3">
          <i class="typcn typcn-shopping-cart mr-2"></i>
          Đơn hàng chưa được phân công Shipper
        </h5>
        <div class="table-responsive">
          <table class="table table-hover">
            <thead>
              <tr>
                <th>ID Đơn hàng</th>
                <th>Sản phẩm</th>
                <th>Shop</th>
                <th>Nhà vận chuyển</th>
                <th>Số lượng</th>
                <th>Giá trị</th>
                <th>Trạng thái</th>
                <th>Địa chỉ giao hàng</th>
                <th class="text-center">Hành động</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach
                var="orderDetail"
                items="${unassignedOrders}"
                varStatus="status"
              >
                <tr>
                  <td><strong>#${orderDetail.id}</strong></td>
                  <td>
                    <div class="font-weight-bold">
                      ${orderDetail.product.name}
                    </div>
                    <c:if test="${not empty orderDetail.size}">
                      <small class="text-muted"
                        >Size: ${orderDetail.size}</small
                      >
                    </c:if>
                  </td>
                  <td>${orderDetail.shop.shopName}</td>
                  <td>
                    <c:choose>
                      <c:when test="${not empty orderDetail.carrier}">
                        <span class="badge badge-info"
                          >${orderDetail.carrier.name}</span
                        >
                      </c:when>
                      <c:otherwise>
                        <span class="badge badge-secondary">Chưa chọn</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>${orderDetail.quantity}</td>
                  <td>
                    <strong
                      ><fmt:formatNumber
                        value="${orderDetail.finalPrice}"
                        type="currency"
                        currencySymbol="₫"
                    /></strong>
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
                        <span class="badge badge-secondary"
                          >${orderDetail.status}</span
                        >
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${not empty orderDetail.address}">
                        <c:set
                          var="fullAddress"
                          value="${orderDetail.address.receiverAddress}${not empty orderDetail.address.receiverDistrict ? ', '.concat(orderDetail.address.receiverDistrict) : ''}"
                        />
                        <span title="${fullAddress}">
                          ${fullAddress.length() > 30 ? fullAddress.substring(0,
                          30).concat('...') : fullAddress}
                        </span>
                      </c:when>
                      <c:otherwise>
                        <span class="text-muted">Chưa có địa chỉ</span>
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td class="text-center">
                    <c:if test="${not empty orderDetail.carrier}">
                      <a
                        href="/admin/shipper-assignment/carrier?carrierId=${orderDetail.carrier.id}"
                        class="btn btn-sm btn-outline-primary"
                      >
                        <i class="typcn typcn-user-add mr-1"></i>
                        Phân công
                      </a>
                    </c:if>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </div>
    </c:if>

    <!-- No unassigned orders message -->
    <c:if test="${not hasUnassignedOrders}">
      <div class="table-container">
        <div class="no-results">
          <i class="typcn typcn-tick"></i>
          <h5>Tất cả đơn hàng đã được phân công Shipper</h5>
          <p class="text-muted">
            Hiện tại không có đơn hàng nào cần phân công Shipper.
          </p>
        </div>
      </div>
    </c:if>
  </div>
</div>

<!-- Include Base Scripts -->
<script src="/admin/vendors/js/vendor.bundle.base.js"></script>
<script src="/admin/js/off-canvas.js"></script>
<script src="/admin/js/hoverable-collapse.js"></script>
<script src="/admin/js/template.js"></script>
<script src="/admin/js/todolist.js"></script>

<script>
  // Simple alert auto-hide
  $(document).ready(function () {
    // Auto-hide success messages after 5 seconds
    setTimeout(function () {
      $(".alert-success").fadeOut();
    }, 5000);

    // Initialize tooltips for address truncation
    $("[title]").tooltip();
  });
</script>
