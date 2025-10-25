<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <head>
                    <link rel="shortcut icon" href="../../images/favicon.png" />
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                </head>
                <style>
                    /* Card bo tròn, bóng mượt */
                    .card-custom {
                        border-radius: 15px;
                        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
                        overflow: hidden;
                        transition: transform 0.2s ease-in-out;
                        margin-bottom: 5px;
                    }

                    .card-custom:hover {
                        transform: translateY(-3px);
                    }

                    /* Card header gradient */
                    .card-header-custom {
                        background: linear-gradient(90deg, #4e73df 0%, #1cc88a 100%);
                        color: #fff;
                        font-weight: bold;
                        font-size: 1.2rem;
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 12px 20px;
                    }

                    /* Table bo tròn, hover đẹp */
                    .table-custom thead th {
                        background-color: #4e73df;
                        color: #fff;
                        text-align: center;
                        vertical-align: middle;
                    }

                    .table-custom tbody tr {
                        transition: background-color 0.2s;
                    }

                    .table-custom tbody tr:hover {
                        background-color: #f8f9fc;
                    }

                    .table-custom td,
                    .table-custom th {
                        vertical-align: middle;
                        padding: 12px;
                        border-top: 1px solid #dee2e6;
                    }

                    /* Badge trạng thái đẹp */
                    .badge {
                        font-size: 0.85rem;
                        padding: 0.35em 0.65em;
                        border-radius: 12px;
                        font-weight: 500;
                    }

                    .badge-danger {
                        background-color: #858796;
                        color: #fff;
                    }

                    .badge-warning {
                        background-color: #fff200;
                        color: #000000;
                    }

                    .badge-info {
                        background-color: #36b9cc;
                        color: #fff;
                    }

                    .badge-success {
                        background-color: #1cc88a;
                        color: #fff;
                    }

                    .badge-secondary {
                        background-color: #f3303d;
                        color: #fff;
                    }

                    /* Nút hành động bo tròn */
                    .action-btn {
                        width: 38px;
                        height: 38px;
                        border-radius: 50%;
                        display: inline-flex;
                        align-items: center;
                        justify-content: center;
                        transition: all 0.2s;
                        font-size: 16px;
                        border: 1px solid transparent;
                    }

                    .action-btn-primary {
                        color: #4e73df;
                        border-color: #4e73df;
                    }

                    .action-btn-primary:hover {
                        background-color: #4e73df;
                        color: #fff;
                    }

                    /* Modal bo tròn và bóng nhẹ */
                    .modal-content {
                        border-radius: 12px;
                        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
                        overflow: hidden;
                    }

                    .modal-header {
                        font-weight: bold;
                        font-size: 1.1rem;
                    }

                    .modal-footer button {
                        border-radius: 50px;
                        padding: 6px 20px;
                    }

                    /* Card Action */
                    .card-action {
                        border-radius: 15px;
                        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
                        overflow: hidden;
                        transition: transform 0.2s ease-in-out;
                        margin-bottom: 10px;
                        padding: 15px;
                    }

                    .card-action:hover {
                        transform: translateY(-2px);
                    }

                    .card-action .btn {
                        margin-right: 8px;
                    }

                    .btn-lift:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.25);
                    }

                    .btn-lift {
                        transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
                    }

                    .edit-status {
                        cursor: pointer;
                        margin-left: 6px;
                        color: #6c757d;
                        font-size: 1rem;
                        transition: color 0.2s ease, transform 0.2s ease;
                    }

                    .edit-status:hover {
                        color: #0d6efd;
                        transform: scale(1.2);
                    }

                    #statusFilter:focus {
                        border-color: #4e73df;
                        box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
                    }

                    #statusFilter:hover {
                        box-shadow: 0 3px 8px rgba(0, 0, 0, 0.15);
                    }
                </style>

                <div class="main-panel">
                    <div class="content-wrapper">

                        <!-- Header Danh sách đơn hàng -->
                        <div class="card mb-3 border-0 shadow-sm overflow-hidden card-custom"
                            style="border-radius: 15px;">
                            <div class="card-header-custom d-flex justify-content-between align-items-center">
                                <h4 class="mb-0 fw-bold">
                                    <i class="fas fa-receipt me-2"></i> Danh sách đơn hàng
                                </h4>
                                <span class="badge bg-light text-dark fs-6 shadow-sm">
                                    <i class="fas fa-box me-1"></i> Tổng: ${fn:length(orders)} đơn hàng
                                </span>
                            </div>

                            <!-- Thanh hành động -->
                            <div class="card-body d-flex justify-content-between align-items-center flex-wrap py-3"
                                style="background-color: #fff; border-top: 1px solid #eee;">
                                <!-- Bộ lọc -->
                                <form action="/vendor/order/filter" method="get"
                                    class="d-flex align-items-center mb-2 mb-sm-0">
                                    <input type="hidden" name="shop_id" value="${shop.id}">
                                    <select name="status" id="statusFilter"
                                        class="form-select fw-semibold text-dark border rounded-3 shadow-sm btn-lift"
                                        onchange="this.form.submit()">
                                        <option value="">-- Tất cả Trạng thái --</option>
                                        <option value="PENDING" ${status=='PENDING' ? 'selected' : '' }>Đơn hàng mới
                                        </option>
                                        <option value="CONFIRMED" ${status=='CONFIRMED' ? 'selected' : '' }>Đã xác nhận
                                        </option>
                                        <option value="SHIPPING" ${status=='SHIPPING' ? 'selected' : '' }>Đang giao
                                        </option>
                                        <option value="DELIVERED" ${status=='DELIVERED' ? 'selected' : '' }>Đã giao
                                        </option>
                                        <option value="CANCELLED" ${status=='CANCELLED' ? 'selected' : '' }>Hủy</option>
                                        <option value="RETURNED" ${status=='RETURNED' ? 'selected' : '' }>Trả hàng -
                                            Hoàn tiền</option>
                                    </select>

                                </form>

                                <!-- Nút bên phải -->
                                <div class="d-flex align-items-center">
                                    <button type="button" class="btn btn-outline-primary btn-sm me-2 btn-lift"
                                        onclick="location.reload()">
                                        <i class="fas fa-rotate-right me-1"></i> Refresh
                                    </button>
                                    <button type="button" class="btn btn-outline-info btn-sm btn-lift"
                                        onclick="confirmExport()">
                                        <i class="fas fa-download me-1"></i> Export
                                    </button>
                                </div>
                            </div>
                        </div>

                        <!-- Card chứa bảng -->
                        <div class="card card-custom border-0 shadow-sm" style="border-radius: 15px;">
                            <div class="card-body bg-white">
                                <div class="table-responsive">
                                    <form:form>
                                        <table class="table table-hover table-custom align-middle text-center">
                                            <thead>
                                                <tr>
                                                    <th>Mã đơn hàng</th>
                                                    <th>Người đặt</th>
                                                    <th>Phương thức thanh toán</th>
                                                    <th>Tổng tiền</th>
                                                    <th>Trạng thái</th>
                                                    <th>Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${orders}">
                                                    <tr>
                                                        <td>#${order.id}</td>
                                                        <td>${order.user.fullName}</td>
                                                        <td>${order.paymentMethod}</td>
                                                        <td>${order.totalPrice}</td>
                                                        <td>
                                                            <c:set var="statusUpper"
                                                                value="${fn:toUpperCase(order.status)}" />

                                                            <c:choose>
                                                                <c:when test="${statusUpper == 'PENDING'}">
                                                                    <span class="badge badge-danger">Đơn hàng mới</span>
                                                                </c:when>
                                                                <c:when test="${statusUpper == 'CONFIRMED'}">
                                                                    <span class="badge badge-warning">Đã xác nhận</span>
                                                                </c:when>
                                                                <c:when test="${statusUpper == 'SHIPPING'}">
                                                                    <span class="badge badge-info">Đang giao</span>
                                                                </c:when>
                                                                <c:when test="${statusUpper == 'DELIVERED'}">
                                                                    <span class="badge badge-success">Đã giao</span>
                                                                </c:when>
                                                                <c:when test="${statusUpper == 'CANCELLED'}">
                                                                    <span class="badge badge-secondary">Hủy</span>
                                                                </c:when>
                                                                <c:when test="${statusUpper == 'RETURNED'}">
                                                                    <span class="badge"
                                                                        style="background-color:#6f42c1;color:white;">Trả
                                                                        hàng - Hoàn tiền</span>
                                                                </c:when>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/vendor/order/detail/${order.id}"
                                                                class="btn action-btn action-btn-primary"
                                                                data-bs-toggle="tooltip" title="Xem chi tiết">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="modal fade" id="filterModal" tabindex="-1" aria-labelledby="filterModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header bg-primary text-white">
                                <h5 class="modal-title" id="filterModalLabel">Bộ lọc đơn hàng</h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                            </div>
                            <form action="/vendor/order" method="get">
                                <div class="modal-body">
                                    <div class="mb-3">
                                        <label for="status">Trạng thái đơn hàng</label>
                                        <select class="form-control" name="status" id="status">
                                            <option value="">-- Tất cả Trạng thái --</option>
                                            <option value="PENDING" ${status=='PENDING' ? 'selected' : '' }>Đơn hàng mới
                                            </option>
                                            <option value="CONFIRMED" ${status=='CONFIRMED' ? 'selected' : '' }>Đã xác
                                                nhận</option>
                                            <option value="SHIPPING" ${status=='SHIPPING' ? 'selected' : '' }>Đang giao
                                            </option>
                                            <option value="Đã giao" ${status=='DELIVERED' ? 'selected' : '' }>Đã giao
                                            </option>
                                            <option value="CANCELLED" ${status=='CANCELLED' ? 'selected' : '' }>Hủy
                                            </option>
                                            <option value="RETURNED" ${status=='RETURNED' ? 'selected' : '' }>Trả hàng -
                                                Hoàn tiền</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary">Áp dụng</button>
                                    <button type="button" class="btn btn-secondary"
                                        data-bs-dismiss="modal">Đóng</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>


                <!-- Modal xác nhận xuất -->
                <div class="modal fade" id="confirmExportModal" tabindex="-1" role="dialog"
                    aria-labelledby="confirmExportLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content border-info">
                            <div class="modal-header bg-info text-white">
                                <h5 class="modal-title" id="confirmExportLabel"><i
                                        class="fa-solid fa-circle-info mr-2"></i>
                                    Xác nhận
                                </h5>
                                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body text-center">Bạn có chắc muốn xuất danh sách đơn hàng
                                không?</div>
                            <div class="modal-footer justify-content-center">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                                <button type="button" class="btn btn-info" onclick="doExport()">Xác nhận</button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal kết quả -->
                <div class="modal fade" id="exportResultModal" tabindex="-1" role="dialog"
                    aria-labelledby="exportResultLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered" role="document">
                        <div class="modal-content border-success">
                            <div class="modal-header bg-success text-white">
                                <h5 class="modal-title" id="exportResultLabel">
                                    <i class="fa-solid fa-circle-check mr-2"></i> Thông báo
                                </h5>
                                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body text-center" id="exportMessage"
                                style="font-size: 18px; font-weight: 500;"></div>
                            <div class="modal-footer justify-content-center">
                                <button type="button" class="btn btn-success" data-dismiss="modal">Đóng</button>
                            </div>
                        </div>
                    </div>
                </div>


                <style>
                    .status-select {
                        font-size: 1.15rem;
                        background: linear-gradient(135deg, #f8faff 0%, #eef3ff 100%);
                        border-color: #b3c7ff;
                        transition: all 0.3s ease;
                        color: #212529;
                    }

                    .status-select:hover {
                        border-color: #0d6efd;
                        background: linear-gradient(135deg, #ffffff 0%, #e9f1ff 100%);
                        box-shadow: 0 0 10px rgba(13, 110, 253, 0.3);
                    }

                    .status-select:focus {
                        outline: none;
                        border-color: #0d6efd;
                        box-shadow: 0 0 12px rgba(13, 110, 253, 0.5);
                        background: #fff;
                    }

                    /* Tùy chỉnh option trong dropdown */
                    select.status-select option {
                        border-radius: 10px;
                        padding: 10px;
                        background-color: #fff;
                        transition: background-color 0.2s ease;
                    }

                    select.status-select option:hover {
                        background-color: #dce6ff;
                    }
                </style>

                <!-- Modal cập nhật trạng thái -->
                <div class="modal fade" id="updateStatusModal" tabindex="-1" aria-labelledby="updateStatusLabel"
                    aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content shadow-lg border-0 rounded-4">
                            <div class="modal-header bg-primary text-white rounded-top-4">
                                <h5 class="modal-title fw-bold" id="updateStatusLabel">
                                    <i class="bi bi-arrow-repeat me-2"></i> Cập nhật trạng thái đơn hàng
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"
                                    aria-label="Đóng"></button>
                            </div>

                            <div class="modal-body px-4 py-4">
                                <form id="updateStatusForm">
                                    <input type="hidden" id="orderIdUpdate" name="orderId">

                                    <div class="mb-4">
                                        <label for="statusUpdate" class="form-label fw-bold fs-5">
                                            <i class="bi bi-list-check me-2"></i> Chọn trạng thái mới:
                                        </label>
                                        <select id="statusUpdate" name="status"
                                            class="form-select form-select-lg border-2 rounded-pill shadow-sm p-3 status-select">
                                            <option value="PENDING">Đơn hàng mới</option>
                                            <option value="CONFIRMED">Đã xác nhận</option>
                                            <option value="SHIPPING">Đang giao</option>
                                            <option value="DELIVERED">Đã giao</option>
                                            <option value="CANCELLED">Hủy</option>
                                            <option value="RETURNED">Trả hàng - Hoàn tiền</option>
                                        </select>


                                    </div>
                                </form>
                            </div>

                            <div class="modal-footer ">
                                <button type="button" class="btn btn-secondary rounded-3 px-4" data-bs-dismiss="modal">
                                    Hủy
                                </button>
                                <button type="button" id="saveStatusBtn" class="btn btn-primary rounded-3 px-4">
                                    Lưu thay đổi
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- content-wrapper ends -->
                <!-- partial:partials/_footer.html -->
                <!-- <footer class="footer">
            <div class="d-sm-flex justify-content-center justify-content-sm-between">
              <span class="text-center text-sm-left d-block d-sm-inline-block">Copyright © <a href="https://www.bootstrapdash.com/" target="_blank">bootstrapdash.com</a> 2020</span>
              <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Free <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap dashboard </a>templates from Bootstrapdash.com</span>
            </div>
          </footer> -->
                <!-- partial -->
                </div>
                <!-- main-panel ends -->
                </div>
                <!-- page-body-wrapper ends -->
                </div>
                <!-- container-scroller -->
                <!-- base:js -->
                <script src="vendors/js/vendor.bundle.base.js"></script>
                <!-- endinject -->
                <!-- Plugin js for this page-->
                <!-- End plugin js for this page-->
                <!-- inject:js -->
                <script src="js/off-canvas.js"></script>
                <script src="js/hoverable-collapse.js"></script>
                <script src="js/template.js"></script>
                <!-- <script src="js/settings.js"></script> -->
                <script src="js/todolist.js"></script>
                <!-- endinject -->
                <!-- plugin js for this page -->
                <!-- End plugin js for this page -->
                <!-- Custom js for this page-->
                <!-- End custom js for this page-->
                <!-- Code injected by live-server -->
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
                <!-- Bootstrap 5 Bundle (có cả PopperJS & Modal) -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

                <script>
                    // <![CDATA[  <-- For SVG support
                    if ('WebSocket' in window) {
                        (function () {
                            function refreshCSS() {
                                var sheets = [].slice.call(document.getElementsByTagName("link"));
                                var head = document.getElementsByTagName("head")[0];
                                for (var i = 0; i < sheets.length; ++i) {
                                    var elem = sheets[i];
                                    var parent = elem.parentElement || head;
                                    parent.removeChild(elem);
                                    var rel = elem.rel;
                                    if (elem.href && typeof rel != "string" || rel.length == 0 || rel.toLowerCase() == "stylesheet") {
                                        var url = elem.href.replace(/(&|\?)_cacheOverride=\d+/, '');
                                        elem.href = url + (url.indexOf('?') >= 0 ? '&' : '?') + '_cacheOverride=' + (new Date().valueOf());
                                    }
                                    parent.appendChild(elem);
                                }
                            }
                            var protocol = window.location.protocol === 'http:' ? 'ws://' : 'wss://';
                            var address = protocol + window.location.host + window.location.pathname + '/ws';
                            var socket = new WebSocket(address);
                            socket.onmessage = function (msg) {
                                if (msg.data == 'reload') window.location.reload();
                                else if (msg.data == 'refreshcss') refreshCSS();
                            };
                            if (sessionStorage && !sessionStorage.getItem('IsThisFirstTime_Log_From_LiveServer')) {
                                console.log('Live reload enabled.');
                                sessionStorage.setItem('IsThisFirstTime_Log_From_LiveServer', true);
                            }
                        })();
                    }
                    else {
                        console.error('Upgrade your browser. This Browser is NOT supported WebSocket for Live-Reloading.');
                    }
                    // ]]>
                </script>

                <script>
                    function confirmExport() {
                        $('#confirmExportModal').modal('show');
                    }

                    function doExport() {
                        $('#confirmExportModal').modal('hide');

                        // Lấy giá trị filter hiện tại từ form hoặc input
                        const status = document.querySelector('#statusFilter')?.value || '';
                        const fromDate = document.querySelector('#fromDate')?.value || '';
                        const toDate = document.querySelector('#toDate')?.value || '';

                        fetch(`/vendor/order/export?status=${status}&fromDate=${fromDate}&toDate=${toDate}`)
                            .then(res => res.json())
                            .then(data => {
                                document.getElementById('exportMessage').innerText = data.message;
                                $('#exportResultModal').modal('show');
                            })
                            .catch(err => {
                                document.getElementById('exportMessage').innerText = '❌ Có lỗi xảy ra khi xuất file!';
                                $('#exportResultModal').modal('show');
                            });
                    }
                </script>

                <script>
                    $(document).ready(function () {
                        // Khi nhấn nút "View"
                        $(document).on('click', '.view-order-btn', function (e) {
                            e.preventDefault();
                            const orderId = $(this).data('id');
                            const tbody = $('#orderDetailsTable tbody');

                            tbody.html('<tr><td colspan="5" class="text-center text-muted">Đang tải...</td></tr>');

                            // Gọi API để lấy chi tiết đơn hàng
                            $.ajax({
                                url: '/vendor/order/details/' + orderId,
                                method: 'GET',
                                success: function (data) {
                                    tbody.empty();

                                    if (!data || data.length === 0) {
                                        tbody.html('<tr><td colspan="5" class="text-center text-muted">Không có dữ liệu chi tiết đơn hàng.</td></tr>');
                                        return;
                                    }

                                    data.forEach(function (item) {
                                        const image = item.image ? `/resources/admin/images/product/${item.image}` : '/resources/admin/images/no-image.png';
                                        const row = `
                        <tr>
                            <td><img src="${image}" class="img-fluid rounded" style="width:80px;height:80px;object-fit:cover;"></td>
                            <td>${item.productName}</td>
                            <td>${item.shopName}</td>
                            <td>${item.quantity}</td>
                            <td>${item.price.toLocaleString('vi-VN')} ₫</td>
                        </tr>`;
                                        tbody.append(row);
                                    });

                                    // Gán thông tin đơn hàng vào input
                                    $('#orderIdDetail').val(orderId);
                                    $('#paymentMethodDetail').val(data[0].paymentMethod || '');
                                    $('#statusDetail').val(data[0].status || '');
                                    $('#totalPriceDetail').val(data[0].totalPrice?.toLocaleString('vi-VN') + ' ₫' || '');
                                },
                                error: function () {
                                    tbody.html('<tr><td colspan="5" class="text-center text-danger">Lỗi khi tải dữ liệu chi tiết.</td></tr>');
                                }
                            });
                        });
                    });

                </script>

                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
                        tooltipTriggerList.map(function (tooltipTriggerEl) {
                            return new bootstrap.Tooltip(tooltipTriggerEl, {
                                delay: { "show": 100, "hide": 50 }, // hiện nhanh
                                boundary: 'window'
                            });
                        });
                    });
                </script>

                <script>
                    $(document).ready(function () {
                        // Khi nhấn biểu tượng bút chì
                        $(document).on("click", ".edit-status", function () {
                            const orderId = $(this).data("order-id");
                            const currentStatus = $(this).data("status");
                            $("#orderIdUpdate").val(orderId);
                            $("#statusUpdate").val(currentStatus);
                            $("#updateStatusModal").modal("show");
                        });
                        $("#saveStatusBtn").click(function () {
                            const orderId = $("#orderIdUpdate").val();
                            const status = $("#statusUpdate").val();

                            if (!orderId || !status) {
                                alert("Thiếu orderId hoặc status!");
                                return;
                            }

                            $.ajax({
                                url: "/vendor/order/update-status",
                                method: "POST",
                                data: { orderId: orderId, status: status },
                                success: function (response) {
                                    if (response.status === "success") {
                                        alert(response.message);
                                        location.reload();
                                    } else {
                                        alert(response.message);
                                    }
                                },
                                error: function () {
                                    alert("Có lỗi xảy ra khi cập nhật trạng thái!");
                                }
                            });
                        });
                    });

                </script>