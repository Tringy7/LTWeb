<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
  .order-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 20px;
    border-radius: 10px;
    margin-bottom: 20px;
  }

  .info-card {
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    padding: 15px;
    margin-bottom: 15px;
    background-color: #fff;
  }

  .info-card h5 {
    color: #333;
    border-bottom: 2px solid #007bff;
    padding-bottom: 8px;
    margin-bottom: 15px;
  }

  .table th {
    white-space: nowrap;
    vertical-align: middle;
    text-align: center;
    background-color: #f8f9fa;
  }

  .table td {
    vertical-align: middle;
  }

  .table td img {
    width: 60px;
    height: 60px;
    object-fit: cover;
    border-radius: 8px;
  }

  /* Badge styles */
  .badge-pending {
    background-color: #ffc107;
    color: #000;
  }

  .badge-processing {
    background-color: #17a2b8;
    color: #fff;
  }

  .badge-shipped {
    background-color: #6f42c1;
    color: #fff;
  }

  .badge-delivered {
    background-color: #28a745;
    color: #fff;
  }

  .badge-cancelled {
    background-color: #dc3545;
    color: #fff;
  }

  /* Status update buttons */
  .status-buttons .btn {
    margin-right: 10px;
    margin-bottom: 5px;
  }

  /* Summary box */
  .summary-box {
    background-color: #f8f9fa;
    border: 1px solid #dee2e6;
    border-radius: 8px;
    padding: 20px;
  }

  .summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 10px;
    padding: 5px 0;
  }

  .summary-row.total {
    border-top: 2px solid #007bff;
    padding-top: 15px;
    font-weight: bold;
    font-size: 1.1em;
    color: #007bff;
  }
</style>

<div class="main-panel">
  <div class="content-wrapper">
    <!-- Header -->
    <div class="order-header">
      <div class="row align-items-center">
        <div class="col-8">
          <h2 class="mb-1">Order Details #ORD001</h2>
          <p class="mb-0">Đặt hàng vào ngày 09 Oct 2025 lúc 14:30</p>
        </div>
        <div class="col-4 text-right">
          <span
            class="badge badge-delivered"
            style="font-size: 1em; padding: 8px 15px"
            >Delivered</span
          >
        </div>
      </div>
    </div>

    <div class="row">
      <!-- Customer Information -->
      <div class="col-md-6">
        <div class="info-card">
          <h5><i class="typcn typcn-user mr-2"></i>Thông tin khách hàng</h5>
          <p><strong>Tên:</strong> Nguyễn Văn An</p>
          <p><strong>Email:</strong> nguyenvanan@email.com</p>
          <p><strong>Điện thoại:</strong> 0901234567</p>
          <p>
            <strong>Địa chỉ giao hàng:</strong><br />
            123 Đường Lê Lợi, Phường Bến Nghé,<br />
            Quận 1, TP. Hồ Chí Minh
          </p>
        </div>
      </div>

      <!-- Payment & Shipping Information -->
      <div class="col-md-6">
        <div class="info-card">
          <h5>
            <i class="typcn typcn-credit-card mr-2"></i>Thông tin thanh toán &
            vận chuyển
          </h5>
          <p><strong>Phương thức thanh toán:</strong> Credit Card</p>
          <p><strong>Số thẻ:</strong> **** **** **** 1234</p>
          <p><strong>Phương thức vận chuyển:</strong> Express Delivery</p>
          <p><strong>Phí vận chuyển:</strong> 50,000₫</p>
          <p><strong>Ghi chú:</strong> Giao hàng trong giờ hành chính</p>
        </div>
      </div>
    </div>

    <!-- Order Status Update -->
    <div class="row">
      <div class="col-12">
        <div class="info-card">
          <h5>
            <i class="typcn typcn-cog mr-2"></i>Cập nhật trạng thái đơn hàng
          </h5>
          <div class="status-buttons">
            <button class="btn btn-warning btn-sm">
              <i class="typcn typcn-time mr-1"></i> Pending
            </button>
            <button class="btn btn-info btn-sm">
              <i class="typcn typcn-refresh mr-1"></i> Processing
            </button>
            <button
              class="btn btn-purple btn-sm"
              style="background-color: #6f42c1; color: white"
            >
              <i class="typcn typcn-location-arrow mr-1"></i> Shipped
            </button>
            <button class="btn btn-success btn-sm">
              <i class="typcn typcn-tick mr-1"></i> Delivered
            </button>
            <button class="btn btn-danger btn-sm">
              <i class="typcn typcn-times mr-1"></i> Cancelled
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Order Items -->
    <div class="row">
      <div class="col-12">
        <div class="card">
          <div class="card-body">
            <h5 class="card-title">
              <i class="typcn typcn-shopping-cart mr-2"></i>Chi tiết sản phẩm
            </h5>
            <div class="table-responsive">
              <table class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <th>Hình ảnh</th>
                    <th>Tên sản phẩm</th>
                    <th>Thương hiệu</th>
                    <th>Màu sắc</th>
                    <th>Size</th>
                    <th>Đơn giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>
                      <img
                        src="/client/img/hoodie1.jpg"
                        alt="Hoodie"
                        style="
                          width: 60px;
                          height: 60px;
                          object-fit: cover;
                          border-radius: 8px;
                        "
                      />
                    </td>
                    <td>Áo Hoodie Streetwear</td>
                    <td>UrbanStyle</td>
                    <td>Đen</td>
                    <td>L</td>
                    <td>450,000₫</td>
                    <td>2</td>
                    <td>900,000₫</td>
                  </tr>

                  <tr>
                    <td>
                      <img
                        src="/client/img/jeans1.jpg"
                        alt="Jeans"
                        style="
                          width: 60px;
                          height: 60px;
                          object-fit: cover;
                          border-radius: 8px;
                        "
                      />
                    </td>
                    <td>Quần Jeans Unisex</td>
                    <td>UrbanStyle</td>
                    <td>Xanh đậm</td>
                    <td>32</td>
                    <td>600,000₫</td>
                    <td>1</td>
                    <td>600,000₫</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Order Summary -->
    <div class="row">
      <div class="col-md-8"></div>
      <div class="col-md-4">
        <div class="summary-box">
          <h5 class="mb-3">
            <i class="typcn typcn-calculator mr-2"></i>Tổng kết đơn hàng
          </h5>

          <div class="summary-row">
            <span>Tạm tính:</span>
            <span>1,500,000₫</span>
          </div>

          <div class="summary-row">
            <span>Phí vận chuyển:</span>
            <span>50,000₫</span>
          </div>

          <div class="summary-row">
            <span>Giảm giá:</span>
            <span>-100,000₫</span>
          </div>

          <div class="summary-row total">
            <span>Tổng tiền:</span>
            <span>1,450,000₫</span>
          </div>
        </div>
      </div>
    </div>

    <!-- Order Timeline -->
    <div class="row">
      <div class="col-12">
        <div class="info-card">
          <h5><i class="typcn typcn-flow-merge mr-2"></i>Lịch sử đơn hàng</h5>
          <div class="timeline">
            <div class="timeline-item completed">
              <div class="timeline-marker bg-success"></div>
              <div class="timeline-content">
                <h6 class="timeline-title">Đơn hàng được tạo</h6>
                <p class="timeline-description">09 Oct 2025, 14:30</p>
              </div>
            </div>

            <div class="timeline-item completed">
              <div class="timeline-marker bg-info"></div>
              <div class="timeline-content">
                <h6 class="timeline-title">Xác nhận thanh toán</h6>
                <p class="timeline-description">09 Oct 2025, 14:45</p>
              </div>
            </div>

            <div class="timeline-item completed">
              <div class="timeline-marker bg-warning"></div>
              <div class="timeline-content">
                <h6 class="timeline-title">Đang chuẩn bị hàng</h6>
                <p class="timeline-description">09 Oct 2025, 16:00</p>
              </div>
            </div>

            <div class="timeline-item completed">
              <div class="timeline-marker bg-purple"></div>
              <div class="timeline-content">
                <h6 class="timeline-title">Đã giao cho đơn vị vận chuyển</h6>
                <p class="timeline-description">10 Oct 2025, 09:00</p>
              </div>
            </div>

            <div class="timeline-item completed">
              <div class="timeline-marker bg-success"></div>
              <div class="timeline-content">
                <h6 class="timeline-title">Giao hàng thành công</h6>
                <p class="timeline-description">10 Oct 2025, 15:30</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Action Buttons -->
    <div class="row">
      <div class="col-12 text-center">
        <button class="btn btn-outline-primary mr-2">
          <i class="typcn typcn-printer mr-1"></i> In hóa đơn
        </button>
        <button
          class="btn btn-outline-secondary mr-2"
          onclick="window.history.back()"
        >
          <i class="typcn typcn-arrow-back mr-1"></i> Quay lại
        </button>
        <button class="btn btn-outline-success">
          <i class="typcn typcn-mail mr-1"></i> Gửi email cho khách hàng
        </button>
      </div>
    </div>
  </div>
</div>

<style>
  /* Timeline Styles */
  .timeline {
    position: relative;
    padding-left: 30px;
  }

  .timeline::before {
    content: "";
    position: absolute;
    left: 15px;
    top: 0;
    bottom: 0;
    width: 2px;
    background: #e9ecef;
  }

  .timeline-item {
    position: relative;
    margin-bottom: 20px;
  }

  .timeline-marker {
    position: absolute;
    left: -23px;
    top: 0;
    width: 16px;
    height: 16px;
    border-radius: 50%;
    border: 3px solid #fff;
    box-shadow: 0 0 0 2px #e9ecef;
  }

  .timeline-item.completed .timeline-marker {
    box-shadow: 0 0 0 2px #28a745;
  }

  .timeline-content {
    padding-left: 10px;
  }

  .timeline-title {
    margin: 0;
    font-size: 0.9rem;
    font-weight: 600;
    color: #495057;
  }

  .timeline-description {
    margin: 0;
    font-size: 0.8rem;
    color: #6c757d;
  }

  .bg-purple {
    background-color: #6f42c1 !important;
  }
</style>

<!-- Scripts -->
<script src="/admin/vendors/js/vendor.bundle.base.js"></script>
<script src="/admin/js/off-canvas.js"></script>
<script src="/admin/js/hoverable-collapse.js"></script>
<script src="/admin/js/template.js"></script>
<script src="/admin/js/todolist.js"></script>

<script>
  // Status update functionality
  document.querySelectorAll(".status-buttons .btn").forEach((button) => {
    button.addEventListener("click", function () {
      const status = this.textContent.trim();

      // Remove active class from all buttons
      document.querySelectorAll(".status-buttons .btn").forEach((btn) => {
        btn.classList.remove("active");
      });

      // Add active class to clicked button
      this.classList.add("active");

      // Here you would typically send an AJAX request to update the order status
      console.log("Updating order status to:", status);

      // Show confirmation
      alert("Trạng thái đơn hàng đã được cập nhật thành: " + status);
    });
  });

  // Print invoice functionality
  document
    .querySelector(".btn-outline-primary")
    .addEventListener("click", function () {
      window.print();
    });

  // Send email functionality
  document
    .querySelector(".btn-outline-success")
    .addEventListener("click", function () {
      alert("Chức năng gửi email đang được phát triển!");
    });
</script>
