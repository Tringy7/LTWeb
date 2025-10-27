<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form" %>

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
          <h4 class="mb-1">
            <i class="typcn typcn-ticket mr-2"></i>
            Tạo Voucher Hệ Thống
          </h4>
          <p class="mb-0" style="color: #ffffff; font-weight: 400">
            Tạo voucher áp dụng cho toàn hệ thống
          </p>
        </div>
        <a href="/admin/voucher" class="btn btn-outline-secondary">
          <i class="typcn typcn-arrow-left mr-1"></i> Quay lại
        </a>
      </div>
    </div>

    <!-- Form Card -->
    <div class="form-card">
      <form:form
        method="POST"
        action="/admin/voucher/create"
        modelAttribute="createDTO"
        cssClass="voucher-form"
      >
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
                <label for="status" class="form-label"
                  >Trạng thái ban đầu</label
                >
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
            Tạo Voucher
          </button>
          <a href="/admin/voucher" class="btn btn-secondary">
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
    // Set default dates
    var now = new Date();
    var tomorrow = new Date(now);
    tomorrow.setDate(tomorrow.getDate() + 1);
    var nextWeek = new Date(now);
    nextWeek.setDate(nextWeek.getDate() + 7);

    // Format dates for datetime-local input
    function formatDateTime(date) {
      return (
        date.getFullYear() +
        "-" +
        String(date.getMonth() + 1).padStart(2, "0") +
        "-" +
        String(date.getDate()).padStart(2, "0") +
        "T" +
        String(date.getHours()).padStart(2, "0") +
        ":" +
        String(date.getMinutes()).padStart(2, "0")
      );
    }

    // Set default values if not already set
    if (!$("#startDate").val()) {
      $("#startDate").val(formatDateTime(tomorrow));
    }
    if (!$("#endDate").val()) {
      $("#endDate").val(formatDateTime(nextWeek));
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
    $("#code").blur(function () {
      var code = $(this).val().trim();
      if (code) {
        $.get("/admin/voucher/check-code", { code: code }).done(function (
          isAvailable
        ) {
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
