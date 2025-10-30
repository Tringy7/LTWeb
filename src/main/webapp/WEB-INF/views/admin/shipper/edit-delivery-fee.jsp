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
          <i class="typcn typcn-edit mr-2"></i>
          Chỉnh sửa phí vận chuyển
        </h4>
        <a href="/admin/shipper-assignment" class="btn btn-secondary">
          <i class="typcn typcn-arrow-left mr-1"></i>
          Quay lại
        </a>
      </div>
    </div>

    <!-- Edit Form -->
    <div class="table-container">
      <div class="card">
        <div class="card-header">
          <h5 class="mb-0">
            <i class="typcn typcn-business-card mr-2"></i>
            Thông tin nhà vận chuyển: ${carrier.name}
          </h5>
        </div>
        <div class="card-body">
          <form
            action="/admin/shipper-assignment/carrier/update-fee"
            method="POST"
            id="updateFeeForm"
          >
            <input type="hidden" name="carrierId" value="${carrier.id}" />

            <div class="row">
              <!-- Carrier Information Display -->
              <div class="col-md-6">
                <h6 class="mb-3">Thông tin hiện tại</h6>

                <div class="form-group">
                  <label class="form-label">Tên nhà vận chuyển:</label>
                  <p class="form-control-plaintext">${carrier.name}</p>
                </div>

                <div class="form-group">
                  <label class="form-label">Khu vực:</label>
                  <p class="form-control-plaintext">
                    <c:choose>
                      <c:when test="${not empty carrier.area}">
                        ${carrier.area}
                      </c:when>
                      <c:otherwise>
                        <span class="text-muted">Chưa xác định</span>
                      </c:otherwise>
                    </c:choose>
                  </p>
                </div>

                <div class="form-group">
                  <label class="form-label">Trạng thái:</label>
                  <p class="form-control-plaintext">
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
                  </p>
                </div>

                <div class="form-group">
                  <label class="form-label">Số điện thoại:</label>
                  <p class="form-control-plaintext">
                    <c:choose>
                      <c:when test="${not empty carrier.contactPhone}">
                        ${carrier.contactPhone}
                      </c:when>
                      <c:otherwise>
                        <span class="text-muted">Chưa có</span>
                      </c:otherwise>
                    </c:choose>
                  </p>
                </div>

                <div class="form-group">
                  <label class="form-label">Email:</label>
                  <p class="form-control-plaintext">
                    <c:choose>
                      <c:when test="${not empty carrier.email}">
                        ${carrier.email}
                      </c:when>
                      <c:otherwise>
                        <span class="text-muted">Chưa có</span>
                      </c:otherwise>
                    </c:choose>
                  </p>
                </div>
              </div>

              <!-- Delivery Fee Edit Section -->
              <div class="col-md-6">
                <h6 class="mb-3">Cập nhật phí vận chuyển</h6>

                <div class="form-group">
                  <label for="currentFee" class="form-label"
                    >Phí vận chuyển hiện tại:</label
                  >
                  <div class="input-group">
                    <input
                      type="text"
                      class="form-control"
                      id="currentFee"
                      value="<fmt:formatNumber value='${carrier.deliveryFee}' type='number' maxFractionDigits='0'/>"
                      readonly
                    />
                    <div class="input-group-append">
                      <span class="input-group-text">₫</span>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label for="deliveryFee" class="form-label"
                    >Phí vận chuyển mới:
                    <span class="text-danger">*</span></label
                  >
                  <div class="input-group">
                    <input
                      type="number"
                      class="form-control"
                      id="deliveryFee"
                      name="deliveryFee"
                      value="${carrier.deliveryFee}"
                      min="0"
                      step="1000"
                      required
                    />
                    <div class="input-group-append">
                      <span class="input-group-text">₫</span>
                    </div>
                  </div>
                  <small class="form-text text-muted">
                    Nhập phí vận chuyển mới (VND). Giá trị phải lớn hơn hoặc
                    bằng 0.
                  </small>
                </div>

                <div class="form-group">
                  <div class="custom-control custom-checkbox">
                    <input
                      type="checkbox"
                      class="custom-control-input"
                      id="confirmUpdate"
                      required
                    />
                    <label class="custom-control-label" for="confirmUpdate">
                      Tôi xác nhận muốn cập nhật phí vận chuyển cho nhà vận
                      chuyển này
                    </label>
                  </div>
                </div>

                <!-- Action Buttons -->
                <div class="form-group mb-0">
                  <button type="submit" class="btn btn-primary mr-2">
                    <i class="typcn typcn-tick mr-1"></i>
                    Cập nhật phí vận chuyển
                  </button>
                  <a href="/admin/shipper-assignment" class="btn btn-secondary">
                    <i class="typcn typcn-times mr-1"></i>
                    Hủy
                  </a>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Additional Information -->
    <div class="stats-card">
      <div class="alert alert-info">
        <h6><i class="typcn typcn-info mr-2"></i>Lưu ý quan trọng:</h6>
        <ul class="mb-0">
          <li>
            Việc thay đổi phí vận chuyển sẽ ảnh hưởng đến tất cả đơn hàng mới
            của nhà vận chuyển này.
          </li>
          <li>
            Các đơn hàng đã được xác nhận sẽ không bị ảnh hưởng bởi thay đổi
            này.
          </li>
          <li>
            Hãy đảm bảo phí vận chuyển phù hợp với thỏa thuận với nhà vận
            chuyển.
          </li>
          <li>Thay đổi sẽ có hiệu lực ngay lập tức sau khi cập nhật.</li>
        </ul>
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
  $(document).ready(function () {
    // Auto-hide success messages after 5 seconds
    setTimeout(function () {
      $(".alert-success").fadeOut();
    }, 5000);

    // Format delivery fee input as currency
    $("#deliveryFee").on("input", function () {
      let value = $(this).val();
      if (value) {
        // Remove any non-digits
        value = value.replace(/\D/g, "");
        // Format with thousands separator (optional enhancement)
        $(this).val(value);
      }
    });

    // Form validation
    $("#updateFeeForm").on("submit", function (e) {
      const deliveryFee = parseFloat($("#deliveryFee").val());
      const currentFee = parseFloat($("#currentFee").val().replace(/,/g, ""));

      if (isNaN(deliveryFee) || deliveryFee < 0) {
        e.preventDefault();
        alert("Vui lòng nhập phí vận chuyển hợp lệ (số dương).");
        return false;
      }

      if (!$("#confirmUpdate").is(":checked")) {
        e.preventDefault();
        alert("Vui lòng xác nhận việc cập nhật phí vận chuyển.");
        return false;
      }

      // Show confirmation dialog
      if (deliveryFee !== currentFee) {
        const formattedOldFee = currentFee.toLocaleString("vi-VN") + "₫";
        const formattedNewFee = deliveryFee.toLocaleString("vi-VN") + "₫";

        if (
          !confirm(
            `Bạn có chắc chắn muốn thay đổi phí vận chuyển từ ${formattedOldFee} thành ${formattedNewFee}?`
          )
        ) {
          e.preventDefault();
          return false;
        }
      }
    });
  });
</script>
