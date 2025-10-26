<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/voucher-base.css" />
<link rel="stylesheet" href="/admin/css/voucher-form.css" />

<div class="main-panel">
  <div class="content-wrapper">
    <!-- Flash Messages -->
    <c:if test="${not empty error}">
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="typcn typcn-warning mr-2"></i>
        ${error}
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

    <!-- Header -->
    <div class="form-header">
      <div class="d-flex justify-content-between align-items-center">
        <div>
          <h4 class="mb-1" style="color: #ffffff; font-weight: 600">
            <i class="typcn typcn-edit mr-2"></i>
            Chỉnh sửa Voucher
          </h4>
          <p class="mb-0" style="color: #ffffff; opacity: 0.9">
            Cập nhật thông tin voucher #${voucher.id}
          </p>
        </div>
        <div>
          <a
            href="/admin/voucher/${voucher.id}"
            class="btn"
            style="
              color: #f2e3e3;
              border: 2px solid #f2e3e3;
              background: transparent;
              font-weight: 600;
              transition: 0.3s;
              margin-right: 8px;
            "
          >
            <i class="typcn typcn-eye mr-1"></i> Xem chi tiết
          </a>

          <a
            href="/admin/voucher"
            class="btn"
            style="
              color: #f2e3e3;
              border: 2px solid #f2e3e3;
              background: transparent;
              font-weight: 600;
              transition: 0.3s;
            "
          >
            <i class="typcn typcn-arrow-left mr-1"></i> Quay lại
          </a>
        </div>
      </div>
    </div>

    <!-- Form Card -->
    <div class="form-card">
      <form:form
        method="POST"
        action="/admin/voucher/edit"
        modelAttribute="updateDTO"
        cssClass="voucher-form"
      >
        <form:hidden path="id" />

        <!-- Basic Information -->
        <div class="form-section">
          <h5 class="section-title">
            <i class="typcn typcn-info mr-2"></i>
            Thông tin cơ bản
          </h5>

          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="code" class="form-label required">Mã voucher</label>
                <form:input
                  path="code"
                  cssClass="form-control"
                  id="code"
                  placeholder="Ví dụ: SUMMER2024, NEWUSER..."
                  maxlength="50"
                />
                <form:errors path="code" cssClass="text-danger" />
                <small class="form-text text-muted"
                  >Mã voucher phải là duy nhất trong hệ thống</small
                >
              </div>
            </div>

            <div class="col-md-6">
              <div class="form-group">
                <label for="discountPercent" class="form-label required"
                  >Phần trăm giảm giá (%)</label
                >
                <form:input
                  path="discountPercent"
                  type="number"
                  step="0.01"
                  min="0.01"
                  max="100"
                  cssClass="form-control"
                  id="discountPercent"
                  placeholder="Ví dụ: 10, 25, 50..."
                />
                <form:errors path="discountPercent" cssClass="text-danger" />
                <small class="form-text text-muted">Từ 0.01% đến 100%</small>
              </div>
            </div>
          </div>
        </div>

        <!-- Date Settings -->
        <div class="form-section">
          <h5 class="section-title">
            <i class="typcn typcn-calendar mr-2"></i>
            Thời gian áp dụng
          </h5>

          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="startDate" class="form-label required"
                  >Ngày bắt đầu</label
                >
                <form:input
                  path="startDate"
                  type="datetime-local"
                  cssClass="form-control"
                  id="startDate"
                />
                <form:errors path="startDate" cssClass="text-danger" />
              </div>
            </div>

            <div class="col-md-6">
              <div class="form-group">
                <label for="endDate" class="form-label required"
                  >Ngày kết thúc</label
                >
                <form:input
                  path="endDate"
                  type="datetime-local"
                  cssClass="form-control"
                  id="endDate"
                />
                <form:errors path="endDate" cssClass="text-danger" />
              </div>
            </div>
          </div>

          <div class="alert alert-info">
            <i class="typcn typcn-info mr-2"></i>
            <strong>Lưu ý:</strong> Ngày kết thúc phải sau ngày bắt đầu. Voucher
            sẽ tự động hoạt động trong khoảng thời gian này.
          </div>
        </div>

        <!-- Status Settings -->
        <div class="form-section">
          <h5 class="section-title">
            <i class="typcn typcn-cog mr-2"></i>
            Trạng thái
          </h5>

          <div class="row">
            <div class="col-md-6">
              <div class="form-group">
                <label for="status" class="form-label">Trạng thái</label>
                <form:select path="status" cssClass="form-control" id="status">
                  <form:option value="Active">Hoạt động</form:option>
                  <form:option value="Expired">Không hoạt động</form:option>
                </form:select>
                <form:errors path="status" cssClass="text-danger" />
              </div>
            </div>
          </div>
        </div>

        <!-- Form Actions -->
        <div class="form-actions">
          <button type="submit" class="btn btn-primary">
            <i class="typcn typcn-tick mr-1"></i>
            Cập nhật Voucher
          </button>
          <a href="/admin/voucher/${voucher.id}" class="btn btn-secondary">
            <i class="typcn typcn-times mr-1"></i>
            Hủy bỏ
          </a>
        </div>
      </form:form>
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
    // Format dates for datetime-local input from Java LocalDateTime
    function formatJavaDateTimeForInput(dateTimeStr) {
      if (!dateTimeStr) return "";

      // Convert from Java LocalDateTime format to HTML datetime-local format
      // Java: 2024-10-23T10:30:00 -> HTML: 2024-10-23T10:30
      return dateTimeStr.substring(0, 16);
    }

    // Set current values if they exist
    var startDateValue = "${updateDTO.startDate}";
    var endDateValue = "${updateDTO.endDate}";

    if (startDateValue) {
      $("#startDate").val(formatJavaDateTimeForInput(startDateValue));
    }
    if (endDateValue) {
      $("#endDate").val(formatJavaDateTimeForInput(endDateValue));
    }

    // Validate dates on change
    $("#startDate, #endDate").change(function () {
      var startDate = new Date($("#startDate").val());
      var endDate = new Date($("#endDate").val());

      if (startDate && endDate && endDate <= startDate) {
        alert("Ngày kết thúc phải sau ngày bắt đầu!");
      }
    });

    // Check voucher code uniqueness
    var originalCode = "${updateDTO.code}";
    $("#code").blur(function () {
      var code = $(this).val().trim();
      if (code && code !== originalCode) {
        $.get("/admin/voucher/check-code", {
          code: code,
          excludeId: "${updateDTO.id}",
        }).done(function (isAvailable) {
          if (!isAvailable) {
            $("#code").addClass("is-invalid");
            if (!$("#code").next(".invalid-feedback").length) {
              $("#code").after(
                '<div class="invalid-feedback">Mã voucher đã tồn tại</div>'
              );
            }
          } else {
            $("#code").removeClass("is-invalid");
            $("#code").next(".invalid-feedback").remove();
          }
        });
      }
    });
  });
</script>
