<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <head>
                <link rel="shortcut icon" href="../../images/favicon.png" />
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
            </head>

            <style>
                .profile-container {
                    width: 90%;
                    margin: 10px auto;
                    border-radius: 20px;
                    background: #fff;
                    box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                }

                .profile-container:hover {

                    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
                }

                .profile-header {
                    background: linear-gradient(135deg, #007bff, #00c6ff);
                    color: white;
                    text-align: center;
                    padding: 40px 0;
                }

                .profile-header img {
                    width: 130px;
                    height: 130px;
                    border-radius: 50%;
                    border: 4px solid white;
                    object-fit: cover;
                }

                .profile-header h3 {
                    margin-top: 15px;
                    font-weight: 700;
                }

                .profile-header p {
                    font-size: 15px;
                    opacity: 0.9;
                }

                .profile-content {
                    display: flex;
                    flex-wrap: wrap;
                    padding: 40px;
                    gap: 40px;
                    justify-content: space-between;
                    align-items: flex-start;
                }

                .profile-info-box {
                    flex: 1;
                    min-width: 300px;
                }

                .profile-info {
                    margin-bottom: 18px;
                    display: flex;
                    justify-content: space-between;
                    border-bottom: 1px dashed #dee2e6;
                    padding-bottom: 8px;
                }

                .profile-info label {
                    font-weight: 600;
                    color: #333;
                }

                .profile-info span {
                    color: #555;
                }

                .status-active {
                    color: #28a745;
                    font-weight: bold;
                }

                .status-inactive {
                    color: #dc3545;
                    font-weight: bold;
                }

                .edit-section {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    flex-direction: column;
                    gap: 20px;
                }

                .edit-btn {
                    border-radius: 30px;
                    padding: 10px 25px;
                    font-weight: 600;
                    transition: all 0.3s ease;
                }

                .edit-btn:hover {
                    transform: scale(1.05);
                }

                .info-card {
                    background-color: #f8f9fa;
                    padding: 25px;
                    border-radius: 15px;
                    box-shadow: inset 0 0 8px rgba(0, 0, 0, 0.05);
                }

                .edit-section.info-card {
                    padding: 15px;
                }

                .edit-section.info-card h5 {
                    margin-bottom: 1px;
                }

                .edit-section.info-card p {
                    margin-bottom: 1px;
                    line-height: 1.3;
                }

                .edit-section.info-card .btn.edit-btn {
                    margin-top: 1px;
                }
            </style>

            <div class="main-panel">
                <div class="content-wrapper">
                    <div class="profile-container">
                        <!-- Header chỉ chứa avatar và tên -->
                        <div class="profile-header text-center mb-1">
                            <c:choose>
                                <c:when test="${not empty shipper.user.image}">
                                    <img src="/admin/images/user/${shipper.user.image}" alt="Avatar"
                                        class="rounded-circle"
                                        style="width: 120px; height: 120px; object-fit: cover; margin: 0;" />
                                </c:when>
                                <c:otherwise>
                                    <img src="/admin/images/user/user-avatar.jpg" alt="Avatar" class="rounded-circle"
                                        style="width: 120px; height: 120px; object-fit: cover; margin: 0;" />
                                </c:otherwise>
                            </c:choose>
                            <h3 style="margin: 2px 0 0 0;">${shipper.name}</h3>
                        </div>

                        <div class="profile-content">
                            <div class="profile-info-box info-card">
                                <h5 class="fw-bold text-secondary mb-3">
                                    <i class="fa-solid fa-id-card me-2"></i>Thông tin cá nhân
                                </h5>

                                <div class="profile-info">
                                    <label>Số điện thoại:</label>
                                    <span>${shipper.phone != null ? shipper.phone : 'Chưa cập nhật'}</span>
                                </div>

                                <div class="profile-info">
                                    <label>Email:</label>
                                    <span>${shipper.user.email != null ? shipper.user.email : 'Chưa cập nhật'}</span>
                                </div>

                                <div class="profile-info">
                                    <label>Cục vận chuyển:</label>
                                    <span>${shipper.carrier != null ? shipper.carrier.name : 'Xe máy'}</span>
                                </div>

                                <div class="profile-info">
                                    <label>Biển số xe:</label>
                                    <span>${shipper.vehicleNumber != null ? shipper.vehicleNumber : 'Chưa có'}</span>
                                </div>

                                <div class="profile-info">
                                    <label>Quê quán:</label>
                                    <span>${user.address != null ? user.address : 'Chưa cập nhật'}</span>
                                </div>

                                <div class="profile-info">
                                    <label>Trạng thái:</label>
                                    <span class="${shipper.status == 'ACTIVE' ? 'status-active' : 'status-inactive'}">
                                        ${shipper.status == 'ACTIVE' ? 'Đang hoạt động' : 'Ngừng hoạt động'}
                                    </span>
                                </div>
                            </div>

                            <div class="edit-section info-card text-center flex-fill mt-3">
                                <h5 class="fw-bold text-secondary mb-3">
                                    <i class="fa-solid fa-gear me-2"></i>Thao tác
                                </h5>
                                <p class="text-muted">
                                    Bạn có thể chỉnh sửa thông tin cá nhân và cập nhật trạng thái hoạt động của mình tại
                                    đây.
                                </p>
                                <a href="${pageContext.request.contextPath}/shipper/information/update-profile"
                                    class="btn btn-primary edit-btn">
                                    <i class="fa-solid fa-pen-to-square me-1"></i> Chỉnh sửa thông tin
                                </a>
                            </div>

                        </div>
                    </div>

                </div>

            </div>



            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>