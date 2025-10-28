<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <head>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
            </head>

            <style>
                @keyframes fadeInUp {
                    from {
                        opacity: 0;
                        transform: translateY(20px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .welcome-banner {
                    animation: fadeInUp 0.6s ease-out;
                }

                .stat-row {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 1rem;
                    justify-content: space-between;
                }

                .stat-card {
                    flex: 1 1 calc(25% - 0.75rem);
                    min-width: 150px;
                    max-width: calc(25% - 0.75rem);
                    background: #fff;
                    border-radius: 15px;
                    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.08);
                    transition: transform 0.2s ease;
                }

                .stat-card:hover {
                    transform: translateY(-3px);
                }

                .stat-card .card-body {
                    padding: 1.25rem;
                }

                .stat-value {
                    font-size: 1.7rem;
                    font-weight: 700;
                }

                .stat-label {
                    color: #6c757d;
                    margin-bottom: 6px;
                }

                .stat-badge {
                    font-size: 0.75rem;
                    border-radius: 50px;
                    padding: 4px 9px;
                }

                .stat-icon {
                    width: 55px;
                    height: 55px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    font-size: 1.4rem;
                }

                .chart-container {
                    background: #fff;
                    border-radius: 15px;
                    box-shadow: 0 3px 8px rgba(0, 0, 0, 0.08);
                    margin-top: 1.5rem;
                }

                .chart-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    padding: 1.5rem;
                    border-bottom: 1px solid #eee;
                }

                .chart-legend {
                    display: flex;
                    align-items: center;
                    flex-wrap: wrap;
                    gap: 1.5rem;
                }

                .chart-title {
                    font-size: 1.2rem;
                    font-weight: 600;
                    margin-right: 1rem;
                }

                .legend-item {
                    font-size: 0.85rem;
                    color: #333;
                    display: flex;
                    align-items: center;
                    font-weight: 500;
                }

                .legend-color {
                    width: 10px;
                    height: 10px;
                    border-radius: 50%;
                    margin-right: 5px;
                }

                .legend-item.purple .legend-color {
                    background-color: #8c57ff;
                }

                .legend-item.green .legend-color {
                    background-color: #00c853;
                }

                .legend-item.orange .legend-color {
                    background-color: #ff9800;
                }

                .chart-time-select .btn {
                    background-color: #f8f9fa;
                    color: #6c757d;
                    border: 1px solid #dee2e6;
                    border-radius: 8px;
                    padding: 0.5rem 1rem;
                    font-size: 0.85rem;
                }

                .chart-body {
                    padding: 1.5rem;
                    min-height: 350px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }

                .chart-placeholder {
                    width: 100%;
                    height: 100%;

                }

                .chart-filters {
                    display: flex;
                    flex-wrap: wrap;
                    gap: 0.75rem;
                    align-items: center;
                    margin-bottom: 1rem;
                }

                .filter-item {
                    display: flex;
                    flex-direction: column;
                }

                .filter-item label {
                    font-size: 0.85rem;
                    margin-bottom: 0.25rem;
                    color: #555;
                }

                .filter-item .form-select {
                    padding: 0.35rem 0.6rem;
                    border-radius: 8px;
                    border: 1px solid #ccc;
                    font-size: 0.9rem;
                    min-width: 80px;
                    background-color: #fff;
                    transition: border-color 0.2s ease;
                }

                .filter-item .form-select:focus {
                    border-color: #8c57ff;
                    outline: none;
                    box-shadow: 0 0 3px rgba(140, 87, 255, 0.4);
                }
            </style>


            <div class="main-panel">
                <div class="content-wrapper">

                    <!-- Welcome Banner -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="card welcome-banner"
                                style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border: none; box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4); border-radius: 15px;">
                                <div class="card-body py-4">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div class="flex-grow-1">
                                            <h2 class="text-white mb-2" style="font-weight: 600;">
                                                <i class="fas fa-store mr-2"></i>
                                                <c:choose>
                                                    <c:when
                                                        test="${not empty acc.shop and not empty acc.shop.shopName}">
                                                        ${acc.shop.shopName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Shipper Dashboard
                                                    </c:otherwise>
                                                </c:choose>
                                            </h2>
                                            <p class="text-white mb-0" style="opacity: 0.95; font-size: 1rem;">
                                                <i class="fas fa-user-circle mr-2"></i>
                                                Xin chào, <strong>${acc.fullName}</strong>!
                                                <span class="ml-3">
                                                    <i class="fas fa-calendar-alt mr-1"></i>
                                                    <fmt:formatDate value="<%= new java.util.Date() %>"
                                                        pattern="EEEE, dd/MM/yyyy" />
                                                </span>
                                            </p>
                                        </div>
                                        <div class="ml-3 d-none d-md-block">
                                            <div
                                                style="background: rgba(255,255,255,0.2); padding: 20px; border-radius: 12px;">
                                                <i class="fas fa-chart-line text-white" style="font-size: 2.5rem;"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Statistics Cards -->
                    <div class="stat-row">
                        <!-- Chờ xác nhận -->
                        <div class="card stat-card">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="stat-value" id="failedCount">${failedCount}</div>
                                    <div class="stat-label">Chờ xác nhận</div>
                                </div>
                                <div class="stat-icon" style="background-color: #FFF3CD;">
                                    <i class="fas fa-hourglass-half text-warning"></i>
                                </div>
                            </div>
                        </div>


                        <!-- Đang giao -->
                        <div class="card stat-card">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="stat-value" id="shippingCount">${shippingCount}</div>
                                    <div class="stat-label">Đang giao</div>
                                </div>
                                <div class="stat-icon" style="background-color: #E3F2FD;">
                                    <i class="fas fa-truck text-primary"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Giao thành công -->
                        <div class="card stat-card">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="stat-value" id="deliveredCount">${deliveredCount}</div>
                                    <div class="stat-label">Giao thành công</div>
                                </div>
                                <div class="stat-icon" style="background-color: #E8F5E9;">
                                    <i class="fas fa-check-circle text-success"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Trả hàng -->
                        <div class="card stat-card">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="stat-value" id="returnedCount">${returnedCount}</div>
                                    <div class="stat-label">Trả hàng</div>
                                </div>
                                <div class="stat-icon" style="background-color: #FFF3E0;">
                                    <i class="fas fa-undo text-warning"></i>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="card chart-container shadow-sm border-0">
                        <div class="card-header chart-header"
                            style="display:flex; justify-content:space-between; align-items:center;">
                            <div class="chart-legend">
                                <span class="chart-title">
                                    Biểu đồ doanh thu vận chuyển
                                </span>
                            </div>

                            <div class="chart-controls d-flex gap-2 align-items-end">
                                <!-- Loại biểu đồ -->
                                <div class="filter-item d-flex flex-column">
                                    <label for="chartType" class="fw-semibold small text-secondary mb-1">Kiểu biểu
                                        đồ</label>
                                    <select id="chartType" class="form-select form-select-sm rounded-3">
                                        <option value="bar" selected>Bar</option>
                                        <option value="pie">Pie</option>
                                    </select>
                                </div>

                                <!-- Mốc thời gian -->
                                <div class="filter-item d-flex flex-column">
                                    <label for="chartPeriod" class="fw-semibold small text-secondary mb-1">Theo</label>
                                    <select id="chartPeriod" class="form-select form-select-sm rounded-3">
                                        <option value="day">Ngày</option>
                                        <option value="month" selected>Tháng</option>
                                        <option value="area">Khu vực</option>
                                    </select>
                                </div>

                                <!-- Năm -->
                                <div class="filter-item d-flex flex-column">
                                    <label for="chartYear" class="fw-semibold small text-secondary mb-1">Năm</label>
                                    <select id="chartYear" class="form-select form-select-sm rounded-3">
                                        <c:forEach var="y" begin="2020" end="2025">
                                            <option value="${y}">${y}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Vùng hiển thị biểu đồ -->
                        <div class="chart-body p-4">
                            <canvas id="revenueChart" height="120"></canvas>
                        </div>
                    </div>

                    <!-- content-wrapper ends -->
                    <!-- partial -->

                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                    <script>
                        const monthsVN = ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"];
                        const daysVN = ["Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7", "CN"];
                        const areasVN = ["Quận 1", "Quận 3", "Quận 5", "Quận 7", "Bình Thạnh", "Gò Vấp", "Tân Bình", "Phú Nhuận"];

                        function fakeData(labels) {
                            const success = labels.map(() => Math.floor(Math.random() * 800000 + 200000)); // xanh
                            const inProgress = labels.map(() => Math.floor(Math.random() * 400000 + 100000)); // vàng
                            const failed = labels.map(() => Math.floor(Math.random() * 200000 + 50000)); // đỏ
                            return { labels, success, inProgress, failed };
                        }

                        let ctx = document.getElementById('revenueChart').getContext('2d');
                        let revenueChart;

                        function createChart(type, dataObj) {
                            revenueChart = new Chart(ctx, {
                                type: type,
                                data: {
                                    labels: dataObj.labels,
                                    datasets: [
                                        {
                                            label: 'Thành công',
                                            data: dataObj.success,
                                            backgroundColor: type === 'pie' ? '#4caf50' : 'rgba(76,175,80,0.7)',
                                            borderColor: '#4caf50',
                                            borderWidth: 1
                                        },
                                        {
                                            label: 'Đang giao',
                                            data: dataObj.inProgress,
                                            backgroundColor: type === 'pie' ? '#ffeb3b' : 'rgba(255,235,59,0.7)',
                                            borderColor: '#fbc02d',
                                            borderWidth: 1
                                        },
                                        {
                                            label: 'Thất bại',
                                            data: dataObj.failed,
                                            backgroundColor: type === 'pie' ? '#f44336' : 'rgba(244,67,54,0.7)',
                                            borderColor: '#d32f2f',
                                            borderWidth: 1
                                        }
                                    ]
                                },
                                options: {
                                    responsive: true,
                                    plugins: {
                                        legend: { display: true, position: 'bottom' },
                                        tooltip: {
                                            callbacks: {
                                                label: function (context) {
                                                    const value = context.raw.toLocaleString('vi-VN') + ' VND';
                                                    return `${context.dataset.label}: ${value}`;
                                                }
                                            }
                                        },
                                        title: {
                                            display: true,
                                            text: 'Doanh thu vận chuyển',
                                            font: { size: 16 }
                                        }
                                    },
                                    scales: type === 'pie' ? {} : {
                                        y: {
                                            beginAtZero: true,
                                            ticks: {
                                                callback: value => value.toLocaleString('vi-VN') + ' VND'
                                            }
                                        }
                                    }
                                }
                            });
                        }

                        function updateChart() {
                            const type = document.getElementById('chartType').value;
                            const period = document.getElementById('chartPeriod').value;

                            let labels;
                            if (period === 'month') labels = monthsVN;
                            else if (period === 'day') labels = daysVN;
                            else labels = areasVN;

                            const dataObj = fakeData(labels);
                            if (revenueChart) revenueChart.destroy();
                            createChart(type, dataObj);
                        }

                        document.getElementById('chartType').addEventListener('change', updateChart);
                        document.getElementById('chartPeriod').addEventListener('change', updateChart);

                        updateChart(); // khởi tạo ban đầu
                    </script>
                </div>
            </div>