<div class="main-panel">
    <div class="modal fade" id="filterModal" tabindex="-1" role="dialog" aria-labelledby="filterModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="filterModalLabel">Orders Filter</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="orderFilterForm">
                        <div class="form-group">
                            <label for="filterUpdatedFrom">Updated Date</label>
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <small class="form-text text-muted">From:</small>
                                    <input type="date" class="form-control" id="filterUpdatedFrom">
                                </div>
                                <div class="col-md-6 mb-2">
                                    <small class="form-text text-muted">To:</small>
                                    <input type="date" class="form-control" id="filterUpdatedTo">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="filterCreatedFrom">Created Date</label>
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <small class="form-text text-muted">From:</small>
                                    <input type="date" class="form-control" id="filterCreatedFrom">
                                </div>
                                <div class="col-md-6 mb-2">
                                    <small class="form-text text-muted">To:</small>
                                    <input type="date" class="form-control" id="filterCreatedTo">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="filterStatus">Status</label>
                            <select class="form-control" id="filterStatus">
                                <option value="">-- All status --</option>
                                <option value="Pending">Pending</option>
                                <option value="In progress">In progress</option>
                                <option value="Shipped">Shipped</option>
                                <option value="Completed">Completed</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="filterPaymentMethod">Payment menthods</label>
                            <select class="form-control" id="filterPaymentMethod">
                                <option value="">-- All menthods --</option>
                                <option value="Credit Card">Credit Card</option>
                                <option value="Cash on Delivery">Cash on Delivery</option>
                                <option value="PayPal">PayPal</option>
                                <option value="Bank Transfer">Bank Transfer</option>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" onclick="clearFilters()">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="applyFilters()">Apply filter</button>
                </div>
            </div>
        </div>
    </div>
    <div class="content-wrapper">
        <div class="row align-items-center mb-4">
            <div class="col-6">
                <h2 class="mb-0">Orders</h2>
            </div>
            <div class="col-6 text-right">

                <button type="button" class="btn btn-outline-primary btn-sm mx-1" onclick="location.reload()">
                    <i class="fa-solid fa-rotate-right mr-1"></i> <span>Refresh</span>
                </button>
                <!-- Nút filter -->
                <button type="button" class="btn btn-outline-secondary btn-sm mx-1" data-toggle="modal"
                    data-target="#filterModal">
                    <i class="fa-solid fa-filter mr-1"></i> <span>Filter</span>
                </button>

                <!-- Nút export -->
                <button type="button" class="btn btn-outline-info btn-sm mx-1">
                    <i class="fa-solid fa-download mr-1"></i> <span>Export</span>
                </button>

            </div>


        </div>
        <div class="modal fade" id="orderDetailModal" tabindex="-1" role="dialog"
            aria-labelledby="orderDetailModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="orderDetailModalLabel">Chi tiết đơn hàng: <span
                                id="modalOrderId">#ORD-8931</span></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>Sản phẩm</th>
                                        <th>Số lượng</th>
                                        <th>Đơn giá</th>
                                        <th>Thành tiền</th>
                                    </tr>
                                </thead>
                                <tbody id="orderDetailContent">
                                    <tr>
                                        <td>Áo thun Cotton</td>
                                        <td>2</td>
                                        <td>250.000 VNĐ</td>
                                        <td>500.000 VNĐ</td>
                                    </tr>
                                    <tr>
                                        <td>Quần Jean Slim Fit</td>
                                        <td>1</td>
                                        <td>600.000 VNĐ</td>
                                        <td>600.000 VNĐ</td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" class="text-right font-weight-bold">Tổng cộng:</td>
                                        <td class="font-weight-bold">1.100.000 VNĐ</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <p class="mt-3"><strong>Địa chỉ giao hàng:</strong> 123 Đường ABC, Quận 1, TP. HCM</p>
                        <p><strong>Ghi chú:</strong> Vui lòng giao vào buổi chiều.</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                        <button type="button" class="btn btn-primary">Xác nhận</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <p></p>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Order ID</th>
                                        <th>Created</th>
                                        <th>Updated</th>
                                        <th>Payment Method</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            <a href="#" data-toggle="modal"
                                                data-target="#orderDetailModal">#ORD-8931</a>
                                        </td>
                                        <td>12 May 2024</td>
                                        <td>12 May 2024</td>
                                        <td>Credit Card</td>
                                        <td><label class="badge badge-danger">Pending</label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="#" data-toggle="modal"
                                                data-target="#orderDetailModal">#ORD-8932</a>
                                        </td>
                                        <td>15 May 2024</td>
                                        <td>16 May 2024</td>
                                        <td>Cash on Delivery</td>
                                        <td><label class="badge badge-warning">In progress</label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="#" data-toggle="modal"
                                                data-target="#orderDetailModal">#ORD-8933</a>
                                        </td>
                                        <td>14 May 2024</td>
                                        <td>14 May 2024</td>
                                        <td>PayPal</td>
                                        <td><label class="badge badge-info">Shipped</label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="#" data-toggle="modal"
                                                data-target="#orderDetailModal">#ORD-8934</a>
                                        </td>
                                        <td>16 May 2024</td>
                                        <td>17 May 2024</td>
                                        <td>Bank Transfer</td>
                                        <td><label class="badge badge-success">Completed</label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <a href="#" data-toggle="modal"
                                                data-target="#orderDetailModal">#ORD-8935</a>
                                        </td>
                                        <td>20 May 2024</td>
                                        <td>20 May 2024</td>
                                        <td>Credit Card</td>
                                        <td><label class="badge badge-warning">In progress</label></td>
                                    </tr>
                                </tbody>
                            </table>

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