<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <style>
                table th {
                    white-space: nowrap;
                }

                table td:nth-child(2) {
                    max-width: 300px;
                    overflow: hidden;
                    text-overflow: ellipsis;
                }
            </style>
            <div class="main-panel">
                <div class="content-wrapper">
                    <div class="row align-items-center mb-4">
                        <div class="col-6">
                            <h2 class="mb-0">Admin Product</h2>
                        </div>
                        <style>
                            /* Cho input và nút tìm kiếm cùng chiều cao */
                            .search-group .form-control,
                            .search-group .btn {
                                height: 32px;
                                font-size: 0.875rem;
                            }

                            /* Bo góc mềm mại */
                            .search-group .form-control {
                                border-top-left-radius: 4px;
                                border-bottom-left-radius: 4px;
                            }

                            .search-group .btn {
                                border-top-right-radius: 4px;
                                border-bottom-right-radius: 4px;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                            }

                            .search-group .btn i {
                                line-height: 1;
                            }
                        </style>

                        <div class="col-6 text-right d-flex justify-content-end align-items-center">
                            <div class="input-group search-group" style="width: 250px; margin-right: 8px;">
                                <input type="text" class="form-control" placeholder="Tìm kiếm cửa hàng..."
                                    id="searchShop">
                                <div class="input-group-append">
                                    <button class="btn btn-outline-secondary" type="button" id="btnSearch">
                                        <i class="fa-solid fa-magnifying-glass"></i>
                                    </button>
                                </div>
                            </div>

                            <button type="button" class="btn btn-outline-primary btn-sm mx-1"
                                onclick="location.reload()">
                                <i class="fa-solid fa-rotate-right mr-1"></i> <span>Refresh</span>
                            </button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12 grid-margin stretch-card">
                            <div class="card">
                                <div class="card-body">
                                    <p></p>
                                    <div class="table-responsive">
                                        <style>
                                            table th {
                                                white-space: nowrap;
                                                vertical-align: middle !important;
                                            }

                                            table td {
                                                vertical-align: middle !important;
                                            }

                                            /* Cho phép xuống dòng tự nhiên, không bị cắt chữ */
                                            table td:nth-child(2) {
                                                max-width: 350px;
                                                white-space: normal;
                                                word-wrap: break-word;
                                            }

                                            /* Canh giữa cột Action */
                                            table th:last-child,
                                            table td:last-child {
                                                text-align: center;
                                            }

                                            /* Link View màu xanh, căn giữa biểu tượng và chữ */
                                            .nav-link.text-primary {
                                                color: #007bff !important;
                                                display: inline-flex;
                                                align-items: center;
                                                justify-content: center;
                                                gap: 4px;
                                                text-decoration: none;
                                                font-weight: 500;
                                            }

                                            .nav-link.text-primary:hover {
                                                text-decoration: underline;
                                            }

                                            /* Cải thiện khoảng cách hàng cho đều */
                                            table.table tbody tr {
                                                height: 55px;
                                            }
                                        </style>

                                        <table class="table">
                                            <thead>
                                                <tr>
                                                    <th>Shop Name</th>
                                                    <th>Description</th>
                                                    <th>Created At</th>
                                                    <th>Status</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>Urban Style Boutique</td>
                                                    <td>Cửa hàng thời trang phong cách đường phố hiện đại, chuyên áo
                                                        phông, hoodie
                                                        và quần jeans unisex.</td>
                                                    <td>09 Oct 2025</td>
                                                    <td><label class="badge badge-success">Active</label></td>
                                                    <td>
                                                        <a href="/admin/product/detail" class="nav-link text-primary">
                                                            <i class="typcn typcn-eye menu-icon"></i> View
                                                        </a>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>Vintage Corner</td>
                                                    <td>Chuyên các mẫu quần áo cổ điển và phụ kiện mang hơi hướng retro
                                                        cho cả nam
                                                        và nữ.</td>
                                                    <td>07 Oct 2025</td>
                                                    <td><label class="badge badge-info">Pending</label></td>
                                                    <td>
                                                        <a href="/admin/product/detail" class="nav-link text-primary">
                                                            <i class="typcn typcn-eye menu-icon"></i> View
                                                        </a>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>Men’s Wear House</td>
                                                    <td>Cửa hàng thời trang nam cao cấp, cung cấp vest, áo sơ mi và quần
                                                        tây thiết
                                                        kế sang trọng.</td>
                                                    <td>05 Oct 2025</td>
                                                    <td><label class="badge badge-success">Active</label></td>
                                                    <td>
                                                        <a href="/admin/product/detail" class="nav-link text-primary">
                                                            <i class="typcn typcn-eye menu-icon"></i> View
                                                        </a>
                                                    </td>
                                                </tr>

                                                <tr>
                                                    <td>Elegant Lady</td>
                                                    <td>Thương hiệu thời trang nữ thanh lịch, chuyên váy dạ hội, đầm
                                                        công sở và phụ
                                                        kiện cao cấp.</td>
                                                    <td>02 Oct 2025</td>
                                                    <td><label class="badge badge-success">Active</label></td>
                                                    <td>
                                                        <a href="/admin/product/detail" class="nav-link text-primary">
                                                            <i class="typcn typcn-eye menu-icon"></i> View
                                                        </a>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <!-- main-panel ends -->
                        </div>
                        <!-- page-body-wrapper ends -->
                    </div>
                    <!-- container-scroller -->
                    <!-- base:js -->
                    <script src="/admin/vendors/js/vendor.bundle.base.js"></script>
                    <!-- endinject -->
                    <!-- Plugin js for this page-->
                    <!-- End plugin js for this page-->
                    <!-- inject:js -->
                    <script src="/admin/js/off-canvas.js"></script>
                    <script src="/admin/js/hoverable-collapse.js"></script>
                    <script src="/admin/js/template.js"></script>
                    <!-- <script src="js/settings.js"></script> -->
                    <script src="/admin/js/todolist.js"></script>
                    <!-- endinject -->
                    <!-- plugin js for this page -->
                    <!-- End plugin js for this page -->
                    <!-- Custom js for this page-->
                    <!-- End custom js for this page-->
                    <!-- Code injected by live-server -->
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



                </div>
            </div>