<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
  .vendor-details {
    padding: 20px 40px;
    max-width: 95%;
    margin: 0 auto;
  }

  .page-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 30px;
    border-radius: 15px;
    margin-bottom: 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 20px;
  }

  .page-title {
    font-size: 1.8rem;
    margin: 0;
    font-weight: 600;
  }

  .nav-buttons {
    display: flex;
    gap: 10px;
    flex-wrap: wrap;
  }

  .nav-btn {
    background: rgba(255, 255, 255, 0.1);
    color: white;
    padding: 10px 20px;
    border-radius: 25px;
    text-decoration: none;
    font-weight: 500;
    transition: all 0.2s ease;
    border: 1px solid rgba(255, 255, 255, 0.2);
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .nav-btn:hover {
    background: rgba(255, 255, 255, 0.2);
    color: white;
    text-decoration: none;
  }

  .alert {
    padding: 15px;
    margin-bottom: 20px;
    border: 1px solid transparent;
    border-radius: 10px;
    position: relative;
  }

  .alert-danger {
    background: linear-gradient(45deg, #f8d7da, #fff5f5);
    border-color: #f5c6cb;
    color: #721c24;
  }

  .close {
    position: absolute;
    right: 15px;
    top: 15px;
    background: none;
    border: none;
    font-size: 1.2rem;
    cursor: pointer;
    color: inherit;
  }

  .info-cards-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(450px, 1fr));
    gap: 30px;
    margin-bottom: 30px;
  }

  .info-card {
    background: white;
    border-radius: 15px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    overflow: hidden;
  }

  .info-card-header {
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    padding: 20px;
    font-size: 1.1rem;
    font-weight: 600;
    color: #333;
    border-bottom: 1px solid #eee;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .info-card-body {
    padding: 20px;
  }

  .info-table {
    width: 100%;
    border-collapse: collapse;
  }

  .info-table td {
    padding: 12px 0;
    border-bottom: 1px solid #f1f1f1;
    vertical-align: top;
  }

  .info-table td:first-child {
    font-weight: 500;
    color: #666;
    width: 40%;
    padding-right: 15px;
  }

  .info-table td:last-child {
    color: #333;
  }

  .info-table tr:last-child td {
    border-bottom: none;
  }

  .badge {
    padding: 4px 12px;
    border-radius: 15px;
    font-size: 0.8rem;
    font-weight: 500;
    text-transform: uppercase;
  }

  .status-badge-pending {
    background: #fff3cd;
    color: #856404;
    border: 1px solid #ffeaa7;
  }

  .status-badge-approved {
    background: #d4edda;
    color: #155724;
    border: 1px solid #c3e6cb;
  }

  .status-badge-rejected {
    background: #f8d7da;
    color: #721c24;
    border: 1px solid #f5c6cb;
  }

  .badge-info {
    background: #d1ecf1;
    color: #0c5460;
    border: 1px solid #bee5eb;
  }

  .business-type-badge {
    padding: 6px 15px;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 500;
    text-transform: capitalize;
  }

  .business-type-individual {
    background: linear-gradient(45deg, #e3f2fd, #bbdefb);
    color: #1565c0;
    border: 1px solid #90caf9;
  }

  .business-type-company {
    background: linear-gradient(45deg, #f3e5f5, #e1bee7);
    color: #7b1fa2;
    border: 1px solid #ce93d8;
  }

  .full-width-card {
    grid-column: 1 / -1;
  }

  .security-info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 40px;
  }

  .security-section-title {
    font-size: 1rem;
    font-weight: 600;
    color: #495057;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .action-required-card {
    background: linear-gradient(135deg, #fff8e1 0%, #ffecb3 100%);
    border: 2px solid #ffcc02;
    border-radius: 15px;
    overflow: hidden;
    margin-top: 20px;
  }

  .action-required-header {
    background: linear-gradient(135deg, #ff9800 0%, #f57c00 100%);
    color: white;
    padding: 15px 20px;
  }

  .action-buttons-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    gap: 30px;
    margin-top: 20px;
  }

  .action-btn-large {
    background: white;
    border: 2px solid #ddd;
    border-radius: 12px;
    padding: 20px;
    text-align: center;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 10px;
  }

  .action-btn-large:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
  }

  .action-btn-approve-large {
    border-color: #28a745;
    color: #28a745;
  }

  .action-btn-approve-large:hover {
    background: #28a745;
    color: white;
  }

  .action-btn-reject-large {
    border-color: #dc3545;
    color: #dc3545;
  }

  .action-btn-reject-large:hover {
    background: #dc3545;
    color: white;
  }

  .action-btn-large i {
    font-size: 2rem;
    margin-bottom: 5px;
  }

  .action-btn-large span {
    font-weight: 600;
    font-size: 1.1rem;
  }

  .action-description {
    font-size: 0.9rem;
    opacity: 0.8;
    line-height: 1.4;
    margin-top: 5px;
  }

  .modal {
    display: none;
    position: fixed;
    z-index: 1000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
  }

  .modal.show {
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .modal-dialog {
    background: white;
    border-radius: 10px;
    max-width: 600px;
    width: 90%;
    max-height: 90vh;
    overflow-y: auto;
  }

  .modal-header {
    padding: 20px;
    border-bottom: 1px solid #eee;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .modal-header.bg-success {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    color: white;
  }

  .modal-header.bg-danger {
    background: linear-gradient(135deg, #dc3545 0%, #e83e8c 100%);
    color: white;
  }

  .modal-title {
    margin: 0;
    font-size: 1.2rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .modal-body {
    padding: 20px;
  }

  .modal-footer {
    padding: 20px;
    border-top: 1px solid #eee;
    display: flex;
    gap: 10px;
    justify-content: flex-end;
  }

  .btn {
    padding: 8px 16px;
    border-radius: 6px;
    text-decoration: none;
    font-size: 0.9rem;
    border: none;
    cursor: pointer;
    transition: all 0.2s ease;
    display: inline-flex;
    align-items: center;
    gap: 5px;
  }

  .btn-success {
    background: #28a745;
    color: white;
  }

  .btn-success:hover {
    background: #218838;
  }

  .btn-danger {
    background: #dc3545;
    color: white;
  }

  .btn-danger:hover {
    background: #c82333;
  }

  .btn-secondary {
    background: #6c757d;
    color: white;
  }

  .btn-secondary:hover {
    background: #545b62;
  }

  .confirmation-info {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 8px;
    margin: 15px 0;
    font-size: 0.9rem;
  }

  .confirmation-actions-list h6 {
    color: #495057;
    font-weight: 600;
    margin-bottom: 10px;
  }

  .confirmation-actions-list ul {
    margin: 0;
    padding-left: 20px;
  }

  .confirmation-actions-list li {
    margin-bottom: 5px;
    line-height: 1.4;
  }

  .form-group {
    margin-bottom: 15px;
  }

  .form-group label {
    display: block;
    margin-bottom: 5px;
    font-weight: 500;
    color: #333;
  }

  .form-control {
    width: 100%;
    padding: 8px 12px;
    border: 1px solid #ddd;
    border-radius: 5px;
    font-size: 0.9rem;
    box-sizing: border-box;
    font-family: inherit;
  }

  .form-control:focus {
    outline: none;
    border-color: #007bff;
    box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.25);
  }

  .text-muted {
    color: #6c757d;
    font-size: 0.85rem;
  }

  code {
    background: #f8f9fa;
    color: #e83e8c;
    padding: 2px 6px;
    border-radius: 3px;
    font-size: 0.9em;
  }

  a {
    color: #007bff;
    text-decoration: none;
  }

  a:hover {
    color: #0056b3;
    text-decoration: underline;
  }

  @media (max-width: 768px) {
    .vendor-details {
      padding: 15px 20px;
    }

    .page-header {
      flex-direction: column;
      align-items: flex-start;
      padding: 20px;
    }

    .nav-buttons {
      width: 100%;
      justify-content: center;
    }

    .info-cards-grid {
      grid-template-columns: 1fr;
    }

    .security-info-grid {
      grid-template-columns: 1fr;
      gap: 20px;
    }

    .action-buttons-grid {
      grid-template-columns: 1fr;
    }

    .modal-dialog {
      margin: 10px;
      width: calc(100% - 20px);
    }
  }

  @media (min-width: 1400px) {
    .vendor-details {
      padding: 20px 60px;
    }

    .info-cards-grid {
      grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
    }
  }
</style>

<div class="vendor-details">
  <!-- Page Header -->
  <div class="page-header">
    <h1 class="page-title">
      <i class="fas fa-store"></i> Vendor Application Details
    </h1>
    <div class="nav-buttons">
      <a href="/admin/vendor-approval" class="nav-btn">
        <i class="fas fa-arrow-left"></i> Dashboard
      </a>
      <c:choose>
        <c:when test="${shop.securityInfo.verificationStatus == 'Pending'}">
          <a href="/admin/vendor-approval/pending" class="nav-btn">
            <i class="fas fa-list"></i> Back to Pending
          </a>
        </c:when>
        <c:when test="${shop.securityInfo.verificationStatus == 'Approved'}">
          <a href="/admin/vendor-approval/approved" class="nav-btn">
            <i class="fas fa-list"></i> Back to Approved
          </a>
        </c:when>
        <c:when test="${shop.securityInfo.verificationStatus == 'Rejected'}">
          <a href="/admin/vendor-approval/rejected" class="nav-btn">
            <i class="fas fa-list"></i> Back to Rejected
          </a>
        </c:when>
      </c:choose>
    </div>
  </div>

  <!-- Alert Messages -->
  <c:if test="${not empty error}">
    <div class="alert alert-danger" role="alert">
      ${error}
      <button
        type="button"
        class="close"
        onclick="this.parentElement.style.display='none'"
      >
        <span>&times;</span>
      </button>
    </div>
  </c:if>

  <!-- Information Cards -->
  <div class="info-cards-grid">
    <!-- Shop Information Card -->
    <div class="info-card">
      <div class="info-card-header">
        <i class="fas fa-store"></i> Shop Information
      </div>
      <div class="info-card-body">
        <table class="info-table">
          <tr>
            <td>Shop Name:</td>
            <td><strong>${shop.shopName}</strong></td>
          </tr>
          <tr>
            <td>Description:</td>
            <td>
              ${not empty shop.description ? shop.description : 'No description
              provided'}
            </td>
          </tr>
          <tr>
            <td>Status:</td>
            <td>
              <c:choose>
                <c:when
                  test="${shop.securityInfo.verificationStatus == 'Pending'}"
                >
                  <span class="badge status-badge-pending">Pending Review</span>
                </c:when>
                <c:when
                  test="${shop.securityInfo.verificationStatus == 'Approved'}"
                >
                  <span class="badge status-badge-approved">Approved</span>
                </c:when>
                <c:when
                  test="${shop.securityInfo.verificationStatus == 'Rejected'}"
                >
                  <span class="badge status-badge-rejected">Rejected</span>
                </c:when>
              </c:choose>
            </td>
          </tr>
          <tr>
            <td>Application Date:</td>
            <td>
              <c:set var="dateTime" value="${shop.createdAt}" />
              <c:if test="${not empty dateTime}">
                <div>
                  ${dateTime.dayOfMonth}/${dateTime.monthValue}/${dateTime.year}
                </div>
                <div class="text-muted">
                  ${dateTime.hour}:${dateTime.minute < 10 ? '0' :
                  ''}${dateTime.minute}
                </div>
              </c:if>
            </td>
          </tr>
        </table>
      </div>
    </div>

    <!-- Owner Information Card -->
    <div class="info-card">
      <div class="info-card-header">
        <i class="fas fa-user"></i> Owner Information
      </div>
      <div class="info-card-body">
        <table class="info-table">
          <tr>
            <td>Full Name:</td>
            <td><strong>${shop.user.fullName}</strong></td>
          </tr>
          <tr>
            <td>Email:</td>
            <td>
              <a href="mailto:${shop.user.email}">${shop.user.email}</a>
            </td>
          </tr>
          <tr>
            <td>Phone:</td>
            <td>
              <c:choose>
                <c:when test="${not empty shop.user.phone}">
                  <a href="tel:${shop.user.phone}">${shop.user.phone}</a>
                </c:when>
                <c:otherwise>Not provided</c:otherwise>
              </c:choose>
            </td>
          </tr>
          <tr>
            <td>Address:</td>
            <td>
              ${not empty shop.user.address ? shop.user.address : 'Not
              provided'}
            </td>
          </tr>
          <tr>
            <td>Current Role:</td>
            <td>
              <span
                class="badge ${shop.user.role.name == 'ROLE_VENDOR' ? 'status-badge-approved' : 'badge-info'}"
              >
                ${shop.user.role.name}
              </span>
            </td>
          </tr>
        </table>
      </div>
    </div>
  </div>

  <!-- Business & Security Information -->
  <div class="info-card full-width-card">
    <div class="info-card-header">
      <i class="fas fa-shield-alt"></i> Business & Security Information
    </div>
    <div class="info-card-body">
      <div class="security-info-grid">
        <!-- Business Information -->
        <div class="security-section">
          <h6 class="security-section-title">
            <i class="fas fa-building"></i> Business Details
          </h6>
          <table class="info-table">
            <tr>
              <td>Business Type:</td>
              <td>
                <c:choose>
                  <c:when
                    test="${shop.securityInfo.businessType == 'individual'}"
                  >
                    <span class="business-type-badge business-type-individual"
                      >Individual Business</span
                    >
                  </c:when>
                  <c:when test="${shop.securityInfo.businessType == 'company'}">
                    <span class="business-type-badge business-type-company"
                      >Company</span
                    >
                  </c:when>
                  <c:otherwise>
                    <span class="business-type-badge"
                      >${shop.securityInfo.businessType}</span
                    >
                  </c:otherwise>
                </c:choose>
              </td>
            </tr>
            <tr>
              <td>Tax Code:</td>
              <td>
                ${not empty shop.securityInfo.taxCode ?
                shop.securityInfo.taxCode : 'Not provided'}
              </td>
            </tr>
            <tr>
              <td>Verification Status:</td>
              <td>
                <c:choose>
                  <c:when
                    test="${shop.securityInfo.verificationStatus == 'Pending'}"
                  >
                    <span class="badge status-badge-pending"
                      >Pending Review</span
                    >
                  </c:when>
                  <c:when
                    test="${shop.securityInfo.verificationStatus == 'Approved'}"
                  >
                    <span class="badge status-badge-approved">Approved</span>
                  </c:when>
                  <c:when
                    test="${shop.securityInfo.verificationStatus == 'Rejected'}"
                  >
                    <span class="badge status-badge-rejected">Rejected</span>
                  </c:when>
                </c:choose>
              </td>
            </tr>
            <tr>
              <td>Security Info Created:</td>
              <td>
                <c:set var="dateTime" value="${shop.securityInfo.createdAt}" />
                <c:if test="${not empty dateTime}">
                  <div>
                    ${dateTime.dayOfMonth}/${dateTime.monthValue}/${dateTime.year}
                  </div>
                  <div class="text-muted">
                    ${dateTime.hour}:${dateTime.minute < 10 ? '0' :
                    ''}${dateTime.minute}
                  </div>
                </c:if>
              </td>
            </tr>
          </table>
        </div>

        <!-- Banking Information -->
        <div class="security-section">
          <h6 class="security-section-title">
            <i class="fas fa-university"></i> Banking Information
          </h6>
          <table class="info-table">
            <tr>
              <td>Bank Name:</td>
              <td>
                ${not empty shop.securityInfo.bankName ?
                shop.securityInfo.bankName : 'Not provided'}
              </td>
            </tr>
            <tr>
              <td>Bank Branch:</td>
              <td>
                ${not empty shop.securityInfo.bankBranch ?
                shop.securityInfo.bankBranch : 'Not provided'}
              </td>
            </tr>
            <tr>
              <td>Account Number:</td>
              <td>
                <c:choose>
                  <c:when test="${not empty shop.securityInfo.bankAccount}">
                    <code>${shop.securityInfo.bankAccount}</code>
                  </c:when>
                  <c:otherwise>Not provided</c:otherwise>
                </c:choose>
              </td>
            </tr>
            <tr>
              <td>Account Name:</td>
              <td>
                ${not empty shop.securityInfo.bankAccountName ?
                shop.securityInfo.bankAccountName : 'Not provided'}
              </td>
            </tr>
          </table>
        </div>
      </div>
    </div>
  </div>

  <!-- Action Buttons for Pending Applications -->
  <c:if test="${shop.securityInfo.verificationStatus == 'Pending'}">
    <div class="action-required-card">
      <div class="action-required-header">
        <h6><i class="fas fa-exclamation-triangle"></i> Action Required</h6>
      </div>
      <div class="info-card-body">
        <p>
          This vendor application is pending review. Please review all the
          information above and take appropriate action.
        </p>
        <div class="action-buttons-grid">
          <button
            type="button"
            class="action-btn-large action-btn-approve-large"
            onclick="approveVendor('${shop.id}')"
          >
            <i class="fas fa-check-circle"></i>
            <span>Approve Vendor</span>
            <div class="action-description">
              This will change the user role to ROLE_VENDOR and activate the
              shop.
            </div>
          </button>
          <button
            type="button"
            class="action-btn-large action-btn-reject-large"
            onclick="rejectVendor('${shop.id}')"
          >
            <i class="fas fa-times-circle"></i>
            <span>Reject Application</span>
            <div class="action-description">
              This will mark the application as rejected and keep the user as
              ROLE_USER.
            </div>
          </button>
        </div>
      </div>
    </div>
  </c:if>
</div>

<!-- Approve Confirmation Modal -->
<div class="modal" id="approveModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-success">
        <h5 class="modal-title">
          <i class="fas fa-check-circle"></i> Approve Vendor Application
        </h5>
        <button
          type="button"
          class="close"
          onclick="closeModal('approveModal')"
          style="color: white"
        >
          <span>&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <h6>Confirmation</h6>
        <p>Are you sure you want to approve this vendor application?</p>

        <div class="confirmation-actions-list">
          <h6><i class="fas fa-info-circle"></i> What will happen:</h6>
          <ul>
            <li>
              User role will be changed from <code>ROLE_USER</code> to
              <code>ROLE_VENDOR</code>
            </li>
            <li>Shop security status will be set to <code>Approved</code></li>
            <li>The vendor will be able to manage their shop and products</li>
            <li>The shop will appear in the approved vendors list</li>
          </ul>
        </div>

        <div class="confirmation-info">
          <strong>Shop:</strong>
          <span id="approveShopName">${shop.shopName}</span><br />
          <strong>Owner:</strong> ${shop.user.fullName}<br />
          <strong>Email:</strong> ${shop.user.email}
        </div>
      </div>
      <div class="modal-footer">
        <button
          type="button"
          class="btn btn-secondary"
          onclick="closeModal('approveModal')"
        >
          <i class="fas fa-times"></i> Cancel
        </button>
        <form id="approveForm" method="post" style="display: inline">
          <button type="submit" class="btn btn-success">
            <i class="fas fa-check-circle"></i> Confirm Approval
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<!-- Reject Confirmation Modal -->
<div class="modal" id="rejectModal" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h5 class="modal-title">
          <i class="fas fa-times-circle"></i> Reject Vendor Application
        </h5>
        <button
          type="button"
          class="close"
          onclick="closeModal('rejectModal')"
          style="color: white"
        >
          <span>&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <h6>Confirmation</h6>
        <p>Are you sure you want to reject this vendor application?</p>

        <div class="confirmation-actions-list">
          <h6><i class="fas fa-exclamation-triangle"></i> What will happen:</h6>
          <ul>
            <li>Shop security status will be set to <code>Rejected</code></li>
            <li>User will remain as <code>ROLE_USER</code></li>
            <li>The application will appear in the rejected list</li>
            <li>The vendor cannot manage shop or products</li>
          </ul>
        </div>

        <div class="confirmation-info">
          <strong>Shop:</strong>
          <span id="rejectShopName">${shop.shopName}</span><br />
          <strong>Owner:</strong> ${shop.user.fullName}<br />
          <strong>Email:</strong> ${shop.user.email}
        </div>

        <div class="form-group">
          <label for="rejectionReason"
            ><strong>Rejection Reason:</strong></label
          >
          <textarea
            class="form-control"
            id="rejectionReason"
            name="rejectionReason"
            rows="4"
            placeholder="Please provide a detailed reason for rejection..."
            required
          >
Application does not meet our vendor requirements. Please ensure all required information is provided and business documentation is complete.</textarea
          >
          <div class="text-muted">
            This reason will be logged for record keeping.
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button
          type="button"
          class="btn btn-secondary"
          onclick="closeModal('rejectModal')"
        >
          <i class="fas fa-arrow-left"></i> Cancel
        </button>
        <form id="rejectForm" method="post" style="display: inline">
          <input
            type="hidden"
            name="rejectionReason"
            id="rejectionReasonInput"
          />
          <button
            type="submit"
            class="btn btn-danger"
            onclick="updateRejectionReason()"
          >
            <i class="fas fa-times-circle"></i> Confirm Rejection
          </button>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
  // Modal helper functions
  function showModal(modalId) {
    document.getElementById(modalId).classList.add("show");
  }

  function closeModal(modalId) {
    document.getElementById(modalId).classList.remove("show");
  }

  // Approve vendor
  function approveVendor(shopId) {
    const shopName = "${shop.shopName}";
    document.getElementById("approveShopName").textContent = shopName;
    document.getElementById("approveForm").action =
      "/admin/vendor-approval/approve/" + shopId;
    showModal("approveModal");
  }

  // Reject vendor
  function rejectVendor(shopId) {
    const shopName = "${shop.shopName}";
    document.getElementById("rejectShopName").textContent = shopName;
    document.getElementById("rejectForm").action =
      "/admin/vendor-approval/reject/" + shopId;
    showModal("rejectModal");
  }

  // Update rejection reason when modal is submitted
  function updateRejectionReason() {
    const reason = document.getElementById("rejectionReason").value;
    if (!reason.trim()) {
      alert("Please provide a rejection reason.");
      return false;
    }
    document.getElementById("rejectionReasonInput").value = reason;
  }

  // Close modal when clicking outside
  window.onclick = function (event) {
    if (event.target.classList.contains("modal")) {
      event.target.classList.remove("show");
    }
  };
</script>
