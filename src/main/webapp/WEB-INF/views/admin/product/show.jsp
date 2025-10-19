<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

      <!-- Include CSS Files -->
      <link rel="stylesheet" href="/admin/css/product-base.css" />
      <link rel="stylesheet" href="/admin/css/product-search.css" />
      <link rel="stylesheet" href="/admin/css/product-table.css" />

      <div class="main-panel">
        <div class="content-wrapper">
          <!-- Flash Messages -->
          <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
              <i class="typcn typcn-tick mr-2"></i>
              ${success}
              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
          </c:if>

          <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
              <i class="typcn typcn-warning mr-2"></i>
              ${error}
              <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
          </c:if>

          <!-- Search Card -->
          <div class="search-card">
            <h4 class="mb-3">
              <i class="typcn typcn-shopping-bag mr-2"></i>
              Quản lý sản phẩm theo cửa hàng
            </h4>

            <form method="GET" action="/admin/product" class="search-form">
              <div class="row align-items-end">
                <div class="col-md-6">
                  <label for="keyword" class="form-label">Tìm kiếm cửa hàng</label>
                  <input type="text" name="keyword" value="${keyword}" class="form-control"
                    placeholder="Tên cửa hàng, mô tả..." id="keyword" />
                </div>

                <div class="col-md-6">
                  <button type="submit" class="btn btn-light">
                    <i class="typcn typcn-zoom mr-1"></i> Tìm kiếm
                  </button>
                  <a href="/admin/product" class="btn btn-outline-light">
                    <i class="typcn typcn-refresh mr-1"></i> Làm mới
                  </a>
                </div>
              </div>
            </form>
          </div>

          <!-- Statistics -->
          <div class="stats-card">
            <div class="row">
              <div class="col-md-6">
                <h6 class="mb-1">Tổng số cửa hàng</h6>
                <h3 class="text-primary mb-0">${shops.size()}</h3>
              </div>
              <div class="col-md-6 text-md-right">
                <c:if test="${not empty keyword}">
                  <span class="badge badge-info">Kết quả tìm kiếm</span>
                </c:if>
              </div>
            </div>
          </div>

          <!-- Search Result Info -->
          <c:if test="${not empty keyword}">
            <div class="search-result-info">
              <i class="typcn typcn-info mr-1"></i>
              Tìm thấy ${shops.size()} cửa hàng với từ khóa
              "<strong>${keyword}</strong>"
            </div>
          </c:if>

          <!-- Shops Table -->
          <div class="table-container">
            <c:choose>
              <c:when test="${not empty shops}">
                <div class="table-responsive">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>ID</th>
                        <th>Tên cửa hàng</th>
                        <th>Mô tả</th>
                        <th>Chủ cửa hàng</th>
                        <th>Trạng thái</th>
                        <th>Số sản phẩm</th>
                        <th>Ngày tạo</th>
                        <th class="text-center">Hành động</th>
                      </tr>
                    </thead>
                    <tbody>
                      <c:forEach var="shop" items="${shops}" varStatus="status">
                        <tr>
                          <td><strong>#${shop.id}</strong></td>
                          <td>
                            <div class="font-weight-bold">${shop.shopName}</div>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${not empty shop.description}">
                                <span title="${shop.description}">
                                  ${shop.description.length() > 50 ?
                                  shop.description.substring(0, 50).concat('...') :
                                  shop.description}
                                </span>
                              </c:when>
                              <c:otherwise>
                                <span class="text-muted">Chưa có mô tả</span>
                              </c:otherwise>
                            </c:choose>
                          </td>
                          <td>
                            <div>
                              <div class="font-weight-bold">${shop.ownerName}</div>
                              <small class="text-muted">${shop.ownerEmail}</small>
                            </div>
                          </td>
                          <td>
                            <c:choose>
                              <c:when test="${shop.status == 'Active'}">
                                <span class="badge badge-success">Hoạt động</span>
                              </c:when>
                              <c:otherwise>
                                <span class="badge badge-secondary">${shop.status}</span>
                              </c:otherwise>
                            </c:choose>
                          </td>
                          <td>
                            <span class="badge badge-info">${shop.totalProducts} sản phẩm</span>
                          </td>
                          <td>
                            <c:set var="dateTime" value="${shop.createdAt}" />
                            <c:if test="${not empty dateTime}">
                              ${dateTime.dayOfMonth}/${dateTime.monthValue}/${dateTime.year}
                              ${dateTime.hour}:${dateTime.minute < 10 ? '0' : '' }${dateTime.minute} </c:if>
                          </td>
                          <td class="text-center">
                            <div class="action-buttons">
                              <a href="/admin/product/shop/${shop.id}" class="btn btn-sm btn-outline-primary"
                                title="Xem sản phẩm">
                                <i class="typcn typcn-shopping-bag"></i> Sản phẩm
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
                <div class="no-results">
                  <i class="typcn typcn-shopping-bag"></i>
                  <h5>Không tìm thấy cửa hàng nào</h5>
                  <p class="text-muted">
                    <c:choose>
                      <c:when test="${not empty keyword}">
                        Thử thay đổi từ khóa tìm kiếm.
                      </c:when>
                      <c:otherwise>
                        Chưa có cửa hàng nào trong hệ thống.
                      </c:otherwise>
                    </c:choose>
                  </p>
                  <a href="/admin/product" class="btn btn-outline-primary">
                    <i class="typcn typcn-refresh mr-1"></i> Làm mới
                  </a>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </div>
      </div>

      <!-- Include Base Scripts -->
      <script src="/admin/vendors/js/vendor.bundle.base.js"></script>
      <script src="/admin/js/off-canvas.js"></script>
      <script src="/admin/js/hoverable-collapse.js"></script>
      <script src="/admin/js/template.js"></script>
      <script src="/admin/js/todolist.js"></script>