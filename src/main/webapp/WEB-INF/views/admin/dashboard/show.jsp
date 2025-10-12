<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="main-panel">
  <div class="content-wrapper">
    <div class="row">
      <div class="col-sm-6">
        <h3 class="mb-0 font-weight-bold">Anh Vũ</h3>
        <p>Welcome to the Admin Homepage</p>
      </div>
      <div class="col-sm-6">
        <div class="d-flex align-items-center justify-content-md-end">
          <div class="mb-3 mb-xl-0 pr-1">
            <div class="dropdown">
              <button
                class="btn bg-white btn-sm dropdown-toggle btn-icon-text border mr-2"
                type="button"
                id="dropdownMenu3"
                data-toggle="dropdown"
                aria-haspopup="true"
                aria-expanded="false"
              >
                <i class="typcn typcn-calendar-outline mr-2"></i>Last 7 days
              </button>
              <div
                class="dropdown-menu"
                aria-labelledby="dropdownMenuSizeButton3"
                data-x-placement="top-start"
              >
                <h6 class="dropdown-header">Last 14 days</h6>
                <a class="dropdown-item" href="#">Last 21 days</a>
                <a class="dropdown-item" href="#">Last 28 days</a>
              </div>
            </div>
          </div>
          <div class="pr-1 mb-3 mr-2 mb-xl-0">
            <button
              type="button"
              class="btn btn-sm bg-white btn-icon-text border"
            >
              <i class="typcn typcn-arrow-forward-outline mr-2"></i>Export
            </button>
          </div>
          <div class="pr-1 mb-3 mb-xl-0">
            <button
              type="button"
              class="btn btn-sm bg-white btn-icon-text border"
            >
              <i class="typcn typcn-info-large-outline mr-2"></i>info
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Quick Actions Section -->
    <div class="row mt-4">
      <div class="col-lg-12">
        <div class="card">
          <div class="card-body">
            <h4 class="card-title mb-4">
              <i class="typcn typcn-cog-outline mr-2"></i>
              Quick Actions
            </h4>
            <div class="row">
              <div class="col-md-3">
                <a
                  href="/admin/user"
                  class="btn btn-primary btn-lg btn-block mb-3"
                >
                  <i class="typcn typcn-user-outline mr-2"></i>
                  Manage Users
                </a>
              </div>
              <div class="col-md-3">
                <a
                  href="/admin/product"
                  class="btn btn-success btn-lg btn-block mb-3"
                >
                  <i class="typcn typcn-shopping-bag mr-2"></i>
                  Manage Products
                </a>
              </div>
              <div class="col-md-3">
                <a
                  href="/admin/commission"
                  class="btn btn-warning btn-lg btn-block mb-3"
                >
                  <i class="typcn typcn-calculator mr-2"></i>
                  Manage Commissions
                </a>
              </div>
              <div class="col-md-3">
                <a
                  href="/admin/dashboard"
                  class="btn btn-info btn-lg btn-block mb-3"
                >
                  <i class="typcn typcn-chart-line-outline mr-2"></i>
                  Analytics
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="row mt-3">
      <div class="col-xl-5 d-flex grid-margin stretch-card">
        <!-- <div class="card">
                  <div class="card-body"></div>
                </div> -->
      </div>
      <div class="col-xl-3 d-flex grid-margin stretch-card">
        <!-- <div class="card">
                  <div class="card-body"></div>
                </div> -->
      </div>
      <div class="col-xl-4 d-flex grid-margin stretch-card">
        <!-- <div class="card">
                    <div class="card-body"></div>
                  </div> -->
      </div>
    </div>
    <div class="row">
      <div class="col-xl-3 d-flex grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <div class="d-flex flex-wrap justify-content-between">
              <h4 class="card-title mb-3">Commission Performance</h4>
            </div>
            <div class="row">
              <div class="col-12">
                <div class="row">
                  <div class="col-sm-12">
                    <div class="d-flex justify-content-between mb-4">
                      <div class="font-weight-medium">Shop Name</div>
                      <div class="font-weight-medium">This Month</div>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                      <div class="text-secondary font-weight-medium">
                        Tech Store VN
                      </div>
                      <div class="small">$ 245</div>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                      <div class="text-secondary font-weight-medium">
                        Fashion Hub
                      </div>
                      <div class="small">$187</div>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                      <div class="text-secondary font-weight-medium">
                        Book Store
                      </div>
                      <div class="small">$156</div>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                      <div class="text-secondary font-weight-medium">
                        Sports Shop
                      </div>
                      <div class="small">$133</div>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                      <div class="text-secondary font-weight-medium">
                        Home & Garden
                      </div>
                      <div class="small">$98</div>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                      <div class="text-secondary font-weight-medium">
                        Electronics Plus
                      </div>
                      <div class="small">$76</div>
                    </div>
                    <div class="d-flex justify-content-between mb-4">
                      <div class="text-secondary font-weight-medium">
                        Beauty Store
                      </div>
                      <div class="small">$54</div>
                    </div>
                    <div class="d-flex justify-content-between">
                      <div class="text-secondary font-weight-medium">
                        Pet Supplies
                      </div>
                      <div class="small">$32</div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-xl-6 d-flex grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <div class="d-flex flex-wrap justify-content-between">
              <h4 class="card-title mb-3">Business Overview</h4>
              <button type="button" class="btn btn-sm btn-light">Month</button>
            </div>
            <div class="row">
              <div class="col-12">
                <div class="chartjs-size-monitor">
                  <div class="chartjs-size-monitor-expand">
                    <div class=""></div>
                  </div>
                  <div class="chartjs-size-monitor-shrink">
                    <div class=""></div>
                  </div>
                </div>
                <div class="d-md-flex mb-4">
                  <div class="mr-md-5 mb-4">
                    <h5 class="mb-1">
                      <i class="typcn typcn-globe-outline mr-1"></i>Total
                      Revenue
                    </h5>
                    <h2 class="text-primary mb-1 font-weight-bold">23,342</h2>
                  </div>
                  <div class="mr-md-5 mb-4">
                    <h5 class="mb-1">
                      <i class="typcn typcn-calculator mr-1"></i>Total
                      Commission
                    </h5>
                    <h2 class="text-secondary mb-1 font-weight-bold">1,167</h2>
                  </div>
                  <div class="mr-md-5 mb-4">
                    <h5 class="mb-1">
                      <i class="typcn typcn-shopping-cart mr-1"></i>Total Orders
                    </h5>
                    <h2 class="text-warning mb-1 font-weight-bold">1,542</h2>
                  </div>
                </div>
                <canvas
                  id="salesanalyticChart"
                  width="657"
                  height="328"
                  style="display: block; height: 263px; width: 526px"
                  class="chartjs-render-monitor"
                ></canvas>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-xl-3 d-flex grid-margin stretch-card">
        <div class="card">
          <div class="card-body">
            <div class="d-flex flex-wrap justify-content-between">
              <h4 class="card-title mb-3">Commission Stats</h4>
            </div>
            <div class="row">
              <div class="col-12">
                <div class="chartjs-size-monitor">
                  <div class="chartjs-size-monitor-expand">
                    <div class=""></div>
                  </div>
                  <div class="chartjs-size-monitor-shrink">
                    <div class=""></div>
                  </div>
                </div>
                <div class="mb-5">
                  <div class="mr-1">
                    <div class="text-info mb-1">Monthly Commission</div>
                    <h2 class="mb-2 mt-2 font-weight-bold">$1,167</h2>
                    <div class="font-weight-bold">
                      <span class="text-success">+8.2%</span> Since Last Month
                    </div>
                  </div>
                  <hr />
                  <div class="mr-1">
                    <div class="text-info mb-1">Active Shops</div>
                    <h2 class="mb-2 mt-2 font-weight-bold">87</h2>
                    <div class="font-weight-bold">
                      <span class="text-success">+5.43%</span> Since Last Month
                    </div>
                  </div>
                </div>
                <canvas
                  id="barChartStacked"
                  width="271"
                  height="135"
                  style="display: block; height: 108px; width: 217px"
                  class="chartjs-render-monitor"
                ></canvas>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-12 d-flex grid-margin stretch-card">
        <!-- <div class="card">
                  <div class="card-body"></div>
                </div> -->
      </div>
    </div>
  </div>
  <div class="row">
    <div class="col-lg-4 d-flex grid-margin stretch-card">
      <div class="card">
        <div class="card-body">
          <div class="chartjs-size-monitor">
            <div class="chartjs-size-monitor-expand">
              <div class=""></div>
            </div>
            <div class="chartjs-size-monitor-shrink">
              <div class=""></div>
            </div>
          </div>
          <div class="d-flex flex-wrap justify-content-between">
            <h4 class="card-title mb-3">Commission Analysis Trend</h4>
          </div>
          <div class="mt-2">
            <div class="d-flex justify-content-between">
              <small>Commission Rate</small>
              <small>5.0%</small>
            </div>
            <div class="progress progress-md mt-2">
              <div
                class="progress-bar bg-secondary"
                role="progressbar"
                style="width: 80%"
                aria-valuenow="80"
                aria-valuemin="0"
                aria-valuemax="100"
              ></div>
            </div>
          </div>
          <div class="mt-4">
            <div class="d-flex justify-content-between">
              <small>Total Shops</small>
              <small>87 Active</small>
            </div>
            <div class="progress progress-md mt-2">
              <div
                class="progress-bar bg-success"
                role="progressbar"
                style="width: 50%"
                aria-valuenow="50"
                aria-valuemin="0"
                aria-valuemax="100"
              ></div>
            </div>
          </div>
          <div class="mt-4 mb-5">
            <div class="d-flex justify-content-between">
              <small>Collection Rate</small>
              <small>92.3%</small>
            </div>
            <div class="progress progress-md mt-2">
              <div
                class="progress-bar bg-warning"
                role="progressbar"
                style="width: 70%"
                aria-valuenow="70"
                aria-valuemin="0"
                aria-valuemax="100"
              ></div>
            </div>
          </div>
          <canvas
            id="salesTopChart"
            width="425"
            height="212"
            style="display: block; height: 170px; width: 340px"
            class="chartjs-render-monitor"
          ></canvas>
        </div>
      </div>
    </div>
    <div class="col-lg-8 d-flex grid-margin stretch-card">
      <div class="card">
        <div class="card-body">
          <div class="d-flex flex-wrap justify-content-between">
            <h4 class="card-title mb-3">Latest Commissions</h4>
            <a href="/admin/commission" class="btn btn-sm btn-primary">
              <i class="typcn typcn-eye mr-1"></i>View All
            </a>
          </div>
          <div class="table-responsive">
            <table class="table">
              <thead>
                <tr>
                  <th>Commission ID</th>
                  <th>Shop Name</th>
                  <th>Revenue</th>
                  <th>Commission</th>
                  <th>Status</th>
                  <th>Date</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>#CM001</td>
                  <td>
                    <div class="d-flex">
                      <div class="font-weight-bold mt-1">Tech Store VN</div>
                    </div>
                  </td>
                  <td>
                    <div class="font-weight-bold mt-1">$4,900</div>
                  </td>
                  <td>
                    <div class="font-weight-bold text-success mt-1">$245</div>
                  </td>
                  <td>
                    <span class="badge badge-warning">Pending</span>
                  </td>
                  <td>
                    <div class="font-weight-bold mt-1">07 Nov 2024</div>
                  </td>
                  <td>
                    <a
                      href="/admin/commission"
                      class="btn btn-sm btn-secondary"
                    >
                      View
                    </a>
                  </td>
                </tr>

                <tr>
                  <td>#CM002</td>
                  <td>
                    <div class="d-flex">
                      <div class="font-weight-bold mt-1">Fashion Hub</div>
                    </div>
                  </td>
                  <td>
                    <div class="font-weight-bold mt-1">$3,740</div>
                  </td>
                  <td>
                    <div class="font-weight-bold text-success mt-1">$187</div>
                  </td>
                  <td>
                    <span class="badge badge-success">Collected</span>
                  </td>
                  <td>
                    <div class="font-weight-bold mt-1">08 Nov 2024</div>
                  </td>
                  <td>
                    <a
                      href="/admin/commission"
                      class="btn btn-sm btn-secondary"
                    >
                      View
                    </a>
                  </td>
                </tr>

                <tr>
                  <td>#CM003</td>
                  <td>
                    <div class="d-flex">
                      <div class="font-weight-bold mt-1">Book Store</div>
                    </div>
                  </td>
                  <td>
                    <div class="font-weight-bold mt-1">$3,120</div>
                  </td>
                  <td>
                    <div class="font-weight-bold text-success mt-1">$156</div>
                  </td>
                  <td>
                    <span class="badge badge-warning">Pending</span>
                  </td>
                  <td>
                    <div class="font-weight-bold mt-1">11 Nov 2024</div>
                  </td>
                  <td>
                    <a
                      href="/admin/commission"
                      class="btn btn-sm btn-secondary"
                    >
                      View
                    </a>
                  </td>
                </tr>

                <tr>
                  <td>#CM004</td>
                  <td>
                    <div class="d-flex">
                      <div class="font-weight-bold mt-1">Sports Shop</div>
                    </div>
                  </td>
                  <td>
                    <div class="font-weight-bold mt-1">$2,660</div>
                  </td>
                  <td>
                    <div class="font-weight-bold text-success mt-1">$133</div>
                  </td>
                  <td>
                    <span class="badge badge-success">Collected</span>
                  </td>
                  <td>
                    <div class="font-weight-bold mt-1">26 Oct 2024</div>
                  </td>
                  <td>
                    <a
                      href="/admin/commission"
                      class="btn btn-sm btn-secondary"
                    >
                      View
                    </a>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- content-wrapper ends -->
  <!-- partial:partials/_footer.html -->
  <footer class="footer">
    <div class="d-sm-flex justify-content-center justify-content-sm-between">
      <span class="text-center text-sm-left d-block d-sm-inline-block"
        >Copyright ©
        <a href="https://www.bootstrapdash.com/" target="_blank"
          >bootstrapdash.com</a
        >
        2024</span
      >
      <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center"
        >Free
        <a href="https://www.bootstrapdash.com/" target="_blank"
          >Bootstrap dashboard </a
        >templates from Bootstrapdash.com</span
      >
    </div>
  </footer>
  <!-- partial -->
</div>
