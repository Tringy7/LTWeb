<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/commission-base.css" />
<link rel="stylesheet" href="/admin/css/commission-table.css" />

<div class="main-panel">
  <div class="content-wrapper">
    <!-- Page Header -->
    <div class="page-header">
      <h3 class="page-title">
        <i class="mdi mdi-store"></i>
        Chi tiết Hoa hồng Cửa hàng
      </h3>
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
          <li class="breadcrumb-item">
            <a href="/admin/commission">Hoa hồng</a>
          </li>
          <li class="breadcrumb-item active" aria-current="page">
            Chi tiết cửa hàng #${shopId}
          </li>
        </ol>
      </nav>
    </div>

    <!-- Back Button -->
    <div class="mb-3">
      <a href="/admin/commission" class="btn btn-secondary">
        <i class="mdi mdi-arrow-left"></i>
        Quay lại danh sách
      </a>
    </div>

    <!-- Shop Commission Details -->
    <div class="card">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h5 class="card-title mb-0">
            <i class="mdi mdi-cash-multiple"></i>
            Lịch sử Hoa hồng - Cửa hàng #${shopId}
          </h5>
          <div class="result-info">
            <c:choose>
              <c:when test="${not empty commissions}">
                <span class="badge badge-primary"
                  >${commissions.size()} kết quả</span
                >
              </c:when>
              <c:otherwise>
                <span class="badge badge-secondary">Không có dữ liệu</span>
              </c:otherwise>
            </c:choose>
          </div>
        </div>

        <c:choose>
          <c:when test="${not empty commissions}">
            <!-- Summary Statistics -->
            <div class="row mb-4">
              <div class="col-md-3">
                <div class="card bg-primary text-white">
                  <div class="card-body text-center">
                    <h4 class="mb-1">
                      <c:set var="totalCommission" value="0" />
                      <c:forEach var="commission" items="${commissions}">
                        <c:set
                          var="totalCommission"
                          value="${totalCommission + commission.commissionAmount}"
                        />
                      </c:forEach>
                      <fmt:formatNumber
                        value="${totalCommission}"
                        type="currency"
                        currencySymbol="₫"
                        maxFractionDigits="0"
                      />
                    </h4>
                    <small>Tổng hoa hồng</small>
                  </div>
                </div>
              </div>
              <div class="col-md-3">
                <div class="card bg-success text-white">
                  <div class="card-body text-center">
                    <h4 class="mb-1">
                      <c:set var="totalRevenue" value="0" />
                      <c:forEach var="commission" items="${commissions}">
                        <c:set
                          var="totalRevenue"
                          value="${totalRevenue + commission.totalRevenue}"
                        />
                      </c:forEach>
                      <fmt:formatNumber
                        value="${totalRevenue}"
                        type="currency"
                        currencySymbol="₫"
                        maxFractionDigits="0"
                      />
                    </h4>
                    <small>Tổng doanh thu</small>
                  </div>
                </div>
              </div>
              <div class="col-md-3">
                <div class="card bg-info text-white">
                  <div class="card-body text-center">
                    <h4 class="mb-1">${commissions.size()}</h4>
                    <small>Số kỳ tính hoa hồng</small>
                  </div>
                </div>
              </div>
              <div class="col-md-3">
                <div class="card bg-warning text-white">
                  <div class="card-body text-center">
                    <h4 class="mb-1">
                      <c:set var="pendingCount" value="0" />
                      <c:forEach var="commission" items="${commissions}">
                        <c:if
                          test="${commission.status == 'PENDING' || commission.status == 'pending'}"
                        >
                          <c:set
                            var="pendingCount"
                            value="${pendingCount + 1}"
                          />
                        </c:if>
                      </c:forEach>
                      ${pendingCount}
                    </h4>
                    <small>Chưa thu</small>
                  </div>
                </div>
              </div>
            </div>

            <!-- Commission History Table -->
            <div class="table-responsive">
              <table class="table table-striped table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Cửa hàng</th>
                    <th>Khoảng thời gian</th>
                    <th>Doanh thu</th>
                    <th>Tỷ lệ (%)</th>
                    <th>Hoa hồng</th>
                    <th>Ngày tính</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="commission" items="${commissions}">
                    <tr>
                      <td>#${commission.id}</td>
                      <td>
                        <div class="shop-info">
                          <strong>${commission.shopName}</strong>
                          <small class="text-muted"
                            >ID: ${commission.shopId}</small
                          >
                        </div>
                      </td>
                      <td>
                        <div class="date-range">
                          <small>
                            <fmt:formatDate
                              value="${commission.fromDateAsDate}"
                              pattern="dd/MM"
                            />
                            -
                            <fmt:formatDate
                              value="${commission.toDateAsDate}"
                              pattern="dd/MM/yyyy"
                            />
                          </small>
                        </div>
                      </td>
                      <td>
                        <span class="revenue-amount">
                          <fmt:formatNumber
                            value="${commission.totalRevenue}"
                            type="currency"
                            currencySymbol="₫"
                            maxFractionDigits="0"
                          />
                        </span>
                      </td>
                      <td>
                        <span class="commission-rate">
                          <fmt:formatNumber
                            value="${commission.commissionRate * 100}"
                            pattern="#0.##"
                          />%
                        </span>
                      </td>
                      <td>
                        <span class="commission-amount">
                          <fmt:formatNumber
                            value="${commission.commissionAmount}"
                            type="currency"
                            currencySymbol="₫"
                            maxFractionDigits="0"
                          />
                        </span>
                      </td>
                      <td>
                        <fmt:formatDate
                          value="${commission.calculationDateAsDate}"
                          pattern="dd/MM/yyyy"
                        />
                      </td>
                      <td>
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
                          <c:otherwise>
                            <span class="badge badge-secondary"
                              >${commission.status}</span
                            >
                          </c:otherwise>
                        </c:choose>
                      </td>
                      <td>
                        <div class="action-buttons">
                          <c:if
                            test="${commission.status == 'PENDING' || commission.status == 'pending'}"
                          >
                            <form
                              method="POST"
                              action="/admin/commission/${commission.id}/mark-collected"
                              style="display: inline"
                              onsubmit="return confirm('Xác nhận đã thu hoa hồng từ cửa hàng ${commission.shopName}?')"
                            >
                              <button
                                type="submit"
                                class="btn btn-sm btn-success"
                                title="Đánh dấu đã thu"
                              >
                                <i class="mdi mdi-check"></i>
                              </button>
                            </form>
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
            <div class="empty-state">
              <div class="empty-icon">
                <i class="mdi mdi-store-outline"></i>
              </div>
              <h5>Chưa có dữ liệu hoa hồng</h5>
              <p class="text-muted">
                Cửa hàng này chưa có hoa hồng nào được tính toán.
              </p>
              <a href="/admin/commission" class="btn btn-primary">
                <i class="mdi mdi-arrow-left"></i>
                Quay lại danh sách
              </a>
            </div>
          </c:otherwise>
        </c:choose>
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
