<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                            <button class="btn bg-white btn-sm dropdown-toggle btn-icon-text border mr-2" type="button"
                                id="dropdownMenu3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="typcn typcn-calendar-outline mr-2"></i>Last 7
                                days
                            </button>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuSizeButton3"
                                data-x-placement="top-start">
                                <h6 class="dropdown-header">Last 14 days</h6>
                                <a class="dropdown-item" href="#">Last 21 days</a>
                                <a class="dropdown-item" href="#">Last 28 days</a>
                            </div>
                        </div>
                    </div>
                    <div class="pr-1 mb-3 mr-2 mb-xl-0">
                        <button type="button" class="btn btn-sm bg-white btn-icon-text border">
                            <i class="typcn typcn-arrow-forward-outline mr-2"></i>Export
                        </button>
                    </div>
                    <div class="pr-1 mb-3 mb-xl-0">
                        <button type="button" class="btn btn-sm bg-white btn-icon-text border">
                            <i class="typcn typcn-info-large-outline mr-2"></i>info
                        </button>
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
                            <h4 class="card-title mb-3">Sales Performance</h4>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="d-flex justify-content-between mb-4">
                                            <div class="font-weight-medium">
                                                Empolyee Name
                                            </div>
                                            <div class="font-weight-medium">This Month</div>
                                        </div>
                                        <div class="d-flex justify-content-between mb-4">
                                            <div class="text-secondary font-weight-medium">
                                                Anh Vũ
                                            </div>
                                            <div class="small">$ 4909</div>
                                        </div>
                                        <div class="d-flex justify-content-between mb-4">
                                            <div class="text-secondary font-weight-medium">
                                                Minh Trí
                                            </div>
                                            <div class="small">$857</div>
                                        </div>
                                        <div class="d-flex justify-content-between mb-4">
                                            <div class="text-secondary font-weight-medium">
                                                Hữu Trí
                                            </div>
                                            <div class="small">$612</div>
                                        </div>
                                        <div class="d-flex justify-content-between mb-4">
                                            <div class="text-secondary font-weight-medium">
                                                Minh Danh
                                            </div>
                                            <div class="small">$233</div>
                                        </div>
                                        <div class="d-flex justify-content-between mb-4">
                                            <div class="text-secondary font-weight-medium">
                                                Thanh Lâm
                                            </div>
                                            <div class="small">$233</div>
                                        </div>
                                        <div class="d-flex justify-content-between mb-4">
                                            <div class="text-secondary font-weight-medium">
                                                Anh Kiệt
                                            </div>
                                            <div class="small">$35</div>
                                        </div>
                                        <div class="d-flex justify-content-between mb-4">
                                            <div class="text-secondary font-weight-medium">
                                                Anh Huy
                                            </div>
                                            <div class="small">$43</div>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <div class="text-secondary font-weight-medium">
                                                Thế Vinh
                                            </div>
                                            <div class="small">$43</div>
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
                            <button type="button" class="btn btn-sm btn-light">
                                Month
                            </button>
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
                                            <i class="typcn typcn-globe-outline mr-1"></i>Total Revenue
                                        </h5>
                                        <h2 class="text-primary mb-1 font-weight-bold">
                                            23,342
                                        </h2>
                                    </div>
                                    <div class="mr-md-5 mb-4">
                                        <h5 class="mb-1">
                                            <i class="typcn typcn-archive mr-1"></i>Total
                                            Profit
                                        </h5>
                                        <h2 class="text-secondary mb-1 font-weight-bold">
                                            13,221
                                        </h2>
                                    </div>
                                    <div class="mr-md-5 mb-4">
                                        <h5 class="mb-1">
                                            <i class="typcn typcn-tags mr-1"></i>Total Orders
                                        </h5>
                                        <h2 class="text-warning mb-1 font-weight-bold">
                                            1,542
                                        </h2>
                                    </div>
                                </div>
                                <canvas id="salesanalyticChart" width="657" height="328"
                                    style="display: block; height: 263px; width: 526px;"
                                    class="chartjs-render-monitor"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 d-flex grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <div class="d-flex flex-wrap justify-content-between">
                            <h4 class="card-title mb-3">Card Title</h4>
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
                                    <div class="mr-1">col-12
                                        <div class="text-info mb-1">Total Earning</div>
                                        <h2 class="mb-2 mt-2 font-weight-bold">287,493$</h2>
                                        <div class="font-weight-bold">
                                            1.4% Since Last Month
                                        </div>
                                    </div>
                                    <hr>
                                    <div class="mr-1">
                                        <div class="text-info mb-1">Total Earning</div>
                                        <h2 class="mb-2 mt-2 font-weight-bold">87,493</h2>
                                        <div class="font-weight-bold">
                                            5.43% Since Last Month
                                        </div>
                                    </div>
                                </div>
                                <canvas id="barChartStacked" width="271" height="135"
                                    style="display: block; height: 108px; width: 217px;"
                                    class="chartjs-render-monitor"></canvas>
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
                        <h4 class="card-title mb-3">Sale Analysis Trend</h4>
                    </div>
                    <div class="mt-2">
                        <div class="d-flex justify-content-between">
                            <small>Order Value</small>
                            <small>155.5%</small>
                        </div>
                        <div class="progress progress-md mt-2">
                            <div class="progress-bar bg-secondary" role="progressbar" style="width: 80%"
                                aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="mt-4">
                        <div class="d-flex justify-content-between">
                            <small>Total Products</small>
                            <small>238.2%</small>
                        </div>
                        <div class="progress progress-md mt-2">
                            <div class="progress-bar bg-success" role="progressbar" style="width: 50%"
                                aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <div class="mt-4 mb-5">
                        <div class="d-flex justify-content-between">
                            <small>Quantity</small>
                            <small>23.30%</small>
                        </div>
                        <div class="progress progress-md mt-2">
                            <div class="progress-bar bg-warning" role="progressbar" style="width: 70%"
                                aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
                        </div>
                    </div>
                    <canvas id="salesTopChart" width="425" height="212"
                        style="display: block; height: 170px; width: 340px;" class="chartjs-render-monitor"></canvas>
                </div>
            </div>
        </div>
        <div class="col-lg-8 d-flex grid-margin stretch-card">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex flex-wrap justify-content-between">
                        <h4 class="card-title mb-3">Latest Orders</h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Invoice ID</th>
                                    <th>Name</th>
                                    <th>Total Amount</th>
                                    <th>Status</th>
                                    <th>Delivery Date</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>HD001</td>
                                    <td>
                                        <div class="d-flex">
                                            <img class="img-sm rounded-circle mb-md-0 mr-2"
                                                src="/admin/images/faces/face30.png" alt="profile image">
                                            <div class="font-weight-bold mt-1">Quốc Đạt</div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold mt-1">$2322</div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold text-success mt-1">
                                            88%
                                        </div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold mt-1">07 Nov 2019</div>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-secondary">
                                            Edit
                                        </button>
                                    </td>
                                </tr>

                                <tr>
                                    <td>HD002</td>
                                    <td>
                                        <div class="d-flex">
                                            <img class="img-sm rounded-circle mb-md-0 mr-2"
                                                src="/admin/images/faces/face31.png" alt="profile image">
                                            <div class="font-weight-bold mt-1">Quốc Huy</div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold mt-1">$12022</div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold text-success mt-1">
                                            done
                                        </div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold mt-1">08 Nov 2019</div>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-secondary">
                                            Edit
                                        </button>
                                    </td>
                                </tr>

                                <tr>
                                    <td>HD003</td>
                                    <td>
                                        <div class="d-flex">
                                            <img class="img-sm rounded-circle mb-md-0 mr-2"
                                                src="/admin/images/faces/face32.png" alt="profile image">
                                            <div class="font-weight-bold mt-1">Vũ Quân</div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold mt-1">$8,725</div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold text-success mt-1">
                                            87%
                                        </div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold mt-1">11 Jun 2019</div>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-secondary">
                                            Edit
                                        </button>
                                    </td>
                                </tr>

                                <tr>
                                    <td>HD004</td>
                                    <td>
                                        <div class="d-flex">
                                            <img class="img-sm rounded-circle mb-md-0 mr-2"
                                                src="/admin/images/faces/face33.png" alt="profile image">
                                            <div class="font-weight-bold mt-1">Huỳnh Tự</div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold mt-1">$5,220</div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold text-success mt-1">
                                            done
                                        </div>
                                    </td>
                                    <td>
                                        <div class="font-weight-bold mt-1">26 Oct 2019</div>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-secondary">
                                            Edit
                                        </button>
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
            <span class="text-center text-sm-left d-block d-sm-inline-block">Copyright ©
                <a href="https://www.bootstrapdash.com/" target="_blank">bootstrapdash.com</a>
                2020</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Free
                <a href="https://www.bootstrapdash.com/" target="_blank">Bootstrap dashboard </a>templates from
                Bootstrapdash.com</span>
        </div>
    </footer>
    <!-- partial -->
</div>