<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <head>
            <link rel="shortcut icon" href="../../images/favicon.png" />
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        </head>

        <style>
            .profile-container {
                width: 90%;
                margin: 20px auto;
                border-radius: 20px;
                background: #fff;
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
                overflow: hidden;
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
                flex-direction: column;
                padding: 40px;
                gap: 30px;
            }

            .form-section {
                background-color: #f8f9fa;
                padding: 25px;
                border-radius: 15px;
                box-shadow: inset 0 0 8px rgba(0, 0, 0, 0.05);
            }

            .form-section label {
                font-weight: 600;
            }

            .text-center img {
                margin-bottom: 15px;
            }

            .btn-submit {
                border-radius: 30px;
                padding: 10px 25px;
                font-weight: 600;
            }
        </style>

        <div class="main-panel">
            <div class="content-wrapper">
                <div class="profile-container">

                    <!-- Header avatar + tên -->
                    <div class="profile-header">
                        <c:choose>
                            <c:when test="${not empty shipper.user.image}">
                                <img id="profileImagePreview"
                                    src="<c:url value='/resources/admin/images/user/${shipper.user.image}'/>"
                                    alt="Avatar">
                            </c:when>
                            <c:otherwise>
                                <img id="profileImagePreview"
                                    src="<c:url value='/resources/admin/images/user/user-avatar.jpg'/>" alt="Avatar">
                            </c:otherwise>
                        </c:choose>


                    </div>

                    <!-- Form cập nhật -->
                    <div class="profile-content">
                        <form action="${pageContext.request.contextPath}/shipper/information/update-profile"
                            method="post" enctype="multipart/form-data" class="form-section">
                            <input type="hidden" name="shipperId" value="${shipper.id}" />

                            <div class="mb-4 text-center">
                                <label class="form-label fw-bold">Cập nhật ảnh đại diện</label>
                                <input type="file" name="image" id="imageFileInput" class="form-control d-inline-block"
                                    style="max-width:250px;">
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Họ và tên</label>
                                    <input type="text" class="form-control" name="name" value="${shipper.name}"
                                        required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Số điện thoại</label>
                                    <input type="text" class="form-control" name="phone" value="${shipper.phone}">
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" name="email" value="${shipper.user.email}"
                                        required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Địa chỉ</label>
                                    <input type="text" class="form-control" name="address"
                                        value="${shipper.user.address}">
                                </div>
                            </div>

                            <div class="row g-3 mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Biển số xe</label>
                                    <input type="text" class="form-control" name="vehicleNumber"
                                        value="${shipper.vehicleNumber}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Trạng thái</label>
                                    <select class="form-select" name="status">
                                        <option value="ACTIVE" ${shipper.status=='ACTIVE' ? 'selected' : '' }>Đang hoạt
                                            động</option>
                                        <option value="INACTIVE" ${shipper.status=='INACTIVE' ? 'selected' : '' }>Ngừng
                                            hoạt động</option>
                                    </select>
                                </div>
                            </div>

                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-success btn-submit me-2">Cập nhật</button>
                                <a href="${pageContext.request.contextPath}/shipper/information/update-profile"
                                    class="btn btn-secondary btn-submit">Hủy</a>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Preview ảnh ngay khi chọn file
            document.getElementById('imageFileInput').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('profileImagePreview').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });
        </script>