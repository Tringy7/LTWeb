<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="main-panel">
  <div class="content-wrapper">
    <!-- Header Section -->
    <div class="search-card">
      <h4 class="mb-0">
        <i class="typcn typcn-group mr-2"></i>
        Tổng quan hệ thống Shipper
      </h4>
    </div>

    <!-- Quick Stats -->
    <div class="row mb-4">
      <div class="col-md-3">
        <div class="card bg-primary text-white">
          <div class="card-body">
            <div class="d-flex justify-content-between">
              <div>
                <h4 class="mb-0">0</h4>
                <p class="mb-0">Tổng Shipper</p>
              </div>
              <i
                class="typcn typcn-group"
                style="font-size: 2rem; opacity: 0.7"
              ></i>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card bg-success text-white">
          <div class="card-body">
            <div class="d-flex justify-content-between">
              <div>
                <h4 class="mb-0">0</h4>
                <p class="mb-0">Shipper hoạt động</p>
              </div>
              <i
                class="typcn typcn-tick"
                style="font-size: 2rem; opacity: 0.7"
              ></i>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card bg-warning text-white">
          <div class="card-body">
            <div class="d-flex justify-content-between">
              <div>
                <h4 class="mb-0">0</h4>
                <p class="mb-0">Đơn hàng chờ phân công</p>
              </div>
              <i
                class="typcn typcn-shopping-cart"
                style="font-size: 2rem; opacity: 0.7"
              ></i>
            </div>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card bg-info text-white">
          <div class="card-body">
            <div class="d-flex justify-content-between">
              <div>
                <h4 class="mb-0">0</h4>
                <p class="mb-0">Nhà vận chuyển</p>
              </div>
              <i
                class="typcn typcn-business-card"
                style="font-size: 2rem; opacity: 0.7"
              ></i>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Quick Actions -->
    <div class="stats-card">
      <h5 class="mb-3">
        <i class="typcn typcn-flash mr-2"></i>
        Thao tác nhanh
      </h5>
      <div class="row">
        <div class="col-md-4 mb-3">
          <div class="card">
            <div class="card-body text-center">
              <i
                class="typcn typcn-user-add"
                style="font-size: 3rem; color: #2196f3; margin-bottom: 1rem"
              ></i>
              <h6 class="card-title">Phân công Shipper</h6>
              <p class="card-text text-muted">
                Phân công shipper cho các đơn hàng chờ xử lý
              </p>
              <a href="/admin/shipper-assignment" class="btn btn-primary">
                <i class="typcn typcn-arrow-forward mr-1"></i>
                Bắt đầu
              </a>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-3">
          <div class="card">
            <div class="card-body text-center">
              <i
                class="typcn typcn-chart-bar"
                style="font-size: 3rem; color: #4caf50; margin-bottom: 1rem"
              ></i>
              <h6 class="card-title">Theo dõi hiệu suất</h6>
              <p class="card-text text-muted">
                Xem báo cáo hiệu suất và thống kê shipper
              </p>
              <a href="#" class="btn btn-success" onclick="showComingSoon()">
                <i class="typcn typcn-arrow-forward mr-1"></i>
                Xem báo cáo
              </a>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-3">
          <div class="card">
            <div class="card-body text-center">
              <i
                class="typcn typcn-cog"
                style="font-size: 3rem; color: #ff9800; margin-bottom: 1rem"
              ></i>
              <h6 class="card-title">Quản lý Shipper</h6>
              <p class="card-text text-muted">
                Thêm, sửa, xóa thông tin shipper
              </p>
              <a href="#" class="btn btn-warning" onclick="showComingSoon()">
                <i class="typcn typcn-arrow-forward mr-1"></i>
                Quản lý
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Recent Activity -->
    <div class="table-container">
      <h5 class="mb-3">
        <i class="typcn typcn-time mr-2"></i>
        Hoạt động gần đây
      </h5>
      <div class="no-results">
        <i class="typcn typcn-info"></i>
        <h6>Không có hoạt động gần đây</h6>
        <p class="text-muted">
          Các hoạt động phân công shipper sẽ được hiển thị tại đây.
        </p>
        <a href="/admin/shipper-assignment" class="btn btn-outline-primary">
          <i class="typcn typcn-plus mr-1"></i>
          Bắt đầu phân công
        </a>
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
  function showComingSoon() {
    alert(
      "Tính năng này đang được phát triển và sẽ có trong phiên bản tiếp theo."
    );
  }

  // Simulate loading stats (replace with actual data from controller)
  $(document).ready(function () {
    // In a real implementation, you would load these from your controller
    // For demonstration, we'll use placeholder values
    setTimeout(function () {
      $(".card.bg-primary h4").text("12");
      $(".card.bg-success h4").text("8");
      $(".card.bg-warning h4").text("5");
      $(".card.bg-info h4").text("3");
    }, 1000);
  });
</script>
