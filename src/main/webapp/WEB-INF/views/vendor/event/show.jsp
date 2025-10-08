<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <style>
                .promo-container {
                    padding: 30px;
                    max-width: 1200px;
                    margin: 0 auto;
                }

                /* Header Styling */
                .header-section h1 {
                    font-weight: 700;
                    margin-bottom: 5px;
                }

                .header-section p {
                    font-size: 1.1rem;
                }

                /* Card Styling */
                .promo-card {
                    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                    border-radius: 8px;
                    border: none;
                }

                .promo-card .card-title {
                    font-weight: 600;
                    margin-bottom: 20px;
                }

                /* Common Text Styling */
                .promo-title {
                    font-weight: 600;
                    margin-bottom: 2px;
                    color: #333;
                }

                .promo-subtitle,
                .promo-date {
                    font-size: 0.6rem;
                    color: #888;
                    margin-bottom: 0;
                    line-height: 1.4;
                }

                .promo-collection {
                    font-size: 0.9rem;
                    font-weight: 500;
                    margin-bottom: 3px;
                    color: #555;
                }

                /* Badge/Tag Styling */
                .promo-badge {
                    padding: 4px 8px;
                    border-radius: 4px;
                    font-size: 0.75rem;
                    font-weight: 500;
                }

                /* Specific styling for the 'Expired' badge */
                .promo-badge.expired {
                    background-color: #fcebeb;
                    color: #d9534f;
                    margin-bottom: 10px;
                }

                /* Column 3: Quantity Promo specific styling */
                .quantity-card {
                    background-color: #fcfcfc;
                    border: 1px solid #f0f0f0;
                }

                .quantity-sales {
                    font-weight: 600;
                    font-size: 0.95rem;
                    white-space: nowrap;
                }

                .see-details-link {
                    font-size: 0.9rem;
                    color: #555;
                    text-decoration: none;
                    font-weight: 500;
                }

                .see-details-link:hover {
                    color: #007bff;
                }


                /* --- CSS for Nested Tables --- */

                .promo-main-table {
                    width: 100%;
                    margin-bottom: 0;
                    border-collapse: collapse;
                }

                .promo-main-table tbody tr {
                    border: none !important;
                    margin-bottom: 10px;
                }

                .promo-main-table td {
                    padding-bottom: 10px !important;
                }

                .promo-main-table tbody tr.last-row {
                    border-bottom: none;

                }

                /* Bảng con (Nested Table) */
                .promo-nested-table {
                    width: 100%;
                    margin: 0;
                    padding: 15px 0;
                    border-top: none !important;
                }

                .promo-main-table tbody tr:first-child .promo-nested-table {
                    padding-top: 0;
                }

                .promo-main-table tbody tr.last-row .promo-nested-table {
                    padding-bottom: 0;
                }

                .promo-nested-table tr,
                .promo-nested-table td {
                    border: none !important;
                    padding: 0 !important;
                }

                .promo-detail-col {
                    width: 70%;
                }

                .promo-value-col {
                    width: 30%;
                    text-align: right;
                    vertical-align: top;
                    white-space: nowrap;
                }

                .promo-main-title {
                    font-weight: 600;
                    font-size: 0.9rem;
                    color: #333;
                    margin-bottom: 2px;
                }

                .promo-collection {
                    font-size: inherit;
                    font-weight: 600;
                    color: #333;
                    margin-bottom: 3px;
                }

                @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap');

                /* --- GLOBAL & CONTAINER (Giữ nguyên) --- */
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                    font-family: 'poppins', sans-serif;
                }

                .container {
                    width: 100%;
                    height: 100vh;
                    /* Thay đổi nền container để phù hợp với nền ảnh gốc */
                    background: #f0f0f0;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .coupon-card {
                    background: #396afc;
                    color: #fff;
                    text-align: left;
                    padding: 15px 20px;
                    border-radius: 8px;
                    box-shadow: 0 10px 10px 0 rgba(0, 0, 0, 0.15);
                    position: relative;
                }

                .logo,
                .coupon-row {
                    display: none;
                }

                .coupon-card-expired {
                    background: #dc3545 !important;
                }

                .coupon-card-expired .public-badge {
                    color: #dc3545 !important;
                }

                .coupon-card-private {
                    background: #ffaa00 !important;
                }

                .coupon-card-private .public-badge {
                    color: #ffaa00 !important;
                }


                .coupon-card-expired .divider {
                    background: rgba(255, 255, 255, 0.3);
                }

                /* --- TEXT STYLES --- */
                .coupon-card .method {
                    font-size: 13px;
                    font-weight: 400;
                    color: rgba(255, 255, 255);
                    margin-bottom: 10px;

                    background: rgba(0, 0, 0, 0.2);
                    padding: 3px 8px;
                    border-radius: 4px;
                    display: inline-block;
                    line-height: normal;
                }

                .coupon-card .promo-title {
                    /* "Buy 2 Get 1" */
                    color: rgba(255, 255, 255);
                    font-size: 25px;
                    font-weight: 600;
                    line-height: 30px;
                    margin-bottom: 3px;
                }

                .coupon-card .description {
                    font-size: 11px;
                    font-weight: 300;
                    margin-bottom: 15px;
                }

                /* --- DIVIDER (Đường kẻ ngang) --- */
                .divider {
                    height: 1px;
                    background: rgba(255, 255, 255, 0.4);
                    margin: 20px 0;
                }

                .divider.title {
                    height: 1px;
                    background: rgba(0, 0, 0);
                    margin: 20px 0;
                }

                /* --- FOOTER (Ngày hết hạn và Public) --- */
                .footer-row {
                    display: flex;
                    justify-content: space-between;
                    /* Đẩy ngày sang trái, Public sang phải */
                    align-items: center;
                }

                .coupon-card .valid-date {
                    font-size: 13px;
                    font-weight: 500;
                    margin-bottom: 0;
                    /* Loại bỏ margin-bottom mặc định của thẻ p */
                }

                .coupon-card .public-badge {
                    background: #fff;
                    color: #396afc;
                    padding: 4px 12px;
                    border-radius: 4px;
                    font-size: 14px;
                    font-weight: 600;
                }

                .circle1,
                .circle2 {
                    background: #fff;
                    width: 25px;
                    height: 25px;
                    border-radius: 50%;
                    position: absolute;
                    top: 50%;
                    transform: translateY(-50%);
                }

                .circle1 {
                    left: -12.5px;
                }

                .circle2 {
                    right: -12.5px;
                }

                #filter-group .btn.show {
                    outline: none !important;
                    box-shadow: none !important;
                }
            </style>
            <div class="main-panel">

                <div class="content-wrapper">

                    <div class="header-section mb-3">
                        <h1>Promo</h1>
                        <p class="text-muted">Up your sales with exclusive promo</p>
                    </div>

                    <div class="row gx-0">
                        <div class="col-lg-4 col-md-6 mb-5 px-1">
                            <div class="card promo-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-3">

                                        <h5 class="card-title mb-0">Promo Progress</h5>
                                        <span class="card-title mb-0">
                                            3
                                        </span>
                                    </div>

                                    <div class="divider title"></div>

                                    <table class="table promo-main-table border-0">
                                        <tbody>
                                            <tr>
                                                <td colspan="2" class="p-0 border-0 mb-4 mt-4">
                                                    <table class="table promo-nested-table border-0">
                                                        <tbody>
                                                            <tr>
                                                                <td class="promo-detail-col">
                                                                    <p class="promo-main-title mb-0">Buy 2 Get 1</p>
                                                                    <p class="promo-subtitle mb-1">Via Barcode Code</p>
                                                                    <p class="promo-date mb-0">Expired date 23 April
                                                                        2024</p>
                                                                </td>
                                                                <td class="text-right promo-value-col">
                                                                    <p class="promo-main-title mb-1">Men Collection</p>
                                                                    <span
                                                                        class="badge badge-success promo-badge">Public</span>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2" class="p-0 border-0 mb-4 mt-4">
                                                    <table class="table promo-nested-table border-0">
                                                        <tbody>
                                                            <tr>
                                                                <td class="promo-detail-col">
                                                                    <p class="promo-main-title mb-0">Discount 20%</p>
                                                                    <p class="promo-subtitle mb-1">Via Barcode Code</p>
                                                                    <p class="promo-date mb-0">Expired date 23 April
                                                                        2024</p>
                                                                </td>
                                                                <td class="text-right promo-value-col">
                                                                    <p class="promo-main-title mb-1">Women Collection
                                                                    </p>
                                                                    <span
                                                                        class="badge badge-success promo-badge">Public</span>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>

                                            <tr class="last-row">
                                                <td colspan="2" class="p-0 border-0 mb-4 mt-4">
                                                    <table class="table promo-nested-table border-0">
                                                        <tbody>
                                                            <tr>
                                                                <td class="promo-detail-col">
                                                                    <p class="promo-main-title">Discount 15%</p>
                                                                    <p class="promo-subtitle mb-1">Via Credit Card</p>
                                                                    <p class="promo-date mb-0">Expired date 29 April
                                                                        2024</p>
                                                                </td>
                                                                <td class="text-right promo-value-col">
                                                                    <p class="promo-main-title mb-1">All Product</p>
                                                                    <span
                                                                        class="badge badge-success promo-badge">Public</span>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-6 mb-5 px-1">
                            <div class="card promo-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-3">

                                        <h5 class="card-title mb-0">Promo Expired</h5>
                                        <span class="card-title mb-0">
                                            3
                                        </span>
                                    </div>
                                    <div class="divider title"></div>

                                    <table class="table promo-main-table border-0">
                                        <tbody>
                                            <tr>
                                                <td colspan="2" class="p-0 border-0 mb-4 mt-4">
                                                    <table class="table promo-nested-table border-0">
                                                        <tbody>
                                                            <tr>
                                                                <td class="promo-detail-col border-0">
                                                                    <p class="promo-main-title mb-0">Discount 40%</p>
                                                                    <p class="promo-subtitle mb-1">Via Barcode Code</p>

                                                                </td>
                                                                <td class="text-right promo-value-col border-0">
                                                                    <p class="promo-main-title mb-1">Kids Collection</p>
                                                                    <span
                                                                        class="badge badge-danger promo-badge expired">Expired</span>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2" class="p-0 border-0 mb-4 mt-4">
                                                    <table class="table promo-nested-table border-0">
                                                        <tbody>
                                                            <tr>
                                                                <td class="promo-detail-col border-0">
                                                                    <p class="promo-main-title mb-0">Discount 25%</p>
                                                                    <p class="promo-subtitle mb-1">Via Barcode Code</p>
                                                                </td>
                                                                <td class="text-right promo-value-col border-0">
                                                                    <p class="promo-main-title mb-1">Women Collection
                                                                    </p>
                                                                    <span
                                                                        class="badge badge-danger promo-badge expired">Expired</span>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>

                                            <tr class="last-row">
                                                <td colspan="2" class="p-0 border-0 mb-4 mt-4">
                                                    <table class="table promo-nested-table border-0">
                                                        <tbody>
                                                            <tr>
                                                                <td class="promo-detail-col border-0">
                                                                    <p class="promo-main-title mb-0">Discount 15%</p>
                                                                    <p class="promo-subtitle mb-1">Via Debit Card</p>
                                                                </td>
                                                                <td class="text-right promo-value-col border-0">
                                                                    <p class="promo-main-title mb-1">All Product</p>
                                                                    <span
                                                                        class="badge badge-danger promo-badge expired">Expired</span>
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>

                        <div class="col-lg-4 col-md-12 mb-5 px-1">
                            <div class="card promo-card quantity-card">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5 class="card-title mb-0">Quantity Promo</h5>
                                        <small class="text-muted">Updated Today</small>
                                    </div>
                                    <div class="divider title"></div>

                                    <table class="table promo-main-table quantity-main-table border-0">
                                        <tbody>
                                            <tr>
                                                <td colspan="2" class="p-0 border-0 mb-4 mt-4">
                                                    <table class="table promo-nested-table border-0">
                                                        <tbody>
                                                            <tr>
                                                                <td class="promo-detail-col border-0">
                                                                    <p class="promo-main-title mb-0">Buy 2 Get 1</p>
                                                                    <p class="promo-date mb-0">Expired date 23 April
                                                                        2024</p>
                                                                </td>
                                                                <td
                                                                    class="text-right promo-value-col quantity-sales text-success border-0">
                                                                    <i class="mdi mdi-arrow-top-right"></i> +100 Sales
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2" class="p-0 border-0 mb-4 mt-4">
                                                    <table class="table promo-nested-table">
                                                        <tbody>
                                                            <tr>
                                                                <td class="promo-detail-col">
                                                                    <p class="promo-main-title mb-0">Discount 20%</p>
                                                                    <p class="promo-date mb-0">Expired date 23 April
                                                                        2024</p>
                                                                </td>
                                                                <td
                                                                    class="text-right promo-value-col quantity-sales text-success">
                                                                    <i class="mdi mdi-arrow-top-right"></i> +55 Sales
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>

                                            <tr class="last-row">
                                                <td colspan="2" class="p-0 border-0 mb-4 mt-4">
                                                    <table class="table promo-nested-table mb-4">
                                                        <tbody>
                                                            <tr>
                                                                <td class="promo-detail-col">
                                                                    <p class="promo-main-title mb-0">Discount 15%</p>
                                                                    <p class="promo-date mb-0">Expired date 29 April
                                                                        2024</p>
                                                                </td>
                                                                <td
                                                                    class="text-right promo-value-col quantity-sales text-success">
                                                                    <i class="mdi mdi-arrow-top-right"></i> +124 Sales
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>

                                    <div class="text-center mt-3">
                                        <a href="#" class="see-details-link">
                                            See Details <i class="mdi mdi-chevron-down"></i>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h1 class="fw-bold fs-3 mb-0">Promo Manage</h1>
                        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#newCouponModal">
                            <i class="fa-solid fa-plus"></i> Add Coupon
                        </button>
                    </div>

                    <div class="row">
                        <div class="col-lg-12 col-md-12 mb-5 px-1">
                            <div class="card promo-card">
                                <div class="card-body">

                                    <!-- Nút lọc -->
                                    <div class="btn-group mb-4" role="group" id="filter-group">
                                        <button type="button" class="btn btn-sm btn-primary active"
                                            data-filter="all">All
                                            Promos</button>
                                        <button type="button" class="btn btn-sm btn-outline-primary"
                                            data-filter="public">Public</button>
                                        <button type="button" class="btn btn-sm btn-outline-primary"
                                            data-filter="private">Private</button>
                                        <button type="button" class="btn btn-sm btn-outline-primary"
                                            data-filter="expired">Expired</button>
                                    </div>

                                    <!-- Coupon list -->
                                    <div class="row">

                                        <!-- Private -->
                                        <div class="col-12 col-md-4 mb-5 px-2" style="display: block;">
                                            <div class="coupon-card coupon-card-private" data-status="private">

                                                <div class="action-btns">
                                                    <button class="edit-btn edit private"><i
                                                            class="fa-solid fa-pen"></i></button>
                                                    <button class="del-btn delete private"><i
                                                            class="fa-solid fa-trash"></i></button>
                                                </div>

                                                <p class="method">Via Mobile App</p>


                                                <h3 class="promo-title">Discount 12%</h3>
                                                <p class="description">Exclusive for Mobile Orders</p>
                                                <div class="divider"></div>
                                                <div class="footer-row">
                                                    <p class="valid-date">Valid Until 05 May 2024</p>
                                                    <span class="badge public-badge">Private</span>
                                                </div>
                                                <div class="circle1"></div>
                                                <div class="circle2"></div>
                                            </div>
                                        </div>

                                        <!-- Public -->
                                        <div class="col-12 col-md-4 mb-5 px-2" style="display: block;">
                                            <div class="coupon-card full-coupon-card coupon-card-public"
                                                data-status="public">
                                                <p class="method">Via Barcode Scan</p>

                                                <div class="action-btns">
                                                    <button class="edit-btn edit public"><i
                                                            class="fa-solid fa-pen"></i></button>
                                                    <button class="del-btn delete public"><i
                                                            class="fa-solid fa-trash"></i></button>
                                                </div>


                                                <h3 class="promo-title">Buy 1 Get 1 Free</h3>
                                                <p class="description">Applicable on Coffee &amp; Tea Menu</p>
                                                <div class="divider"></div>
                                                <div class="footer-row">
                                                    <p class="valid-date">Valid Until 15 April 2024</p>
                                                    <span class="badge public-badge"
                                                        style="color: #396afc;">Public</span>
                                                </div>
                                                <div class="circle1"></div>
                                                <div class="circle2"></div>
                                            </div>
                                        </div>

                                        <!-- Expired -->
                                        <div class="col-12 col-md-4 mb-5 px-2" style="display: block;">
                                            <div class="coupon-card coupon-card-expired" data-status="expired">
                                                <p class="method">Via Membership Card</p>

                                                <div class="action-btns">
                                                    <button class="edit-btn edit expired"><i
                                                            class="fa-solid fa-pen"></i></button>
                                                    <button class="del-btn delete expired"><i
                                                            class="fa-solid fa-trash"></i></button>
                                                </div>


                                                <h3 class="promo-title">Discount 30%</h3>
                                                <p class="description">For Premium Members</p>
                                                <div class="divider"></div>
                                                <div class="footer-row">
                                                    <p class="valid-date">Expired on 10 March 2024</p>
                                                    <span class="badge public-badge">Expired</span>
                                                </div>
                                                <div class="circle1"></div>
                                                <div class="circle2"></div>
                                            </div>
                                        </div>

                                        <!-- Public -->
                                        <div class="col-12 col-md-4 mb-5 px-2" style="display: block;">
                                            <div class="coupon-card full-coupon-card coupon-card-public"
                                                data-status="public">
                                                <p class="method">Via Online Payment</p>

                                                <div class="action-btns">
                                                    <button class="edit-btn edit public"><i
                                                            class="fa-solid fa-pen"></i></button>
                                                    <button class="del-btn delete public"><i
                                                            class="fa-solid fa-trash"></i></button>
                                                </div>


                                                <h3 class="promo-title">Discount 18%</h3>
                                                <p class="description">Valid for All Online Orders</p>
                                                <div class="divider"></div>
                                                <div class="footer-row">
                                                    <p class="valid-date">Valid Until 22 April 2024</p>
                                                    <span class="badge public-badge"
                                                        style="color: #396afc;">Public</span>
                                                </div>
                                                <div class="circle1"></div>
                                                <div class="circle2"></div>
                                            </div>
                                        </div>

                                        <!-- Private -->
                                        <div class="col-12 col-md-4 mb-5 px-2" style="display: block;">
                                            <div class="coupon-card coupon-card-private" data-status="private">
                                                <p class="method">Via Gift Voucher</p>

                                                <div class="action-btns">
                                                    <button class="edit-btn edit private"><i
                                                            class="fa-solid fa-pen"></i></button>
                                                    <button class="del-btn delete private"><i
                                                            class="fa-solid fa-trash"></i></button>
                                                </div>


                                                <h3 class="promo-title">Discount 50,000đ</h3>
                                                <p class="description">On Orders Over 300,000đ</p>
                                                <div class="divider"></div>
                                                <div class="footer-row">
                                                    <p class="valid-date">Valid Until 12 May 2024</p>
                                                    <span class="badge public-badge">Private</span>
                                                </div>
                                                <div class="circle1"></div>
                                                <div class="circle2"></div>
                                            </div>
                                        </div>

                                        <!-- Expired -->
                                        <div class="col-12 col-md-4 mb-5 px-2" style="display: block;">
                                            <div class="coupon-card coupon-card-expired" data-status="expired">
                                                <p class="method">Via Promo Code</p>

                                                <div class="action-btns">
                                                    <button class="edit-btn edit expired"><i
                                                            class="fa-solid fa-pen"></i></button>
                                                    <button class="del-btn delete expired"><i
                                                            class="fa-solid fa-trash"></i></button>
                                                </div>


                                                <h3 class="promo-title">Free Shipping</h3>
                                                <p class="description">Applicable for Orders Above 200,000đ</p>
                                                <div class="divider"></div>
                                                <div class="footer-row">
                                                    <p class="valid-date">Expired on 01 May 2024</p>
                                                    <span class="badge public-badge">Expired</span>
                                                </div>
                                                <div class="circle1"></div>
                                                <div class="circle2"></div>
                                            </div>
                                        </div>

                                        <!-- Public -->
                                        <div class="col-12 col-md-4 mb-5 px-2" style="display: block;">
                                            <div class="coupon-card full-coupon-card coupon-card-public"
                                                data-status="public">
                                                <p class="method">Via Student ID</p>

                                                <div class="action-btns">
                                                    <button class="edit-btn edit public"><i
                                                            class="fa-solid fa-pen"></i></button>
                                                    <button class="del-btn delete public"><i
                                                            class="fa-solid fa-trash"></i></button>
                                                </div>


                                                <h3 class="promo-title">Discount 25%</h3>
                                                <p class="description">For All Students Nationwide</p>
                                                <div class="divider"></div>
                                                <div class="footer-row">
                                                    <p class="valid-date">Valid Until 30 April 2024</p>
                                                    <span class="badge public-badge"
                                                        style="color: #396afc;">Public</span>
                                                </div>
                                                <div class="circle1"></div>
                                                <div class="circle2"></div>
                                            </div>
                                        </div>

                                        <!-- Expired -->
                                        <div class="col-12 col-md-4 mb-5 px-2" style="display: block;">
                                            <div class="coupon-card coupon-card-expired" data-status="expired">
                                                <p class="method">Via Store Pickup</p>

                                                <div class="action-btns">
                                                    <button class="edit-btn edit expired"><i
                                                            class="fa-solid fa-pen"></i></button>
                                                    <button class="del-btn delete expired"><i
                                                            class="fa-solid fa-trash"></i></button>
                                                </div>

                                                <h3 class="promo-title">Discount 20%</h3>
                                                <p class="description">Only for In-Store Payments</p>
                                                <div class="divider"></div>
                                                <div class="footer-row">
                                                    <p class="valid-date">Expired on 18 March 2024</p>
                                                    <span class="badge public-badge">Expired</span>
                                                </div>
                                                <div class="circle1"></div>
                                                <div class="circle2"></div>
                                            </div>
                                        </div>

                                        <!-- Private -->
                                        <div class="col-12 col-md-4 mb-5 px-2" style="display: block;">
                                            <div class="coupon-card coupon-card-private" data-status="private">
                                                <p class="method">Via Corporate Account</p>

                                                <div class="action-btns">
                                                    <button class="edit-btn edit private"><i
                                                            class="fa-solid fa-pen"></i></button>
                                                    <button class="del-btn delete private"><i
                                                            class="fa-solid fa-trash"></i></button>
                                                </div>
                                                <h3 class="promo-title">Discount 22%</h3>
                                                <p class="description">Exclusive for Business Clients</p>
                                                <div class="divider"></div>
                                                <div class="footer-row">
                                                    <p class="valid-date">Valid Until 20 June 2024</p>
                                                    <span class="badge public-badge">Private</span>
                                                </div>
                                                <div class="circle1"></div>
                                                <div class="circle2"></div>
                                            </div>
                                        </div>

                                    </div> <!-- end .row -->


                                </div>
                            </div>
                        </div>
                    </div>


                </div>
                <!-- content-wrapper ends -->
            </div>