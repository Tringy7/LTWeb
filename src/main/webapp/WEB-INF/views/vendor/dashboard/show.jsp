<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <head>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
            </head>

            <style>
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

                    <div class="stat-row">
                        <div class="card stat-card">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="stat-value" id="totalProducts">${totalProducts}</div>
                                    <div class="stat-label">Tổng số sản phẩm</div>
                                </div>
                                <div class="stat-icon" style="background-color: #E3FCEC;">
                                    <i class="fas fa-box text-success"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Tổng voucher -->
                        <div class="card stat-card">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="stat-value" id="totalVouchers">${totalVouchers}</div>
                                    <div class="stat-label">Tổng số voucher</div>
                                </div>
                                <div class="stat-icon" style="background-color: #EAE4FF;">
                                    <i class="fas fa-ticket-alt text-primary"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Tổng đơn hàng -->
                        <div class="card stat-card">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="stat-value" id="totalOrders">${totalOrders}</div>
                                    <div class="stat-label">Tổng số đơn hàng</div>
                                </div>
                                <div class="stat-icon" style="background-color: #FFE9E3;">
                                    <i class="fas fa-shopping-cart text-danger"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Tổng doanh thu -->
                        <div class="card stat-card">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="stat-value" id="totalRevenue">${totalRevenue}</div>
                                    <div class="stat-label">Doanh thu (vnd)</div>
                                </div>
                                <div class="stat-icon" style="background-color: #FFF1E3;">
                                    <i class="fas fa-coins text-warning"></i>
                                </div>
                            </div>
                        </div>

                    </div>

                    <div class="card chart-container">
                        <div class="card-header chart-header"
                            style="display:flex; justify-content:space-between; align-items:center;">
                            <div class="chart-legend">
                                <span class="chart-title">Revenue Report</span>
                                <!-- <span class="legend-item purple"><span class="legend-color"></span>Earnings</span>
                                <span class="legend-item green"><span class="legend-color"></span>Invested</span>
                                <span class="legend-item orange"><span class="legend-color"></span>Expenses</span> -->
                            </div>
                            <div class="chart-controls" style="display:flex; gap:0.5rem;">
                                <!-- Kiểu biểu đồ -->
                                <!-- Kiểu biểu đồ -->
                                <div class="filter-item">
                                    <label for="chartType">Chart:</label>
                                    <select id="chartType" class="form-select">
                                        <option value="line" selected>Line</option>
                                        <option value="bar">Bar</option>
                                    </select>
                                </div>

                                <!-- From month -->
                                <div class="filter-item">
                                    <label for="monthStart">From:</label>
                                    <select id="monthStart" class="form-select">
                                        <option value="0">Jan</option>
                                        <option value="1">Feb</option>
                                        <option value="2">Mar</option>
                                        <option value="3">Apr</option>
                                        <option value="4">May</option>
                                        <option value="5">Jun</option>
                                        <option value="6">Jul</option>
                                        <option value="7">Aug</option>
                                        <option value="8">Sep</option>
                                        <option value="9">Oct</option>
                                        <option value="10">Nov</option>
                                        <option value="11">Dec</option>
                                    </select>
                                </div>

                                <!-- To month -->
                                <div class="filter-item">
                                    <label for="monthEnd">To:</label>
                                    <select id="monthEnd" class="form-select">
                                        <option value="0">Jan</option>
                                        <option value="1">Feb</option>
                                        <option value="2">Mar</option>
                                        <option value="3">Apr</option>
                                        <option value="4">May</option>
                                        <option value="5" selected>Jun</option>
                                        <option value="6">Jul</option>
                                        <option value="7">Aug</option>
                                        <option value="8">Sep</option>
                                        <option value="9">Oct</option>
                                        <option value="10">Nov</option>
                                        <option value="11">Dec</option>
                                    </select>
                                </div>

                                <!-- Year -->
                                <div class="filter-item">
                                    <label for="chartYear">Year:</label>
                                    <select id="chartYear" class="form-select">
                                        <c:forEach var="y" begin="2020" end="2025">
                                            <option value="${y}">${y}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="card-body chart-body">
                            <canvas id="revenueChart" style="width:100%; height:350px;"></canvas>
                        </div>
                    </div>

                </div>
                <!-- content-wrapper ends -->
                <!-- partial -->

                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                <script>
                    const monthsAbbr = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

                    function generateDataRange(startMonth, endMonth) {
                        const labels = [];
                        const earnings = [];
                        const invested = [];
                        const expenses = [];
                        for (let i = startMonth; i <= endMonth; i++) {
                            labels.push(monthsAbbr[i]);
                            earnings.push(Math.floor(Math.random() * 4000 + 1000));
                            invested.push(Math.floor(Math.random() * 3000 + 1000));
                            expenses.push(Math.floor(Math.random() * 2000 + 500));
                        }
                        return { labels, earnings, invested, expenses };
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
                                        label: 'Earnings',
                                        data: dataObj.earnings,
                                        borderColor: '#8c57ff',
                                        backgroundColor: type === 'pie' ? '#8c57ff' : 'rgba(140,87,255,0.2)',
                                        fill: type !== 'pie',
                                        tension: 0.3,
                                        pointRadius: 5,
                                        pointHoverRadius: 8
                                    },
                                    {
                                        label: 'Invested',
                                        data: dataObj.invested,
                                        borderColor: '#00c853',
                                        backgroundColor: type === 'pie' ? '#00c853' : 'rgba(0,200,83,0.2)',
                                        fill: type !== 'pie',
                                        tension: 0.3,
                                        pointRadius: 5,
                                        pointHoverRadius: 8
                                    },
                                    {
                                        label: 'Expenses',
                                        data: dataObj.expenses,
                                        borderColor: '#ff9800',
                                        backgroundColor: type === 'pie' ? '#ff9800' : 'rgba(255,152,0,0.2)',
                                        fill: type !== 'pie',
                                        tension: 0.3,
                                        pointRadius: 5,
                                        pointHoverRadius: 8
                                    }
                                ]
                            },
                            options: {
                                responsive: true,
                                plugins: {
                                    legend: { display: true },
                                    tooltip: {
                                        callbacks: {
                                            label: function (context) {
                                                if (context.parsed?.y !== undefined) {
                                                    return context.dataset.label + ': ' + context.parsed.y.toLocaleString('vi-VN') + ' VND';
                                                } else {
                                                    return context.dataset.label + ': ' + context.raw.toLocaleString('vi-VN') + ' VND';
                                                }
                                            }
                                        }
                                    }
                                },
                                scales: type === 'pie' ? {} : { y: { beginAtZero: true } }
                            }
                        });
                    }

                    function updateChart() {
                        const type = document.getElementById('chartType').value;
                        const start = parseInt(document.getElementById('monthStart').value);
                        const end = parseInt(document.getElementById('monthEnd').value);
                        const year = parseInt(document.getElementById('chartYear').value);

                        if (end < start) {
                            alert('Tháng kết thúc phải lớn hơn hoặc bằng tháng bắt đầu!');
                            return;
                        }

                        const dataObj = generateDataRange(start, end);

                        if (revenueChart) revenueChart.destroy();
                        createChart(type, dataObj);
                    }

                    document.getElementById('chartType').addEventListener('change', updateChart);
                    document.getElementById('monthStart').addEventListener('change', updateChart);
                    document.getElementById('monthEnd').addEventListener('change', updateChart);
                    document.getElementById('chartYear').addEventListener('change', updateChart);

                    // Khởi tạo chart lần đầu
                    updateChart();
                </script>
            </div>