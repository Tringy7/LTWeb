package com.shop.shop.service.admin;

import java.util.List;

import com.shop.shop.domain.Order;
import com.shop.shop.domain.Product;
import com.shop.shop.dto.CommissionSummaryDTO;
import com.shop.shop.dto.DashboardStatsDTO;
import com.shop.shop.dto.OrderStatsDTO;

public interface DashboardService {

    // Main dashboard statistics
    DashboardStatsDTO getDashboardStats();

    // Order statistics
    OrderStatsDTO getOrderStats();

    // Recent data
    List<Order> getRecentOrders(int limit);

    List<Product> getTopProducts(int limit);

    // Commission summary
    CommissionSummaryDTO getCommissionSummary();

    // Additional metrics
    Long getTotalUsersThisMonth();

    Long getTotalShopsThisMonth();

    Long getTotalOrdersThisMonth();

    Double getRevenueGrowthPercent();
}