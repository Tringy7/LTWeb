<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/commission-base.css" />
<link rel="stylesheet" href="/admin/css/commission-detail.css" />

<div class="main-panel">
  <div class="content-wrapper">
    <!-- Breadcrumb -->
    <div class="page-header">
      <h3 class="page-title">
        <span class="page-title-icon bg-gradient-primary text-white me-2">
          <i class="mdi mdi-cash-multiple"></i>
        </span>
        Chi tiết Hoa hồng
      </h3>
      <nav aria-label="breadcrumb">
        <ul class="breadcrumb">
          <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
          <li class="breadcrumb-item">
            <a href="/admin/commission">Hoa hồng</a>
          </li>
          <li class="breadcrumb-item active" aria-current="page">Chi tiết</li>
        </ul>
      </nav>
    </div>

    <!-- Commission Detail -->
    <div class="row">
      <div class="col-md-8">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">Thông tin Hoa hồng</h4>

            <div class="row">
              <div class="col-md-6">
                <div class="detail-group">
                  <label class="detail-label">ID Hoa hồng</label>
                  <div class="detail-value">#${commission.id}</div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Tên cửa hàng</label>
                  <div class="detail-value">${commission.shopName}</div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">ID Cửa hàng</label>
                  <div class="detail-value">${commission.shopId}</div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Khoảng thời gian tính</label>
                  <div class="detail-value">
                    <fmt:formatDate
                      value="${commission.fromDateAsDate}"
                      pattern="dd/MM/yyyy"
                    />
                    -
                    <fmt:formatDate
                      value="${commission.toDateAsDate}"
                      pattern="dd/MM/yyyy"
                    />
                  </div>
                </div>
              </div>

              <div class="col-md-6">
                <div class="detail-group">
                  <label class="detail-label">Tổng doanh thu</label>
                  <div class="detail-value revenue-value">
                    <fmt:formatNumber
                      value="${commission.totalRevenue}"
                      type="currency"
                      currencySymbol="₫"
                      maxFractionDigits="0"
                    />
                  </div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Tỷ lệ hoa hồng</label>
                  <div class="detail-value">
                    <fmt:formatNumber
                      value="${commission.commissionRate * 100}"
                      pattern="#0.##"
                    />%
                  </div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Số tiền hoa hồng</label>
                  <div class="detail-value commission-value">
                    <fmt:formatNumber
                      value="${commission.commissionAmount}"
                      type="currency"
                      currencySymbol="₫"
                      maxFractionDigits="0"
                    />
                  </div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Trạng thái</label>
                  <div class="detail-value">
                    <c:choose>
                      <c:when
                        test="${commission.status == 'PENDING' || commission.status == 'pending'}"
                      >
                        <span class="badge badge-warning">Chờ thu</span>
                      </c:when>
                      <c:when
                        test="${commission.status == 'COLLECTED' || commission.status == 'collected'}"
                      >
                        <span class="badge badge-success">Đã thu</span>
                      </c:when>
                      <c:when
                        test="${commission.status == 'CALCULATED' || commission.status == 'calculated'}"
                      >
                        <span class="badge badge-info">Đã tính</span>
                      </c:when>
                      <c:otherwise>
                        <span class="badge badge-secondary"
                          >${commission.status}</span
                        >
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
            </div>

            <hr />

            <div class="row">
              <div class="col-md-6">
                <div class="detail-group">
                  <label class="detail-label">Ngày tính toán</label>
                  <div class="detail-value">
                    <fmt:formatDate
                      value="${commission.calculationDateAsDate}"
                      pattern="dd/MM/yyyy"
                    />
                  </div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Ngày tạo</label>
                  <div class="detail-value">
                    <fmt:formatDate
                      value="${commission.createdAtAsDate}"
                      pattern="dd/MM/yyyy HH:mm:ss"
                    />
                  </div>
                </div>
              </div>

              <div class="col-md-6">
                <div class="detail-group">
                  <label class="detail-label">Cập nhật lần cuối</label>
                  <div class="detail-value">
                    <fmt:formatDate
                      value="${commission.updatedAtAsDate}"
                      pattern="dd/MM/yyyy HH:mm:ss"
                    />
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Actions Panel -->
      <div class="col-md-4">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">Thao tác</h4>

            <div class="action-buttons-vertical">
              <a
                href="/admin/commission"
                class="btn btn-outline-secondary btn-block"
              >
                <i class="mdi mdi-arrow-left"></i>
                Quay lại danh sách
              </a>

              <c:if
                test="${commission.status == 'PENDING' || commission.status == 'pending' || commission.status == 'CALCULATED' || commission.status == 'calculated'}"
              >
                <form
                  method="POST"
                  action="/admin/commission/${commission.id}/mark-collected"
                >
                  <button
                    type="submit"
                    class="btn btn-gradient-success btn-block"
                    onclick="return confirm('Xác nhận đã thu hoa hồng này?')"
                  >
                    <i class="mdi mdi-check-circle"></i>
                    Đánh dấu đã thu
                  </button>
                </form>
              </c:if>

              <button
                type="button"
                class="btn btn-gradient-info btn-block"
                onclick="window.print()"
              >
                <i class="mdi mdi-printer"></i>
                In báo cáo
              </button>

              <form
                method="POST"
                action="/admin/commission/${commission.id}/delete"
              >
                <button
                  type="submit"
                  class="btn btn-gradient-danger btn-block"
                  onclick="return confirm('Bạn có chắc chắn muốn xóa bản ghi hoa hồng này?')"
                >
                  <i class="mdi mdi-delete"></i>
                  Xóa bản ghi
                </button>
              </form>
            </div>
          </div>
        </div>

        <!-- Calculation Breakdown -->
        <div class="card mt-3">
          <div class="card-body">
            <h4 class="card-title">Chi tiết tính toán</h4>

            <div class="calculation-breakdown">
              <div class="calculation-row">
                <span class="calc-label">Tổng doanh thu cửa hàng:</span>
                <span class="calc-value">
                  <fmt:formatNumber
                    value="${commission.totalRevenue}"
                    type="currency"
                    currencySymbol="₫"
                    maxFractionDigits="0"
                  />
                </span>
              </div>

              <div class="calculation-row">
                <span class="calc-label">Tỷ lệ hoa hồng:</span>
                <span class="calc-value">
                  <fmt:formatNumber
                    value="${commission.commissionRate * 100}"
                    pattern="#0.##"
                  />%
                </span>
              </div>

              <hr class="calc-divider" />

              <div class="calculation-row total">
                <span class="calc-label">Hoa hồng nền tảng:</span>
                <span class="calc-value">
                  <fmt:formatNumber
                    value="${commission.commissionAmount}"
                    type="currency"
                    currencySymbol="₫"
                    maxFractionDigits="0"
                  />
                </span>
              </div>

              <div class="calculation-row">
                <span class="calc-label">Cửa hàng nhận:</span>
                <span class="calc-value">
                  <fmt:formatNumber
                    value="${commission.totalRevenue - commission.commissionAmount}"
                    type="currency"
                    currencySymbol="₫"
                    maxFractionDigits="0"
                  />
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Include Scripts -->
<script src="/admin/vendors/js/vendor.bundle.base.js"></script>
<script src="/admin/js/off-canvas.js"></script>
<script src="/admin/js/hoverable-collapse.js"></script>
<script src="/admin/js/template.js"></script>
<script src="/admin/js/todolist.js"></script>
