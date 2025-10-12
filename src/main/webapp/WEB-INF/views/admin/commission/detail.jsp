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
        Commission Detail
      </h3>
      <nav aria-label="breadcrumb">
        <ul class="breadcrumb">
          <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
          <li class="breadcrumb-item">
            <a href="/admin/commission">Commissions</a>
          </li>
          <li class="breadcrumb-item active" aria-current="page">Detail</li>
        </ul>
      </nav>
    </div>

    <!-- Commission Detail -->
    <div class="row">
      <div class="col-md-8">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title">Commission Information</h4>

            <div class="row">
              <div class="col-md-6">
                <div class="detail-group">
                  <label class="detail-label">Commission ID</label>
                  <div class="detail-value">#${commission.id}</div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Shop Name</label>
                  <div class="detail-value">${commission.shopName}</div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Shop ID</label>
                  <div class="detail-value">${commission.shopId}</div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Calculation Period</label>
                  <div class="detail-value">
                    <fmt:formatDate
                      value="${commission.fromDate}"
                      pattern="dd/MM/yyyy"
                    />
                    -
                    <fmt:formatDate
                      value="${commission.toDate}"
                      pattern="dd/MM/yyyy"
                    />
                  </div>
                </div>
              </div>

              <div class="col-md-6">
                <div class="detail-group">
                  <label class="detail-label">Total Revenue</label>
                  <div class="detail-value revenue-value">
                    <fmt:formatNumber
                      value="${commission.totalRevenue}"
                      type="currency"
                      currencySymbol="$"
                    />
                  </div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Commission Rate</label>
                  <div class="detail-value">
                    <fmt:formatNumber
                      value="${commission.commissionRate}"
                      type="percent"
                    />
                  </div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Commission Amount</label>
                  <div class="detail-value commission-value">
                    <fmt:formatNumber
                      value="${commission.commissionAmount}"
                      type="currency"
                      currencySymbol="$"
                    />
                  </div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Status</label>
                  <div class="detail-value">
                    <c:choose>
                      <c:when test="${commission.status == 'PENDING'}">
                        <span class="badge badge-warning">Pending</span>
                      </c:when>
                      <c:when test="${commission.status == 'COLLECTED'}">
                        <span class="badge badge-success">Collected</span>
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
                  <label class="detail-label">Calculation Date</label>
                  <div class="detail-value">
                    <fmt:formatDate
                      value="${commission.calculationDate}"
                      pattern="dd/MM/yyyy"
                    />
                  </div>
                </div>

                <div class="detail-group">
                  <label class="detail-label">Created At</label>
                  <div class="detail-value">
                    <fmt:formatDate
                      value="${commission.createdAt}"
                      pattern="dd/MM/yyyy HH:mm:ss"
                    />
                  </div>
                </div>
              </div>

              <div class="col-md-6">
                <div class="detail-group">
                  <label class="detail-label">Last Updated</label>
                  <div class="detail-value">
                    <fmt:formatDate
                      value="${commission.updatedAt}"
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
            <h4 class="card-title">Actions</h4>

            <div class="action-buttons-vertical">
              <a
                href="/admin/commission"
                class="btn btn-outline-secondary btn-block"
              >
                <i class="mdi mdi-arrow-left"></i>
                Back to List
              </a>

              <c:if test="${commission.status == 'PENDING'}">
                <form
                  method="POST"
                  action="/admin/commission/${commission.id}/mark-collected"
                >
                  <button
                    type="submit"
                    class="btn btn-gradient-success btn-block"
                    onclick="return confirm('Mark this commission as collected?')"
                  >
                    <i class="mdi mdi-check-circle"></i>
                    Mark as Collected
                  </button>
                </form>
              </c:if>

              <button
                type="button"
                class="btn btn-gradient-info btn-block"
                onclick="window.print()"
              >
                <i class="mdi mdi-printer"></i>
                Print Report
              </button>

              <form
                method="POST"
                action="/admin/commission/${commission.id}/delete"
              >
                <button
                  type="submit"
                  class="btn btn-gradient-danger btn-block"
                  onclick="return confirm('Are you sure you want to delete this commission record?')"
                >
                  <i class="mdi mdi-delete"></i>
                  Delete Record
                </button>
              </form>
            </div>
          </div>
        </div>

        <!-- Calculation Breakdown -->
        <div class="card mt-3">
          <div class="card-body">
            <h4 class="card-title">Calculation Breakdown</h4>

            <div class="calculation-breakdown">
              <div class="calculation-row">
                <span class="calc-label">Total Shop Revenue:</span>
                <span class="calc-value">
                  <fmt:formatNumber
                    value="${commission.totalRevenue}"
                    type="currency"
                    currencySymbol="$"
                  />
                </span>
              </div>

              <div class="calculation-row">
                <span class="calc-label">Commission Rate:</span>
                <span class="calc-value">
                  <fmt:formatNumber
                    value="${commission.commissionRate}"
                    type="percent"
                  />
                </span>
              </div>

              <hr class="calc-divider" />

              <div class="calculation-row total">
                <span class="calc-label">Platform Commission:</span>
                <span class="calc-value">
                  <fmt:formatNumber
                    value="${commission.commissionAmount}"
                    type="currency"
                    currencySymbol="$"
                  />
                </span>
              </div>

              <div class="calculation-row">
                <span class="calc-label">Shop Keeps:</span>
                <span class="calc-value">
                  <fmt:formatNumber
                    value="${commission.totalRevenue - commission.commissionAmount}"
                    type="currency"
                    currencySymbol="$"
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
