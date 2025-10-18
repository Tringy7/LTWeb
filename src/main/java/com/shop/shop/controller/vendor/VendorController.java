package com.shop.shop.controller.vendor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.shop.service.vendor.DashboardService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class VendorController {

    private final DashboardService dashboardService;

    @GetMapping("/vendor")
    public String showDashboard(Model model) {
        Long shopId = 1L; 

        long totalProducts = dashboardService.getTotalProducts(shopId);
        long totalVouchers = dashboardService.getTotalVouchers(shopId);
        long totalOrders = dashboardService.getTotalOrders(shopId);
        double totalRevenue = dashboardService.getTotalRevenue(shopId);

        model.addAttribute("totalProducts", totalProducts);
        model.addAttribute("totalVouchers", totalVouchers);
        model.addAttribute("totalOrders", totalOrders);
        model.addAttribute("totalRevenue", totalRevenue);
        return "vendor/dashboard/show";
    }
}
