<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/voucher-base.css" />
<link rel="stylesheet" href="/admin/css/voucher-table.css" />
<link rel="stylesheet" href="/admin/css/voucher-moderation.css" />

<div class="main-panel">
  <div class="content-wrapper">
    <!-- Header -->
    <div class="moderation-header">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <h4 class="mb-1">
            <i class="typcn typcn-warning mr-2"></i>
            Kiểm duyệt Voucher Shop
          </h4>
          <p class="mb-0" style="color: #ffffff">
            Quản lý và kiểm duyệt voucher từ các shop
          </p>
        </div>
        <a
          href="/admin/voucher"
          class="btn"
          style="
            border: 1.8px solid #ffffff;
            color: #ffffff;
            background: transparent;
            font-weight: 600;
            transition: 0.3s;
          "
        >
          <i class="typcn typcn-arrow-left mr-1"></i> Quay lại
        </a>
      </div>
    </div>

    <!-- Alert Information -->
    <div class="alert alert-info">
      <i class="typcn typcn-info mr-2"></i>
      <strong>Thông tin:</strong> Trang này hiển thị các voucher từ shop cần
      được kiểm duyệt. Admin có thể khóa các voucher vi phạm chính sách hoặc
      kích hoạt lại các voucher đã bị khóa.
    </div>

    <!-- Moderation Statistics -->
    <div class="stats-card">
      <div class="row">
        <div class="col-md-3">
          <div class="stat-item">
            <h6 class="mb-1">Tổng voucher shop</h6>
            <h3 class="text-primary mb-0">${vouchers.size()}</h3>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stat-item">
            <h6 class="mb-1">Đang hoạt động</h6>
            <h3 class="text-success mb-0">
              <c:set var="activeCount" value="0" />
              <c:forEach var="voucher" items="${vouchers}">
                <c:if test="${voucher.status == 'Active'}">
                  <c:set var="activeCount" value="${activeCount + 1}" />
                </c:if>
              </c:forEach>
              ${activeCount}
            </h3>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stat-item">
            <h6 class="mb-1">Bị khóa</h6>
            <h3 class="text-danger mb-0">
              <c:set var="lockedCount" value="0" />
              <c:forEach var="voucher" items="${vouchers}">
                <c:if test="${voucher.status == 'Expired'}">
                  <c:set var="lockedCount" value="${lockedCount + 1}" />
                </c:if>
              </c:forEach>
              ${lockedCount}
            </h3>
          </div>
        </div>
        <div class="col-md-3">
          <div class="stat-item">
            <h6 class="mb-1">Hết hạn</h6>
            <h3 class="text-warning mb-0">
              <c:set var="expiredCount" value="0" />
              <c:forEach var="voucher" items="${vouchers}">
                <c:if test="${voucher.expired}">
                  <c:set var="expiredCount" value="${expiredCount + 1}" />
                </c:if>
              </c:forEach>
              ${expiredCount}
            </h3>
          </div>
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
                  <th>Shop</th>
                  <th>Giảm giá</th>
                  <th>Ngày bắt đầu</th>
                  <th>Ngày kết thúc</th>
                  <th>Trạng thái</th>
                  <th>Tình trạng</th>
                  <th class="text-center">Hành động kiểm duyệt</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="voucher" items="${vouchers}" varStatus="status">
                  <tr
                    class="moderation-row ${voucher.status == 'Expired' ? 'row-locked' : ''}"
                  >
                    <td><strong>#${voucher.id}</strong></td>
                    <td>
                      <div class="voucher-code">${voucher.code}</div>
                    </td>
                    <td>
                      <a
                        href="/admin/product/shop/${voucher.shopId}"
                        class="text-decoration-none"
                      >
                        ${voucher.shopName}
                      </a>
                    </td>
                    <td>
                      <span class="discount-percent"
                        >${voucher.discountPercent}%</span
                      >
                    </td>
                    <td>
                      <c:set var="start" value="${voucher.startDate}" />
                      <c:if test="${not empty start}">
                        ${start.dayOfMonth}/${start.monthValue}/${start.year}
                        ${start.hour}:${start.minute < 10 ? '0' : ''
                        }${start.minute}
                      </c:if>
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
                          <span class="status-badge status-active"
                            >Hoạt động</span
                          >
                        </c:when>
                        <c:when test="${voucher.status == 'Expired'}">
                          <span class="status-badge status-inactive"
                            >Không hoạt động</span
                          >
                        </c:when>
                        <c:otherwise>
                          <span class="status-badge">${voucher.status}</span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <div class="condition-badges">
                        <c:if test="${voucher.active}">
                          <span class="badge badge-success"
                            >Đang hoạt động</span
                          >
                        </c:if>
                        <c:if test="${voucher.expired}">
                          <span class="badge badge-secondary">Hết hạn</span>
                        </c:if>
                        <c:if test="${!voucher.active && !voucher.expired}">
                          <span class="badge badge-warning"
                            >Chưa hoạt động</span
                          >
                        </c:if>
                      </div>
                    </td>
                    <td class="text-center">
                      <div class="moderation-actions">
                        <!-- View Details -->
                        <a
                          href="/admin/voucher/${voucher.id}"
                          class="btn btn-sm btn-outline-info"
                          title="Xem chi tiết"
                        >
                          <i class="typcn typcn-eye"></i>
                        </a>

                        <!-- Moderation Actions -->
                        <c:choose>
                          <c:when test="${voucher.status == 'Expired'}">
                            <!-- Unlock Action -->
                            <form
                              action="/admin/voucher/${voucher.id}/unlock"
                              method="POST"
                              style="display: inline"
                            >
                              <button
                                type="submit"
                                class="btn btn-sm btn-success"
                                title="Mở khóa voucher"
                              >
                                <i class="typcn typcn-lock-open"></i>
                                Mở khóa
                              </button>
                            </form>
                          </c:when>
                          <c:when test="${voucher.status == 'Active'}">
                            <!-- Lock for Violation -->
                            <button
                              type="button"
                              class="btn btn-sm btn-danger"
                              onclick="showLockModal('${voucher.id}', '${voucher.code}')"
                              title="Khóa vì vi phạm"
                            >
                              <i class="typcn typcn-lock-closed"></i>
                              Khóa vi phạm
                            </button>
                          </c:when>
                        </c:choose>
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
            <i class="typcn typcn-tick"></i>
            <h5>Không có voucher nào cần kiểm duyệt</h5>
            <p class="text-muted">
              Tất cả voucher từ shop đều đã được kiểm duyệt hoặc chưa có voucher
              nào.
            </p>
            <a href="/admin/voucher" class="btn btn-outline-primary">
              <i class="typcn typcn-arrow-left mr-1"></i> Quay lại quản lý
              voucher
            </a>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<!-- Lock Voucher Modal -->
<div
  class="modal fade"
  id="lockVoucherModal"
  tabindex="-1"
  role="dialog"
  aria-labelledby="lockVoucherModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="lockVoucherModalLabel">
          <i class="typcn typcn-lock-closed mr-2"></i>
          Khóa Voucher vì Vi phạm
        </h5>
        <button
          type="button"
          class="close"
          data-dismiss="modal"
          aria-label="Close"
        >
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <form id="lockVoucherForm" method="POST">
        <div class="modal-body">
          <div class="alert alert-warning">
            <i class="typcn typcn-warning mr-2"></i>
            <strong>Cảnh báo:</strong> Bạn đang thực hiện khóa voucher vì vi
            phạm chính sách.
          </div>

          <div class="form-group">
            <label>Voucher sẽ bị khóa:</label>
            <div class="voucher-info">
              <strong id="lockVoucherCode"></strong>
            </div>
          </div>

          <div class="form-group">
            <label for="lockReason">Lý do khóa:</label>
            <select id="lockReason" name="reason" class="form-control">
              <option value="Policy violation">Vi phạm chính sách</option>
              <option value="Spam voucher">Spam voucher</option>
              <option value="Misleading discount">
                Thông tin giảm giá sai lệch
              </option>
              <option value="Expired voucher still active">
                Voucher hết hạn vẫn hoạt động
              </option>
              <option value="Other violation">Vi phạm khác</option>
            </select>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">
            Hủy bỏ
          </button>
          <button type="submit" class="btn btn-danger">
            <i class="typcn typcn-lock-closed mr-1"></i>
            Khóa Voucher
          </button>
        </div>
      </form>
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
  function showLockModal(voucherId, voucherCode) {
    $("#lockVoucherCode").text(voucherCode);
    $("#lockVoucherForm").attr(
      "action",
      "/admin/voucher/" + voucherId + "/lock"
    );
    $("#lockVoucherModal").modal("show");
  }
</script>
