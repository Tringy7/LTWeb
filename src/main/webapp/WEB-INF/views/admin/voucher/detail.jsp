<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/voucher-base.css" />
<link rel="stylesheet" href="/admin/css/voucher-detail.css" />

<div class="main-panel">
  <div class="content-wrapper">
    <!-- Header -->
    <div class="detail-header">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <h4 class="mb-1">
            <i class="typcn typcn-ticket mr-2"></i>
            Chi tiết Voucher
          </h4>
          <p class="text-muted mb-0">
            Thông tin chi tiết về voucher #${voucher.id}
          </p>
        </div>
        <div>
          <a href="/admin/voucher" class="btn btn-outline-secondary">
            <i class="typcn typcn-arrow-left mr-1"></i> Quay lại
          </a>
          <c:if test="${voucher.voucherType == 'SYSTEM'}">
            <a href="/admin/voucher/edit/${voucher.id}" class="btn btn-warning">
              <i class="typcn typcn-edit mr-1"></i> Chỉnh sửa
            </a>
          </c:if>
        </div>
      </div>
    </div>

    <!-- Main Information Card -->
    <div class="detail-card">
      <div class="row">
        <div class="col-md-8">
          <!-- Basic Information -->
          <div class="info-section">
            <h5 class="section-title">
              <i class="typcn typcn-info mr-2"></i>
              Thông tin cơ bản
            </h5>

            <div class="row">
              <div class="col-sm-6">
                <div class="info-item">
                  <label>ID</label>
                  <div class="value">#${voucher.id}</div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="info-item">
                  <label>Mã voucher</label>
                  <div class="value voucher-code">${voucher.code}</div>
                </div>
              </div>
            </div>

            <div class="row">
              <div class="col-sm-6">
                <div class="info-item">
                  <label>Phần trăm giảm giá</label>
                  <div class="value discount-value">
                    ${voucher.discountPercent}%
                  </div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="info-item">
                  <label>Loại voucher</label>
                  <div class="value">
                    <c:choose>
                      <c:when test="${voucher.voucherType == 'SYSTEM'}">
                        <span class="type-badge type-system"
                          >Voucher hệ thống</span
                        >
                      </c:when>
                      <c:otherwise>
                        <span class="type-badge type-shop">Voucher shop</span>
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
            </div>

            <c:if test="${not empty voucher.shopName}">
              <div class="row">
                <div class="col-sm-12">
                  <div class="info-item">
                    <label>Shop</label>
                    <div class="value">
                      <a
                        href="/admin/product/shop/${voucher.shopId}"
                        class="text-decoration-none"
                      >
                        ${voucher.shopName}
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </c:if>
          </div>

          <!-- Date Information -->
          <div class="info-section">
            <h5 class="section-title">
              <i class="typcn typcn-calendar mr-2"></i>
              Thời gian áp dụng
            </h5>

            <div class="row">
              <div class="col-sm-6">
                <div class="info-item">
                  <label>Ngày bắt đầu</label>
                  <div class="value">
                    <c:set var="start" value="${voucher.startDate}" />
                    <c:if test="${not empty start}">
                      ${start.dayOfMonth}/${start.monthValue}/${start.year}
                      ${start.hour}:${start.minute < 10 ? '0' : ''
                      }${start.minute}:${start.second < 10 ? '0' : ''
                      }${start.second}
                    </c:if>
                  </div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="info-item">
                  <label>Ngày kết thúc</label>
                  <div class="value">
                    <c:set var="dateTime" value="${voucher.endDate}" />
                    <c:if test="${not empty dateTime}">
                      ${dateTime.dayOfMonth}/${dateTime.monthValue}/${dateTime.year}
                      ${dateTime.hour}:${dateTime.minute < 10 ? '0' : ''
                      }${dateTime.minute}
                    </c:if>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- Usage Information -->
          <div class="info-section">
            <h5 class="section-title">
              <i class="typcn typcn-chart-bar mr-2"></i>
              Thông tin sử dụng
            </h5>

            <div class="row">
              <div class="col-sm-6">
                <div class="info-item">
                  <label>Số lần đã sử dụng</label>
                  <div class="value">${voucher.usageCount}</div>
                </div>
              </div>
              <div class="col-sm-6">
                <div class="info-item">
                  <label>Trạng thái hiện tại</label>
                  <div class="value">
                    <c:if test="${voucher.active}">
                      <span class="badge badge-success">Đang hoạt động</span>
                    </c:if>
                    <c:if test="${voucher.expired}">
                      <span class="badge badge-secondary">Đã hết hạn</span>
                    </c:if>
                    <c:if test="${!voucher.active && !voucher.expired}">
                      <span class="badge badge-warning">Chưa hoạt động</span>
                    </c:if>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Status and Actions Card -->
        <div class="col-md-4">
          <div class="status-card">
            <h5 class="section-title">
              <i class="typcn typcn-cog mr-2"></i>
              Trạng thái & Hành động
            </h5>

            <!-- Current Status -->
            <div class="current-status">
              <label>Trạng thái</label>
              <div class="status-display">
                <c:choose>
                  <c:when test="${voucher.status == 'true'}">
                    <span class="status-badge status-active">Hoạt động</span>
                  </c:when>
                  <c:when test="${voucher.status == 'false'}">
                    <span class="status-badge status-inactive"
                      >Không hoạt động</span
                    >
                  </c:when>
                  <c:otherwise>
                    <span class="status-badge">${voucher.status}</span>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
              <label>Hành động nhanh</label>

              <c:choose>
                <c:when test="${voucher.status == 'false'}">
                  <form
                    action="/admin/voucher/${voucher.id}/unlock"
                    method="POST"
                    class="action-form"
                  >
                    <button type="submit" class="btn btn-success btn-block">
                      <i class="typcn typcn-lock-open mr-1"></i>
                      Mở khóa voucher
                    </button>
                  </form>
                </c:when>

                <c:when test="${voucher.status == 'true'}">
                  <form
                    action="/admin/voucher/${voucher.id}/deactivate"
                    method="POST"
                    class="action-form"
                  >
                    <button type="submit" class="btn btn-warning btn-block">
                      <i class="typcn typcn-media-pause mr-1"></i>
                      Tạm dừng
                    </button>
                  </form>

                  <form
                    action="/admin/voucher/${voucher.id}/lock"
                    method="POST"
                    class="action-form"
                    onsubmit="return confirmLock('${voucher.code}')"
                  >
                    <button type="submit" class="btn btn-danger btn-block">
                      <i class="typcn typcn-lock-closed mr-1"></i>
                      Khóa vi phạm
                    </button>
                  </form>
                </c:when>
              </c:choose>

              <!-- Delete action (only for system vouchers) -->
              <c:if test="${voucher.voucherType == 'SYSTEM'}">
                <form
                  action="/admin/voucher/delete/${voucher.id}"
                  method="POST"
                  class="action-form"
                  onsubmit="return confirmDelete('${voucher.code}')"
                >
                  <button
                    type="submit"
                    class="btn btn-outline-danger btn-block"
                  >
                    <i class="typcn typcn-trash mr-1"></i>
                    Xóa voucher
                  </button>
                </form>
              </c:if>
            </div>
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

<script>
  function confirmDelete(voucherCode) {
    return confirm('Bạn có chắc chắn muốn xóa voucher "' + voucherCode + '"?');
  }

  function confirmLock(voucherCode) {
    return confirm(
      'Bạn có chắc chắn muốn khóa voucher "' +
        voucherCode +
        '" vì vi phạm chính sách?'
    );
  }
</script>
