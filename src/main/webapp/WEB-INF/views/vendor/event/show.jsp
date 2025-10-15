<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
                <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


                    <head>
                        <link rel="shortcut icon" href="../../images/favicon.png" />
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
                        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
                            rel="stylesheet">

                    </head>
                    <style>
                        /* Filter */
                        #filter-group .btn {
                            border-radius: 50px;
                            font-weight: 500;
                            transition: all 0.2s ease-in-out;
                        }

                        #filter-group .btn-primary {
                            background-color: #b00e0e;
                            border-color: #b00e0e;
                            color: #fff;
                        }

                        #filter-group .btn-outline-primary {
                            color: #b00e0e;
                            border-color: #b00e0e;
                        }

                        #filter-group .btn-outline-primary:hover {
                            background-color: #b00e0e;
                            color: #fff;
                        }

                        /* --- Edit + Delete --- */

                        .action-btns .edit-btn,
                        .action-btns .del-btn {
                            background-color: #0d6efd;
                            color: #fff;
                            border: 2px solid transparent;
                            transition: border-color 0.1s ease;
                        }

                        /* Hover chỉ viền */
                        .action-btns .edit-btn:hover,
                        .action-btns .del-btn:hover {
                            border-color: #ffffff;
                            cursor: pointer;
                        }


                        /* --- COMMON STYLES --- */
                        .coupon-card {
                            position: relative;
                            overflow: hidden;
                            padding: 20px;
                            border-radius: 12px;
                            color: #fff;
                            text-align: left;
                            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                        }

                        /* --- TEXT STYLES --- */
                        .coupon-card .method {
                            font-size: 13px;
                            font-weight: 400;
                            color: rgba(255, 255, 255, 1);
                            margin-bottom: 10px;
                            background: rgba(0, 0, 0, 0.2);
                            padding: 3px 8px;
                            border-radius: 4px;
                            display: inline-block;
                        }

                        .coupon-card .promo-title {
                            font-size: 22px;
                            font-weight: 600;
                            line-height: 30px;
                            margin-bottom: 3px;
                        }

                        .coupon-card .description {
                            font-size: 16px;
                            font-weight: 400;
                            margin-bottom: 15px;
                        }


                        /* --- DIVIDER --- */
                        .coupon-card .divider {
                            height: 1px;
                            background: rgba(255, 255, 255, 0.4);
                            margin: 20px 0;
                        }

                        /* --- FOOTER --- */
                        .coupon-card .footer-row {
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                        }

                        .coupon-card .valid-date {
                            font-size: 13px;
                            font-weight: 500;
                            margin-bottom: 0;
                            font-style: italic;
                        }

                        .coupon-card .public-badge {
                            background: #fff;
                            padding: 4px 12px;
                            border-radius: 4px;
                            font-size: 14px;
                            font-weight: 600;
                        }

                        /* --- ACTION BUTTONS --- */
                        .coupon-card .action-btns {
                            position: absolute;
                            top: 8px;
                            right: 10px;
                            display: flex;
                            gap: 6px;
                            z-index: 50;
                        }

                        .coupon-card .edit-btn,
                        .coupon-card .del-btn {
                            background: #fff;
                            border: 1px solid currentColor;
                            padding: 6px 10px;
                            border-radius: 6px;
                            cursor: pointer;
                            font-size: 13px;
                            display: flex;
                            align-items: center;
                            gap: 4px;
                        }

                        .coupon-card .edit-btn:focus,
                        .coupon-card .del-btn:focus {
                            outline: none;
                            box-shadow: none;
                        }

                        .coupon-card-active {
                            background: #396afc;
                        }

                        .coupon-card-expired {
                            background: #dc3545;
                        }

                        .coupon-card-upcoming {
                            background: #ff9900;
                        }

                        .badge-active {
                            color: #396afc;
                            font-weight: bold;
                        }

                        .badge-expired {
                            color: #ff4d4f;
                            font-weight: bold;
                        }

                        .badge-upcoming {
                            color: #ff9900;
                            font-weight: bold;
                        }

                        .edit-btn.active,
                        .del-btn.active {
                            color: #396afc;
                        }

                        .edit-btn.expired,
                        .del-btn.expired {
                            color: #ff4d4f;
                        }

                        .edit-btn.upcoming,
                        .del-btn.upcoming {
                            color: #ff9900;
                        }

                        /* --- CIRCLES --- */
                        .coupon-card .circle1,
                        .coupon-card .circle2 {
                            background: #fff;
                            width: 40px;
                            height: 50px;
                            border-radius: 50%;
                            position: absolute;
                            top: 60%;
                            transform: translateY(-60%);
                        }

                        .coupon-card .circle1 {
                            left: -25px;
                        }

                        .coupon-card .circle2 {
                            right: -25px;
                        }

                        /* --- Coupon Card --- */
                        .coupon-card {
                            position: relative;
                            border-radius: 15px;
                            padding: 20px;
                            color: #fff;
                            text-align: left;
                            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
                            overflow: hidden;
                            transition: transform 0.2s ease;
                        }

                        .coupon-card:hover {
                            transform: translateY(-5px);
                        }

                        .coupon-card-active {
                            background: linear-gradient(135deg, #396afc, #2948ff);
                        }

                        .coupon-card-upcoming {
                            background: linear-gradient(135deg, #ff9900, #ffb84d);
                        }

                        .coupon-card-expired {
                            background: linear-gradient(135deg, #dc3545, #ff4d4f);
                        }

                        .promo-title {
                            font-size: 22px;
                            font-weight: 600;
                            margin-bottom: 5px;
                        }

                        .description {
                            font-size: 16px;
                            margin-bottom: 15px;
                        }

                        .valid-date {
                            font-size: 13px;
                            font-style: italic;
                        }

                        .public-badge {
                            font-size: 14px;
                            font-weight: 600;
                            padding: 4px 12px;
                            border-radius: 6px;
                        }

                        /* --- Action Buttons --- */
                        .action-btns {
                            position: absolute;
                            top: 12px;
                            right: 12px;
                            display: flex;
                            gap: 6px;
                        }

                        .edit-btn,
                        .del-btn {
                            border-radius: 8px;
                            padding: 6px 10px;
                            font-size: 14px;
                            display: flex;
                            align-items: center;
                            gap: 4px;
                            border: 1px solid #fff;
                            background-color: rgba(255, 255, 255, 0.2);
                            transition: all 0.2s;
                        }

                        .edit-btn:hover,
                        .del-btn:hover {
                            background-color: rgba(255, 255, 255, 0.4);
                        }

                        /* --- Circles Decoration --- */
                        .circle1,
                        .circle2 {
                            width: 50px;
                            height: 50px;
                            border-radius: 50%;
                            background: rgba(255, 255, 255, 0.2);
                            position: absolute;
                            top: 60%;
                            transform: translateY(-50%);
                        }

                        .circle1 {
                            left: -20px;
                        }

                        .circle2 {
                            right: -20px;
                        }

                        /* --- Modal Enhancements --- */
                        .modal-header.bg-primary,
                        .modal-header.bg-warning,
                        .modal-header.bg-danger {
                            color: #fff;
                        }

                        .modal-footer button {
                            min-width: 100px;
                        }
                    </style>

                    <div class="main-panel">

                        <div class="content-wrapper">

                            <div class="row mb-2"> <!-- giảm margin-bottom -->
                                <div class="col-12">
                                    <!-- Card Header Quản lý sự kiện -->
                                    <div class="card text-white w-100" style="border-radius: 15px 15px 0 0;">
                                        <div class="card-header card-header-custom d-flex justify-content-between align-items-center"
                                            style="background: linear-gradient(135deg, #396afc, #2948ff); 
                                                        border-radius: 15px 15px 0 0; 
                                                        padding: 20px 30px;">
                                            <h4 class="mb-0 fs-4"><i class="fas fa-ticket-alt me-2"></i>QUẢN LÝ SỰ KIỆN
                                            </h4>
                                            <span class="badge bg-light text-dark event-count fs-6">
                                                <i class="fas fa-calendar-alt me-1"></i> Tổng: ${fn:length(vouchers)} sự
                                                kiện
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <!-- Card Filter + Coupons -->
                                    <div class="card promo-card"
                                        style="border-radius: 0 0 15px 15px; margin-top: -5px;">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-4">
                                                <!-- Filter -->
                                                <div class="btn-group" role="group" id="filter-group">
                                                    <button type="button" class="btn btn-sm btn-primary active"
                                                        data-filter="all">All
                                                        Promos</button>
                                                    <button type="button" class="btn btn-sm btn-outline-primary"
                                                        data-filter="active">Active</button>
                                                    <button type="button" class="btn btn-sm btn-outline-primary"
                                                        data-filter="upcoming">Upcoming</button>
                                                    <button type="button" class="btn btn-sm btn-outline-primary"
                                                        data-filter="expired">Expired</button>
                                                </div>
                                                <button type="button" class="btn btn-success" data-bs-toggle="modal"
                                                    data-bs-target="#newCouponModal">
                                                    <i class="fa-solid fa-plus"></i> Add Coupon
                                                </button>
                                            </div>

                                            <hr class="custom-divider">

                                            <!-- Coupons -->
                                            <div class="row">
                                                <c:forEach var="voucher" items="${vouchers}">
                                                    <c:set var="statusClass">
                                                        <c:choose>
                                                            <c:when test="${voucher.status eq 'Active'}">active</c:when>
                                                            <c:when test="${voucher.status eq 'Expired'}">expired
                                                            </c:when>
                                                            <c:when test="${voucher.status eq 'Upcoming'}">upcoming
                                                            </c:when>
                                                            <c:otherwise>public</c:otherwise>
                                                        </c:choose>
                                                    </c:set>

                                                    <div class="col-12 col-md-4 mb-4">
                                                        <div class="coupon-card coupon-card-${statusClass}"
                                                            data-status="${voucher.status}">
                                                            <div class="action-btns">
                                                                <button type="button"
                                                                    class="edit-btn edit ${statusClass}"
                                                                    data-id="${voucher.id}">
                                                                    <i class="fa-solid fa-pen"></i>
                                                                </button>
                                                                <button type="button"
                                                                    class="del-btn delete ${statusClass}"
                                                                    data-id="${voucher.id}">
                                                                    <i class="fa-solid fa-trash"></i>
                                                                </button>
                                                            </div>
                                                            <h3 class="promo-title">${voucher.code}</h3>
                                                            <p class="description">Discount
                                                                <strong>${voucher.discount}</strong>% on
                                                                ${voucher.productName}
                                                            </p>
                                                            <div class="divider"></div>
                                                            <div
                                                                class="d-flex justify-content-between align-items-center">
                                                                <p class="valid-date">From: ${voucher.startDate}<br>To:
                                                                    ${voucher.endDate}</p>
                                                                <span
                                                                    class="public-badge badge-${statusClass}">${voucher.status}</span>
                                                            </div>
                                                            <div class="circle1"></div>
                                                            <div class="circle2"></div>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Modal add coupon -->
                            <div class="modal fade" id="newCouponModal" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-md modal-dialog-centered">
                                    <!-- modal-md nhỏ hơn modal-lg -->
                                    <div class="modal-content">
                                        <div class="modal-header bg-primary text-white">
                                            <h5 class="modal-title">New Coupon</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form:form modelAttribute="voucher" method="post"
                                                action="${pageContext.request.contextPath}/vendor/event/add">
                                                <div class="mb-3">
                                                    <form:label path="code">Code</form:label>
                                                    <form:input path="code" cssClass="form-control" />
                                                </div>
                                                <div class="mb-3">
                                                    <form:label path="discountPercent">Discount (%)</form:label>
                                                    <form:input path="discountPercent" type="number" step="0.01"
                                                        cssClass="form-control" />
                                                </div>
                                                <div class="mb-3">
                                                    <form:label path="startDate">Start Date</form:label>
                                                    <form:input path="startDate" type="datetime-local"
                                                        cssClass="form-control" />
                                                </div>
                                                <div class="mb-3">
                                                    <form:label path="endDate">End Date</form:label>
                                                    <form:input path="endDate" type="datetime-local"
                                                        cssClass="form-control" />
                                                </div>
                                                <div class="mb-3">
                                                    <form:label path="product">Product</form:label>
                                                    <form:select path="product.id" cssClass="form-control">
                                                        <form:options items="${products}" itemValue="id"
                                                            itemLabel="name" />
                                                    </form:select>
                                                </div>

                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary"
                                                        data-bs-dismiss="modal">Close</button>
                                                    <button type="submit" class="btn btn-primary">Save Coupon</button>
                                                </div>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <!-- Modal Edit Coupon -->
                            <div class="modal fade" id="editCouponModal" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-lg modal-dialog-centered">
                                    <div class="modal-content">

                                        <!-- Header -->
                                        <div class="modal-header bg-warning text-white">
                                            <h5 class="modal-title">Chỉnh sửa Coupon</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Đóng"></button>
                                        </div>

                                        <!-- Form -->
                                        <form id="editCouponForm"
                                            action="${pageContext.request.contextPath}/vendor/event/update"
                                            method="post" class="p-3">
                                            <input type="hidden" name="id" />

                                            <!-- Hàng 1: Sản phẩm - Mã - Giảm -->
                                            <div class="row g-3 mb-3">
                                                <div class="col-md-4">
                                                    <label class="form-label">Sản phẩm</label>
                                                    <select name="product.id" class="form-select">
                                                        <c:forEach var="p" items="${products}">
                                                            <option value="${p.id}">${p.name}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>

                                                <div class="col-md-4">
                                                    <label class="form-label">Mã Coupon</label>
                                                    <input type="text" name="code" class="form-control"
                                                        placeholder="Nhập mã coupon" />
                                                </div>

                                                <div class="col-md-4">
                                                    <label class="form-label">Giảm (%)</label>
                                                    <input type="number" step="0.01" name="discountPercent"
                                                        class="form-control" placeholder="0.00" />
                                                </div>
                                            </div>

                                            <!-- Hàng 2: Ngày bắt đầu - Ngày kết thúc -->
                                            <div class="row g-3 mb-3">
                                                <div class="col-md-6">
                                                    <label class="form-label">Ngày bắt đầu</label>
                                                    <input type="datetime-local" name="startDate"
                                                        class="form-control" />
                                                </div>

                                                <div class="col-md-6">
                                                    <label class="form-label">Ngày kết thúc</label>
                                                    <input type="datetime-local" name="endDate" class="form-control" />
                                                </div>
                                            </div>

                                            <!-- Trạng thái ẩn -->
                                            <input type="hidden" name="status" />

                                            <!-- Footer -->
                                            <div class="modal-footer justify-content-center mt-3">
                                                <button type="button" class="btn btn-secondary"
                                                    data-bs-dismiss="modal">Hủy</button>
                                                <button type="submit" class="btn btn-warning">Cập nhật</button>
                                            </div>
                                        </form>

                                    </div>
                                </div>
                            </div>

                            <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header bg-danger text-white">
                                            <h5 class="modal-title">Xác nhận xóa</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                aria-label="Đóng"></button>
                                        </div>
                                        <div class="modal-body">
                                            Bạn có chắc chắn muốn xóa coupon này không?
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                data-bs-dismiss="modal">Hủy</button>
                                            <button type="button" class="btn btn-danger"
                                                id="confirmDeleteBtn">Xóa</button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- content-wrapper ends -->
                        <script
                            src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                        <script>
                            document.addEventListener('DOMContentLoaded', () => {
                                const filterGroup = document.getElementById('filter-group');
                                const allCoupons = document.querySelectorAll('.coupon-card'); // lấy thẳng coupon
                                const filterButtons = filterGroup.querySelectorAll('button');

                                // Hàm lọc coupon
                                const filterCoupons = (filter) => {
                                    allCoupons.forEach(coupon => {
                                        const status = coupon.getAttribute('data-status').toLowerCase(); // chuyển về lowercase
                                        if (filter === 'all' || status === filter.toLowerCase()) {
                                            coupon.parentElement.style.display = "block"; // hiện col chứa coupon
                                        } else {
                                            coupon.parentElement.style.display = "none"; // ẩn col chứa coupon
                                        }
                                    });
                                };

                                // Xử lý click nút filter
                                filterGroup.addEventListener('click', (event) => {
                                    let target = event.target;

                                    // Nếu click vào icon hoặc text bên trong button, lấy button cha
                                    if (target.tagName !== 'BUTTON') {
                                        target = target.closest('button');
                                    }

                                    if (target) {
                                        const filterValue = target.getAttribute('data-filter');

                                        // Reset class cho tất cả nút
                                        filterButtons.forEach(btn => {
                                            btn.classList.remove('active', 'btn-primary');
                                            btn.classList.add('btn-outline-primary');
                                        });

                                        // Set class nút được chọn
                                        target.classList.add('active', 'btn-primary');
                                        target.classList.remove('btn-outline-primary');

                                        // Thực hiện lọc
                                        filterCoupons(filterValue);
                                    }
                                });

                                // Hiển thị tất cả coupon ban đầu
                                filterCoupons('all');
                            });
                        </script>

                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                document.addEventListener('click', function (e) {
                                    const btn = e.target.closest('.edit-btn');
                                    if (!btn) return;

                                    const couponId = btn.dataset.id;
                                    if (!couponId) {
                                        console.error('Coupon ID không tìm thấy!');
                                        return;
                                    }

                                    fetch('${pageContext.request.contextPath}/vendor/event/get/' + couponId)

                                        .then(resp => {
                                            if (!resp.ok) throw new Error('Network response was not ok');
                                            return resp.json();
                                        })
                                        .then(data => {
                                            console.log('Voucher data:', data);

                                            const modal = document.getElementById('editCouponModal');
                                            if (!modal) return;

                                            // Gán giá trị cho các input
                                            modal.querySelector('input[name="id"]').value = data.id || '';
                                            modal.querySelector('input[name="code"]').value = data.code || '';
                                            modal.querySelector('input[name="discountPercent"]').value = data.discountPercent != null ? data.discountPercent : '';
                                            modal.querySelector('input[name="startDate"]').value = data.startDate ? data.startDate.substring(0, 16) : '';
                                            modal.querySelector('input[name="endDate"]').value = data.endDate ? data.endDate.substring(0, 16) : '';
                                            modal.querySelector('input[name="status"]').value = data.status || '';

                                            const productSelect = modal.querySelector('select[name="product.id"]');
                                            if (productSelect) {
                                                productSelect.value = data.product ? data.product.id : '';
                                            }

                                            // Hiển thị modal
                                            const bootstrapModal = new bootstrap.Modal(modal);
                                            bootstrapModal.show();
                                        })
                                        .catch(err => console.error('Fetch error:', err));
                                });
                            });

                        </script>

                        <script>
                            document.addEventListener('DOMContentLoaded', function () {
                                let couponIdToDelete = null; // lưu id coupon muốn xóa
                                const confirmModalEl = document.getElementById('confirmDeleteModal');
                                const confirmModal = new bootstrap.Modal(confirmModalEl);
                                const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');

                                // Bắt sự kiện click nút delete
                                document.addEventListener('click', function (e) {
                                    const btn = e.target.closest('.del-btn');
                                    if (!btn) return;

                                    couponIdToDelete = btn.dataset.id; // lấy id coupon
                                    confirmModal.show(); // hiện modal xác nhận
                                });

                                // Khi bấm Xóa trong modal
                                confirmDeleteBtn.addEventListener('click', function () {
                                    if (!couponIdToDelete) return;

                                    fetch('${pageContext.request.contextPath}/vendor/event/delete/' + couponIdToDelete, {
                                        method: 'DELETE'
                                    })
                                        .then(resp => {
                                            if (!resp.ok) throw new Error('Xóa thất bại');
                                            // redirect về trang event sau khi xóa
                                            window.location.href = '${pageContext.request.contextPath}/vendor/event';
                                        })
                                        .catch(err => {
                                            console.error(err);
                                            alert('Xóa thất bại, thử lại!');
                                        })
                                        .finally(() => {
                                            couponIdToDelete = null;
                                        });
                                });
                            });
                        </script>
                    </div>