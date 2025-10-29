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
                        background-color: #0d6efd;
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

                    /* Nút theo màu trạng thái */
                    .btn-status {
                        border: 1px solid transparent;
                        transition: all 0.3s ease;
                        font-weight: 500;
                    }

                    .btn-status-confirmed {
                        color: #0dcaf0;
                        border-color: #0dcaf0;
                        background-color: white;
                    }

                    .btn-status-confirmed:hover {
                        background-color: #0dcaf0;
                        color: white;
                    }

                    /* Đang giao (primary - xanh dương) */
                    .btn-status-shipping {
                        color: #0d6efd;
                        border-color: #0d6efd;
                        background-color: white;
                    }

                    .btn-status-shipping:hover {
                        background-color: #0d6efd;
                        color: white;
                    }

                    /* Đã giao (success - xanh lá) */
                    .btn-status-delivered {
                        color: #198754;
                        border-color: #198754;
                        background-color: white;
                    }

                    .btn-status-delivered:hover {
                        background-color: #198754;
                        color: white;
                    }

                    /* Trả hàng (tím) */
                    .btn-status-returned {
                        color: #6f42c1;
                        border-color: #6f42c1;
                        background-color: white;
                    }

                    .btn-status-returned:hover {
                        background-color: #6f42c1;
                        color: white;
                    }

                    /* Nút chung */
                    .btn-status:focus {
                        box-shadow: 0 0 0 0.15rem rgba(0, 0, 0, 0.1);
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
                            <div class="card-body py-4" style="background-color: #fff; border-top: 1px solid #eee;">

                                <!-- Bộ lọc -->
                                <form class="d-flex justify-content-evenly align-items-end flex-wrap gap-4">

                                    <!-- Lọc theo trạng thái -->
                                    <div class="d-flex flex-column align-items-start text-center">
                                        <label for="statusFilter" class="fw-bold mb-2 text-dark"
                                            style="font-size: 15px;">
                                            Trạng thái
                                        </label>
                                        <select id="statusFilter"
                                            class="form-select fw-semibold text-dark border rounded-4 shadow-sm btn-lift"
                                            style="min-width: 220px; height: 48px; font-size: 15px; border-radius: 12px;">
                                            <option value="">-- Tất cả --</option>
                                            <option value="CONFIRMED">Đã xác nhận</option>
                                            <option value="SHIPPING">Đang giao</option>
                                            <option value="DELIVERED">Đã giao</option>
                                            <option value="CANCELLED">Hủy</option>
                                            <option value="RETURNED">Hoàn hàng</option>
                                        </select>
                                    </div>

                                    <!-- Lọc theo mốc thời gian giao hàng -->
                                    <div class="d-flex flex-column align-items-start text-center">
                                        <label for="deliveryDateFilter" class="fw-bold mb-2 text-dark"
                                            style="font-size: 15px;">
                                            Thời gian giao hàng
                                        </label>
                                        <select id="deliveryDateFilter"
                                            class="form-select fw-semibold text-dark border rounded-4 shadow-sm btn-lift"
                                            style="min-width: 220px; height: 48px; font-size: 15px; border-radius: 12px;">
                                            <option value="">-- Tất cả --</option>
                                            <option value="3days">3 ngày trước</option>
                                            <option value="1week">1 tuần trước</option>
                                            <option value="1month">1 tháng trước</option>
                                            <option value="3months">3 tháng trước</option>
                                            <option value="6months">6 tháng trước</option>
                                        </select>
                                    </div>

                                    <!-- Lọc theo khu vực -->
                                    <div class="d-flex flex-column align-items-start text-center">
                                        <label for="areaFilter" class="fw-bold mb-2 text-dark" style="font-size: 15px;">
                                            Khu vực
                                        </label>
                                        <select id="areaFilter"
                                            class="form-select fw-semibold text-dark border rounded-4 shadow-sm btn-lift"
                                            style="min-width: 220px; height: 48px; font-size: 15px; border-radius: 12px;">
                                            <option value="">-- Tất cả --</option>
                                            <option value="Quan1">Quận 1</option>
                                            <option value="Quan3">Quận 3</option>
                                            <option value="Quan5">Quận 5</option>
                                            <option value="Quan7">Quận 7</option>
                                            <option value="Quan10">Quận 10</option>
                                            <option value="QuanBinhThanh">Bình Thạnh</option>
                                            <option value="QuanGoVap">Gò Vấp</option>
                                            <option value="QuanPhuNhuan">Phú Nhuận</option>
                                            <option value="ThuDuc">Thủ Đức</option>
                                        </select>
                                    </div>

                                </form>
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
                                                    <th style="width: 12%;">Mã đơn</th>
                                                    <th style="width: 30%;">Địa chỉ</th>
                                                    <th style="width: 15%;">Số tiền</th>
                                                    <th style="width: 15%;">Phương thức</th>
                                                    <th style="width: 15%;">Trạng thái</th>
                                                    <th style="width: 13%;">Hành động</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="orderDetail" items="${orders}">
                                                    <tr>
                                                        <!-- Mã đơn -->
                                                        <td>
                                                            <a href="${pageContext.request.contextPath}/shipper/order/detail/${orderDetail.order.id}"
                                                                class="text-decoration-none fw-bold text-primary">
                                                                #${orderDetail.order.id}
                                                            </a>
                                                        </td>

                                                        <!-- Địa chỉ -->
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${not empty orderDetail.order.address}">
                                                                    ${orderDetail.order.address.receiverAddress}
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <em>Không có địa chỉ</em>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>

                                                        <!-- Tổng tiền -->
                                                        <td>${orderDetail.finalPrice}</td>

                                                        <!-- Phương thức -->
                                                        <td>
                                                            <c:out value="${orderDetail.order.paymentMethod}"
                                                                default="Chưa có" />
                                                        </td>

                                                        <!-- Trạng thái -->
                                                        <td>
                                                            <c:set var="statusUpper"
                                                                value="${fn:toUpperCase(fn:trim(orderDetail.status))}" />
                                                            <c:choose>
                                                                <c:when test="${statusUpper == 'CONFIRMED'}">
                                                                    <span class="badge bg-info text-white">Đã xác
                                                                        nhận</span>
                                                                </c:when>
                                                                <c:when test="${statusUpper == 'SHIPPING'}">
                                                                    <span class="badge"
                                                                        style="background-color: #fee20d; color: white;">Đang
                                                                        giao</span>
                                                                </c:when>

                                                                <c:when test="${statusUpper == 'DELIVERED'}">
                                                                    <span class="badge bg-success text-white">Đã
                                                                        giao</span>
                                                                </c:when>
                                                                <c:when test="${statusUpper == 'RETURNED'}">
                                                                    <span class="badge"
                                                                        style="background-color:#6f42c1;color:white;">
                                                                        Trả hàng
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-dark">Không xác định</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${statusUpper == 'CONFIRMED'}">
                                                                    <button type="button"
                                                                        class="btn btn-status btn-sm btn-status-confirmed"
                                                                        data-bs-toggle="tooltip"
                                                                        title="Bắt đầu giao hàng"
                                                                        data-bs-target="#confirmModal"
                                                                        data-action-url="${pageContext.request.contextPath}/shipper/order/start/${orderDetail.id}"
                                                                        data-action-text="Bạn có chắc muốn bắt đầu giao hàng cho đơn này?">
                                                                        <i class="fas fa-truck-loading"></i>
                                                                    </button>
                                                                </c:when>

                                                                <c:when test="${statusUpper == 'SHIPPING'}">
                                                                    <button type="button"
                                                                        class="btn btn-status btn-sm btn-status-shipping"
                                                                        title="Xem chi tiết và xác nhận đơn này"
                                                                        onclick="location.href='${pageContext.request.contextPath}/shipper/shipping?selectedId=${orderDetail.id}'">
                                                                        <i class="fas fa-check-circle"></i>
                                                                    </button>
                                                                </c:when>


                                                                <c:when test="${statusUpper == 'DELIVERED'}">
                                                                    <button type="button"
                                                                        class="btn btn-status btn-sm btn-status-delivered"
                                                                        data-bs-toggle="tooltip" title="Hoàn đơn"
                                                                        data-bs-target="#confirmModal"
                                                                        data-action-url="${pageContext.request.contextPath}/shipper/order/finish/${orderDetail.id}"
                                                                        data-action-text="Xác nhận hoàn đơn này?">
                                                                        <i class="fas fa-undo"></i>
                                                                    </button>
                                                                </c:when>

                                                                <c:when test="${statusUpper == 'RETURNED'}">
                                                                    <button type="button"
                                                                        class="btn btn-status btn-sm btn-status-returned"
                                                                        data-bs-toggle="tooltip" title="Xem lý do"
                                                                        onclick="window.location.href='${pageContext.request.contextPath}/shipper/order/return-reason/${orderDetail.id}'">
                                                                        <i class="fas fa-info-circle"></i>
                                                                    </button>
                                                                </c:when>

                                                                <c:otherwise>
                                                                    <span class="text-muted" title="Không có hành động">
                                                                        <i class="fas fa-ban"></i>
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>

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


                <!-- Modal xác nhận -->
                <div class="modal fade" id="confirmModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header bg-warning text-white">
                                <h5 class="modal-title"><i class="fas fa-exclamation-triangle me-2"></i>Xác nhận hành
                                    động</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Đóng"></button>
                            </div>
                            <div class="modal-body">
                                <p id="confirmMessage">Bạn có chắc muốn thực hiện hành động này?</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                <a id="confirmAction" href="#" class="btn btn-warning text-white">Xác nhận</a>
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

                <script>
                    // Bật tooltip Bootstrap
                    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
                    [...tooltipTriggerList].map(el => new bootstrap.Tooltip(el));

                    // Khi click nút => cập nhật nội dung modal
                    document.addEventListener('click', function (e) {
                        if (e.target.closest('[data-bs-target="#confirmModal"]')) {
                            const btn = e.target.closest('button');
                            const modal = document.getElementById('confirmModal');
                            const confirmMessage = modal.querySelector('#confirmMessage');
                            const confirmAction = modal.querySelector('#confirmAction');

                            confirmMessage.textContent = btn.getAttribute('data-action-text');
                            confirmAction.href = btn.getAttribute('data-action-url');

                            const bootstrapModal = new bootstrap.Modal(modal);
                            bootstrapModal.show();
                        }
                    });
                </script>