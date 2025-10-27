package com.shop.shop.dto;

import java.math.BigDecimal;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DashboardStatsDTO {

    // Main statistics
    private Long totalUsers;
    private Long totalShops;
    private Long totalProducts;
    private Long totalOrders;
    private BigDecimal totalRevenue;

    // Growth percentages (compared to previous period)
    private Double userGrowthPercent;
    private Double shopGrowthPercent;
    private Double productGrowthPercent;
    private Double orderGrowthPercent;
    private Double revenueGrowthPercent;

    // Additional metrics
    private Long newUsersThisMonth;
    private Long newShopsThisMonth;
    private Long ordersThisMonth;
    private BigDecimal revenueThisMonth;

    // Commission metrics
    private BigDecimal totalCommissionThisMonth;
    private BigDecimal totalCommissionLastMonth;
    private Double commissionGrowthPercent;

    // Helper methods for display
    public String getFormattedTotalRevenue() {
        return totalRevenue != null ? String.format("%,.0f₫", totalRevenue) : "0₫";
    }

    public String getFormattedRevenueThisMonth() {
        return revenueThisMonth != null ? String.format("%,.0f₫", revenueThisMonth) : "0₫";
    }

    public String getUserGrowthDisplay() {
        if (userGrowthPercent == null)
            return "0%";
        return String.format("%.1f%%", userGrowthPercent);
    }

    public String getShopGrowthDisplay() {
        if (shopGrowthPercent == null)
            return "0%";
        return String.format("%.1f%%", shopGrowthPercent);
    }

    public String getProductGrowthDisplay() {
        if (productGrowthPercent == null)
            return "0%";
        return String.format("%.1f%%", productGrowthPercent);
    }

    public String getRevenueGrowthDisplay() {
        if (revenueGrowthPercent == null)
            return "0%";
        return String.format("%.1f%%", revenueGrowthPercent);
    }

    public String getFormattedTotalCommissionThisMonth() {
        return totalCommissionThisMonth != null ? String.format("%,.0f₫", totalCommissionThisMonth) : "0₫";
    }

    public String getCommissionGrowthDisplay() {
        if (commissionGrowthPercent == null)
            return "0%";
        return String.format("%.1f%%", commissionGrowthPercent);
    }
}