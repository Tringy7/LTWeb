<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
  table th {
    white-space: nowrap;
  }

  table td:nth-child(2) {
    max-width: 200px;
    overflow: hidden;
    text-overflow: ellipsis;
  }
</style>
<div class="main-panel">
  <div class="content-wrapper">
    <div class="row align-items-center mb-4">
      <div class="col-6">
        <h2 class="mb-0">Admin Orders</h2>
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

      <div
        class="col-6 text-right d-flex justify-content-end align-items-center"
      >
        <div
          class="input-group search-group"
          style="width: 250px; margin-right: 8px"
        >
          <input
            type="text"
            class="form-control"
            placeholder="Tìm kiếm đơn hàng..."
            id="searchOrder"
          />
          <div class="input-group-append">
            <button
              class="btn btn-outline-secondary"
              type="button"
              id="btnSearch"
            >
              <i class="fa-solid fa-magnifying-glass"></i>
            </button>
          </div>
        </div>

        <button
          type="button"
          class="btn btn-outline-primary btn-sm mx-1"
          onclick="location.reload()"
        >
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
                  max-width: 150px;
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

                /* Style cho badge status */
                .badge-pending {
                  background-color: #ffc107;
                  color: #000;
                }

                .badge-processing {
                  background-color: #17a2b8;
                  color: #fff;
                }

                .badge-shipped {
                  background-color: #6f42c1;
                  color: #fff;
                }

                .badge-delivered {
                  background-color: #28a745;
                  color: #fff;
                }

                .badge-cancelled {
                  background-color: #dc3545;
                  color: #fff;
                }
              </style>

              <table class="table">
                <thead>
                  <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Order Date</th>
                    <th>Total Amount</th>
                    <th>Payment Method</th>
                    <th>Status</th>
                    <th>Action</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td>#ORD001</td>
                    <td>Nguyễn Văn An</td>
                    <td>09 Oct 2025</td>
                    <td>1,450,000₫</td>
                    <td>Credit Card</td>
                    <td>
                      <label class="badge badge-delivered">Delivered</label>
                    </td>
                    <td>
                      <a
                        href="/admin/order/detail"
                        class="nav-link text-primary"
                      >
                        <i class="typcn typcn-eye menu-icon"></i> View
                      </a>
                    </td>
                  </tr>

                  <tr>
                    <td>#ORD002</td>
                    <td>Trần Thị Bình</td>
                    <td>08 Oct 2025</td>
                    <td>850,000₫</td>
                    <td>Bank Transfer</td>
                    <td><label class="badge badge-shipped">Shipped</label></td>
                    <td>
                      <a
                        href="/admin/order/detail"
                        class="nav-link text-primary"
                      >
                        <i class="typcn typcn-eye menu-icon"></i> View
                      </a>
                    </td>
                  </tr>

                  <tr>
                    <td>#ORD003</td>
                    <td>Lê Minh Châu</td>
                    <td>07 Oct 2025</td>
                    <td>2,100,000₫</td>
                    <td>Cash on Delivery</td>
                    <td>
                      <label class="badge badge-processing">Processing</label>
                    </td>
                    <td>
                      <a
                        href="/admin/order/detail"
                        class="nav-link text-primary"
                      >
                        <i class="typcn typcn-eye menu-icon"></i> View
                      </a>
                    </td>
                  </tr>

                  <tr>
                    <td>#ORD004</td>
                    <td>Phạm Thị Dung</td>
                    <td>06 Oct 2025</td>
                    <td>650,000₫</td>
                    <td>E-Wallet</td>
                    <td><label class="badge badge-pending">Pending</label></td>
                    <td>
                      <a
                        href="/admin/order/detail"
                        class="nav-link text-primary"
                      >
                        <i class="typcn typcn-eye menu-icon"></i> View
                      </a>
                    </td>
                  </tr>

                  <tr>
                    <td>#ORD005</td>
                    <td>Hoàng Văn Em</td>
                    <td>05 Oct 2025</td>
                    <td>320,000₫</td>
                    <td>Credit Card</td>
                    <td>
                      <label class="badge badge-cancelled">Cancelled</label>
                    </td>
                    <td>
                      <a
                        href="/admin/order/detail"
                        class="nav-link text-primary"
                      >
                        <i class="typcn typcn-eye menu-icon"></i> View
                      </a>
                    </td>
                  </tr>

                  <tr>
                    <td>#ORD006</td>
                    <td>Võ Thị Giang</td>
                    <td>04 Oct 2025</td>
                    <td>1,280,000₫</td>
                    <td>Bank Transfer</td>
                    <td>
                      <label class="badge badge-delivered">Delivered</label>
                    </td>
                    <td>
                      <a
                        href="/admin/order/detail"
                        class="nav-link text-primary"
                      >
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
      if ("WebSocket" in window) {
        (function () {
          function refreshCSS() {
            var sheets = [].slice.call(document.getElementsByTagName("link"));
            var head = document.getElementsByTagName("head")[0];
            for (var i = 0; i < sheets.length; ++i) {
              var elem = sheets[i];
              var parent = elem.parentElement || head;
              parent.removeChild(elem);
              var rel = elem.rel;
              if (
                (elem.href && typeof rel != "string") ||
                rel.length == 0 ||
                rel.toLowerCase() == "stylesheet"
              ) {
                var url = elem.href.replace(/(&|\?)_cacheOverride=\d+/, "");
                elem.href =
                  url +
                  (url.indexOf("?") >= 0 ? "&" : "?") +
                  "_cacheOverride=" +
                  new Date().valueOf();
              }
              parent.appendChild(elem);
            }
          }
          var protocol =
            window.location.protocol === "http:" ? "ws://" : "wss://";
          var address =
            protocol + window.location.host + window.location.pathname + "/ws";
          var socket = new WebSocket(address);
          socket.onmessage = function (msg) {
            if (msg.data == "reload") window.location.reload();
            else if (msg.data == "refreshcss") refreshCSS();
          };
          if (
            sessionStorage &&
            !sessionStorage.getItem("IsThisFirstTime_Log_From_LiveServer")
          ) {
            console.log("Live reload enabled.");
            sessionStorage.setItem("IsThisFirstTime_Log_From_LiveServer", true);
          }
        })();
      } else {
        console.error(
          "Upgrade your browser. This Browser is NOT supported WebSocket for Live-Reloading."
        );
      }
      // ]]>
    </script>

    <script>
      // Search functionality
      document
        .getElementById("btnSearch")
        .addEventListener("click", function () {
          const searchValue = document
            .getElementById("searchOrder")
            .value.toLowerCase();
          const tableRows = document.querySelectorAll("tbody tr");

          tableRows.forEach((row) => {
            const orderID = row.cells[0].textContent.toLowerCase();
            const customer = row.cells[1].textContent.toLowerCase();
            const status = row.cells[5].textContent.toLowerCase();

            if (
              orderID.includes(searchValue) ||
              customer.includes(searchValue) ||
              status.includes(searchValue)
            ) {
              row.style.display = "";
            } else {
              row.style.display = "none";
            }
          });
        });

      // Enter key search
      document
        .getElementById("searchOrder")
        .addEventListener("keypress", function (e) {
          if (e.key === "Enter") {
            document.getElementById("btnSearch").click();
          }
        });
    </script>
  </div>
</div>
