<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- Link to external CSS file -->
<link
  rel="stylesheet"
  href="<c:url value='/resources/admin/css/vendor-approval.css'/>"
/>

<div class="main-panel">
  <div class="content-wrapper">
    <!-- Page Header -->
    <div class="page-header">
      <h1 class="page-title">
        <i class="typcn typcn-folder-open"></i>
        Quản lý đơn đăng ký cửa hàng
      </h1>
      <p class="page-subtitle">
        Quản lý và duyệt đơn đăng ký cửa hàng từ các vendor
      </p>
    </div>

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

    <!-- Statistics Section -->
    <div class="stats-section">
      <h2 class="stats-title">
        <i class="typcn typcn-chart-bar"></i>
        Thống kê tổng quan
      </h2>

      <div class="stats-grid">
        <div class="stat-card total">
          <div class="stat-number">${statistics.totalApplications}</div>
          <div class="stat-label">Tổng cộng</div>
        </div>
        <div class="stat-card pending">
          <div class="stat-number">${statistics.pendingApplications}</div>
          <div class="stat-label">Chờ duyệt</div>
        </div>
        <div class="stat-card approved">
          <div class="stat-number">${statistics.approvedVendors}</div>
          <div class="stat-label">Đã duyệt</div>
        </div>
        <div class="stat-card rejected">
          <div class="stat-number">${statistics.rejectedApplications}</div>
          <div class="stat-label">Đã từ chối</div>
        </div>
      </div>
    </div>

    <!-- Applications Table -->
    <div class="table-section">
      <div class="table-header">
        <h3 class="table-title">
          <i class="typcn typcn-document-text"></i>
          Danh sách đơn đăng ký
          <span class="record-count">${fn:length(applications)}</span>
        </h3>

        <!-- Filter Tabs -->
        <div class="filter-tabs">
          <a
            href="/admin/vendor-approval"
            class="filter-tab all ${empty status ? 'active' : ''}"
          >
            <i class="typcn typcn-folder"></i>
            Tất cả
          </a>
          <a
            href="/admin/vendor-approval/pending"
            class="filter-tab pending ${status == 'pending' ? 'active' : ''}"
          >
            <i class="typcn typcn-time"></i>
            Chờ duyệt
          </a>
          <a
            href="/admin/vendor-approval/approved"
            class="filter-tab approved ${status == 'approved' ? 'active' : ''}"
          >
            <i class="typcn typcn-tick"></i>
            Đã duyệt
          </a>
          <a
            href="/admin/vendor-approval/rejected"
            class="filter-tab rejected ${status == 'rejected' ? 'active' : ''}"
          >
            <i class="typcn typcn-times"></i>
            Đã từ chối
          </a>
        </div>
      </div>

      <c:choose>
        <c:when test="${not empty applications}">
          <div class="table-responsive">
            <table class="applications-table">
              <thead>
                <tr>
                  <th><i class="typcn typcn-shopping-bag mr-1"></i>Cửa hàng</th>
                  <th><i class="typcn typcn-user mr-1"></i>Chủ cửa hàng</th>
                  <th><i class="typcn typcn-mail mr-1"></i>Liên hệ</th>
                  <th><i class="typcn typcn-calendar mr-1"></i>Ngày đăng ký</th>
                  <th><i class="typcn typcn-info mr-1"></i>Trạng thái</th>
                  <th><i class="typcn typcn-cog mr-1"></i>Hành động</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${applications}" var="app" varStatus="status">
                  <tr>
                    <td>
                      <div class="shop-info">
                        <div class="shop-avatar">
                          ${fn:substring(app.shopName, 0, 1)}
                        </div>
                        <div class="shop-details">
                          <h6>${app.shopName}</h6>
                          <c:if test="${not empty app.description}">
                            <p class="shop-description">
                              ${fn:substring(app.description, 0,
                              60)}${fn:length(app.description) > 60 ? '...' :
                              ''}
                            </p>
                          </c:if>
                        </div>
                      </div>
                    </td>
                    <td>
                      <div class="owner-info">
                        <h6>${app.user.fullName}</h6>
                        <div class="owner-id">ID: ${app.user.id}</div>
                      </div>
                    </td>
                    <td>
                      <div class="contact-info">
                        <a href="mailto:${app.user.email}">
                          <i class="typcn typcn-mail"></i>
                          ${app.user.email}
                        </a>
                        <c:if test="${not empty app.user.phone}">
                          <div class="contact-phone">
                            <i class="typcn typcn-phone"></i>
                            ${app.user.phone}
                          </div>
                        </c:if>
                      </div>
                    </td>
                    <td>
                      <c:set var="dateTime" value="${app.createdAt}" />
                      <c:if test="${not empty dateTime}">
                        <div class="date-info">
                          ${dateTime.dayOfMonth}/${dateTime.monthValue}/${dateTime.year}
                        </div>
                        <div class="time-info">
                          ${dateTime.hour}:${dateTime.minute < 10 ? '0' :
                          ''}${dateTime.minute}
                        </div>
                      </c:if>
                    </td>
                    <td>
                      <c:choose>
                        <c:when
                          test="${app.securityInfo.verificationStatus == 'Pending'}"
                        >
                          <span class="status-badge status-pending">
                            <i class="typcn typcn-time"></i>
                            Chờ duyệt
                          </span>
                        </c:when>
                        <c:when
                          test="${app.securityInfo.verificationStatus == 'Approved'}"
                        >
                          <span class="status-badge status-approved">
                            <i class="typcn typcn-tick"></i>
                            Đã duyệt
                          </span>
                        </c:when>
                        <c:when
                          test="${app.securityInfo.verificationStatus == 'Rejected'}"
                        >
                          <span class="status-badge status-rejected">
                            <i class="typcn typcn-times"></i>
                            Đã từ chối
                          </span>
                        </c:when>
                        <c:otherwise>
                          <span
                            class="status-badge"
                            style="background: #e2e8f0; color: #4a5568"
                          >
                            <i class="typcn typcn-info"></i>
                            Không xác định
                          </span>
                        </c:otherwise>
                      </c:choose>
                    </td>
                    <td>
                      <div class="action-buttons">
                        <a
                          href="/admin/vendor-approval/details/${app.id}"
                          class="action-btn view"
                          title="Xem chi tiết"
                        >
                          <i class="typcn typcn-eye"></i>
                        </a>

                        <c:if
                          test="${app.securityInfo.verificationStatus == 'Pending'}"
                        >
                          <button
                            type="button"
                            class="action-btn approve"
                            onclick="approveApplication('${app.id}', '${fn:escapeXml(app.shopName)}')"
                            title="Duyệt đơn đăng ký"
                          >
                            <i class="typcn typcn-tick"></i>
                          </button>
                          <button
                            type="button"
                            class="action-btn reject"
                            onclick="rejectApplication('${app.id}', '${fn:escapeXml(app.shopName)}')"
                            title="Từ chối đơn đăng ký"
                          >
                            <i class="typcn typcn-times"></i>
                          </button>
                        </c:if>

                        <c:if
                          test="${app.securityInfo.verificationStatus == 'Approved'}"
                        >
                          
                          </a>
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
          <div class="no-data">
            <div class="no-data-icon">
              <i class="typcn typcn-folder-open"></i>
            </div>
            <h5>Không tìm thấy đơn đăng ký nào</h5>
            <p>
              <c:choose>
                <c:when test="${status == 'pending'}">
                  Chưa có đơn đăng ký nào đang chờ duyệt.
                </c:when>
                <c:when test="${status == 'approved'}">
                  Chưa có vendor nào được duyệt.
                </c:when>
                <c:when test="${status == 'rejected'}">
                  Chưa có đơn đăng ký nào bị từ chối.
                </c:when>
                <c:otherwise>
                  Chưa có đơn đăng ký cửa hàng nào trong hệ thống.
                </c:otherwise>
              </c:choose>
            </p>
            <c:if test="${not empty status}">
              <a href="/admin/vendor-approval" class="view-all-btn">
                <i class="typcn typcn-refresh"></i>
                Xem tất cả
              </a>
            </c:if>
          </div>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</div>

<!-- Approve Modal -->
<div
  class="modal fade"
  id="approveModal"
  tabindex="-1"
  role="dialog"
  aria-labelledby="approveModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="approveModalLabel">
          <i class="typcn typcn-tick mr-2"></i>
          Xác nhận duyệt cửa hàng
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
      <div class="modal-body">
        <div class="text-center mb-3">
          <i class="typcn typcn-tick text-success" style="font-size: 3rem"></i>
        </div>
        <p class="text-center">
          Bạn có chắc chắn muốn duyệt cửa hàng
          <strong id="approveShopName"></strong>?
        </p>
        <div class="alert alert-info">
          <i class="typcn typcn-info mr-2"></i>
          <strong>Lưu ý:</strong> Sau khi duyệt, người dùng sẽ trở thành vendor
          và có thể quản lý cửa hàng của mình.
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">
          <i class="typcn typcn-times mr-1"></i>
          Hủy bỏ
        </button>
        <form id="approveForm" method="post" style="display: inline">
          <button type="submit" class="btn btn-success">
            <i class="typcn typcn-tick mr-1"></i>
            Xác nhận duyệt
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Reject Modal -->
<div
  class="modal fade"
  id="rejectModal"
  tabindex="-1"
  role="dialog"
  aria-labelledby="rejectModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="rejectModalLabel">
          <i class="typcn typcn-times mr-2"></i>
          Từ chối đơn đăng ký
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
      <form id="rejectForm" method="post">
        <div class="modal-body">
          <div class="text-center mb-3">
            <i
              class="typcn typcn-times text-danger"
              style="font-size: 3rem"
            ></i>
          </div>
          <p class="text-center">
            Bạn có chắc chắn muốn từ chối cửa hàng
            <strong id="rejectShopName"></strong>?
          </p>

          <div class="form-group">
            <label for="rejectionReason" class="font-weight-bold">
              <i class="typcn typcn-document-text mr-1"></i>
              Lý do từ chối
              <span class="text-danger">*</span>
            </label>
            <textarea
              class="form-control"
              id="rejectionReason"
              name="rejectionReason"
              rows="4"
              placeholder="Vui lòng nhập lý do từ chối đơn đăng ký một cách chi tiết..."
              required
            ></textarea>
            <small class="form-text text-muted">
              Lý do này sẽ được gửi đến người đăng ký để họ hiểu rõ vấn đề cần
              khắc phục.
            </small>
          </div>

          <div class="alert alert-warning">
            <i class="typcn typcn-warning mr-2"></i>
            <strong>Thông báo:</strong> Người dùng sẽ nhận được email thông báo
            về việc từ chối kèm theo lý do bạn cung cấp.
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">
            <i class="typcn typcn-arrow-left mr-1"></i>
            Quay lại
          </button>
          <button type="submit" class="btn btn-danger">
            <i class="typcn typcn-times mr-1"></i>
            Xác nhận từ chối
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<!-- Rejection Reason Modal -->
<div
  class="modal fade"
  id="rejectionReasonModal"
  tabindex="-1"
  role="dialog"
  aria-labelledby="rejectionReasonModalLabel"
  aria-hidden="true"
>
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="rejectionReasonModalLabel">
          <i class="typcn typcn-info mr-2"></i>
          Thông tin từ chối
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
      <div class="modal-body">
        <h6>
          Cửa hàng: <span id="rejectedShopName" class="text-primary"></span>
        </h6>
        <hr />
        <div class="alert alert-warning">
          <i class="typcn typcn-info mr-2"></i>
          <strong>Thông báo:</strong> Đơn đăng ký này đã bị từ chối bởi quản trị
          viên.
        </div>
        <p id="rejectionReasonText" class="text-muted">
          Lý do từ chối sẽ được hiển thị ở đây nếu có.
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">
          <i class="typcn typcn-times mr-1"></i>
          Đóng
        </button>
      </div>
    </div>
  </div>
</div>

<script>
  function approveApplication(appId, shopName) {
    document.getElementById("approveShopName").textContent = shopName;
    document.getElementById("approveForm").action =
      "/admin/vendor-approval/approve/" + appId;
    $("#approveModal").modal("show");
  }

  function rejectApplication(appId, shopName) {
    document.getElementById("rejectShopName").textContent = shopName;
    document.getElementById("rejectForm").action =
      "/admin/vendor-approval/reject/" + appId;
    document.getElementById("rejectionReason").value = "";
    $("#rejectModal").modal("show");
  }

  function showRejectionReason(shopName, reason) {
    document.getElementById("rejectedShopName").textContent = shopName;
    document.getElementById("rejectionReasonText").textContent = reason;
    $("#rejectionReasonModal").modal("show");
  }

  // Initialize tooltips
  $(document).ready(function () {
    $('[data-toggle="tooltip"]').tooltip();

    // Auto-dismiss alerts after 5 seconds
    setTimeout(function () {
      $(".alert").fadeOut("slow");
    }, 5000);

    // Form validation for rejection
    $("#rejectForm").on("submit", function (e) {
      const reason = $("#rejectionReason").val().trim();
      if (reason.length < 10) {
        e.preventDefault();
        alert("Vui lòng nhập lý do từ chối ít nhất 10 ký tự.");
        return false;
      }
    });
  });
</script>
