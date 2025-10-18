package com.shop.shop.controller.admin;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.shop.domain.Order;
import com.shop.shop.domain.Product;
import com.shop.shop.dto.CommissionSummaryDTO;
import com.shop.shop.dto.DashboardStatsDTO;
import com.shop.shop.dto.OrderStatsDTO;
import com.shop.shop.service.admin.DashboardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminDashboardController {

    private final DashboardService dashboardService;

    @GetMapping("/admin/dashboard")
    public String showDashboard(Model model) {
        try {
            // Get main dashboard statistics
            DashboardStatsDTO dashboardStats = dashboardService.getDashboardStats();
            model.addAttribute("dashboardStats", dashboardStats);

            // Get order statistics
            OrderStatsDTO orderStats = dashboardService.getOrderStats();
            model.addAttribute("orderStats", orderStats);

            // Get recent orders (last 10)
            List<Order> recentOrders = dashboardService.getRecentOrders(10);
            model.addAttribute("recentOrders", recentOrders);

            // Get top products (last 10)
            List<Product> topProducts = dashboardService.getTopProducts(10);
            model.addAttribute("topProducts", topProducts);

            // Get commission summary
            CommissionSummaryDTO commissionStats = dashboardService.getCommissionSummary();
            model.addAttribute("commissionStats", commissionStats);

            // Current date for display
            String currentDate = LocalDateTime.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
            model.addAttribute("currentDate", currentDate);

        } catch (Exception e) {
            // Handle errors gracefully
            model.addAttribute("errorMessage", "Có lỗi khi tải dữ liệu dashboard: " + e.getMessage());
        }

        return "admin/dashboard/show";
    }

}