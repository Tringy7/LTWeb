<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/commission-base.css" />
<link rel="stylesheet" href="/admin/css/commission-table.css" />

<div class="main-panel">
  <div class="content-wrapper">
    <!-- Page Header -->
    <div class="page-header">
      <h3 class="page-title">Quản lý Hoa hồng</h3>
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
          <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
          <li class="breadcrumb-item active" aria-current="page">Hoa hồng</li>
        </ol>
      </nav>
    </div>

    <!-- Flash Messages -->
    <c:if test="${not empty successMessage}">
      <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="mdi mdi-check-circle-outline"></i> ${successMessage}
        <button type="button" class="close" data-dismiss="alert">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
      <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <i class="mdi mdi-alert-circle-outline"></i> ${errorMessage}
        <button type="button" class="close" data-dismiss="alert">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    </c:if>

    <c:if test="${not empty warningMessage}">
      <div class="alert alert-warning alert-dismissible fade show" role="alert">
        <i class="mdi mdi-alert-outline"></i> ${warningMessage}
        <button type="button" class="close" data-dismiss="alert">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    </c:if>

    <!-- Action Cards -->
    <div class="row mb-4">
      <div class="col-lg-4 col-md-6">
        <div class="card calculation-card">
          <div class="card-body">
            <h5 class="card-title">
              <i class="mdi mdi-calculator"></i>
              Tính toán Hoa hồng
            </h5>
            <div class="d-grid gap-2">
              <form
                method="POST"
                action="/admin/commission/calculate-this-month"
              >
                <button type="submit" class="btn btn-primary btn-block">
                  <i class="mdi mdi-calendar-month"></i>
                  Tính hoa hồng tháng này
                </button>
              </form>
              <form
                method="POST"
                action="/admin/commission/calculate-up-to-now"
              >
                <button type="submit" class="btn btn-success btn-block">
                  <i class="mdi mdi-calendar-today"></i>
                  Tính hoa hồng đến hiện tại
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>

      <div class="col-lg-8 col-md-6">
        <div class="card search-card">
          <div class="card-body">
            <h5 class="card-title">
              <i class="mdi mdi-magnify"></i>
              Tính toán theo khoảng thời gian
            </h5>
            <form:form
              method="POST"
              action="/admin/commission/calculate"
              modelAttribute="calculationRequest"
            >
              <div class="row">
                <div class="col-md-4">
                  <form:input
                    path="fromDate"
                    type="date"
                    cssClass="form-control"
                    placeholder="Từ ngày"
                  />
                </div>
                <div class="col-md-4">
                  <form:input
                    path="toDate"
                    type="date"
                    cssClass="form-control"
                    placeholder="Đến ngày"
                  />
                </div>
                <div class="col-md-4">
                  <button type="submit" class="btn btn-warning btn-block">
                    <i class="mdi mdi-calculator-variant"></i>
                    Tính toán
                  </button>
                </div>
              </div>
            </form:form>
          </div>
        </div>
      </div>
    </div>

    <!-- Search Filter -->
    <div class="card search-filter-card mb-4">
      <div class="card-body">
        <h6 class="card-title">
          <i class="mdi mdi-filter"></i>
          Lọc theo thời gian
        </h6>
        <form method="GET" action="/admin/commission/search">
          <div class="row">
            <div class="col-md-4">
              <input
                type="date"
                name="fromDate"
                value="${fromDate}"
                class="form-control"
                required
              />
            </div>
            <div class="col-md-4">
              <input
                type="date"
                name="toDate"
                value="${toDate}"
                class="form-control"
                required
              />
            </div>
            <div class="col-md-4">
              <button type="submit" class="btn btn-info btn-block">
                <i class="mdi mdi-magnify"></i>
                Tìm kiếm
              </button>
            </div>
          </div>
        </form>
      </div>
    </div>

    <!-- Summary Card -->
    <c:if test="${not empty summary}">
      <div class="card summary-card mb-4">
        <div class="card-body">
          <h5 class="card-title">
            <i class="mdi mdi-chart-line"></i>
            Tổng quan Hoa hồng
          </h5>
          <div class="row">
            <div class="col-md-3">
              <div class="stat-item">
                <div class="stat-label">Tổng doanh thu</div>
                <div class="stat-value text-primary">
                  <fmt:formatNumber
                    value="${summary.totalRevenue}"
                    type="currency"
                    currencySymbol="₫"
                  />
                </div>
              </div>
            </div>
            <div class="col-md-3">
              <div class="stat-item">
                <div class="stat-label">Tổng hoa hồng</div>
                <div class="stat-value text-success">
                  <fmt:formatNumber
                    value="${summary.totalCommissionAmount}"
                    type="currency"
                    currencySymbol="₫"
                  />
                </div>
              </div>
            </div>
            <div class="col-md-3">
              <div class="stat-item">
                <div class="stat-label">Số cửa hàng</div>
                <div class="stat-value text-info">${summary.totalShops}</div>
              </div>
            </div>
            <div class="col-md-3">
              <div class="stat-item">
                <div class="stat-label">Hoa hồng TB/Cửa hàng</div>
                <div class="stat-value text-warning">
                  <fmt:formatNumber
                    value="${summary.averageCommissionPerShop}"
                    type="currency"
                    currencySymbol="₫"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </c:if>

    <!-- Commissions Table -->
    <div class="card">
      <div class="card-body">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h5 class="card-title mb-0">
            <i class="mdi mdi-view-list"></i>
            Danh sách Hoa hồng
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
            <div class="table-responsive">
              <table class="table table-striped table-hover">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Cửa hàng</th>
                    <th>Doanh thu</th>
                    <th>Tỷ lệ (%)</th>
                    <th>Hoa hồng</th>
                    <th>Ngày tính</th>
                    <th>Khoảng thời gian</th>
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
                        <span class="revenue-amount">
                          <fmt:formatNumber
                            value="${commission.totalRevenue}"
                            type="currency"
                            currencySymbol="₫"
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
                        <c:choose>
                          <c:when test="${commission.status == 'PENDING'}">
                            <span class="badge badge-warning">Chờ thu</span>
                          </c:when>
                          <c:when test="${commission.status == 'COLLECTED'}">
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
                          <c:if test="${commission.status == 'PENDING'}">
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
                          <a
                            href="/admin/commission/shop/${commission.shopId}"
                            class="btn btn-sm btn-info"
                            title="Xem chi tiết cửa hàng"
                          >
                            <i class="mdi mdi-eye"></i>
                          </a>
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
                <i class="mdi mdi-cash-multiple"></i>
              </div>
              <h5>Chưa có dữ liệu hoa hồng</h5>
              <p class="text-muted">
                Hãy tính toán hoa hồng để xem kết quả tại đây.
              </p>
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

<script>
  // Auto-dismiss alerts after 5 seconds
  setTimeout(function () {
    $(".alert").fadeOut();
  }, 5000);
</script>
