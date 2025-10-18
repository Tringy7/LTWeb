package com.shop.shop.controller.vendor;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.shop.domain.User;
import com.shop.shop.service.vendor.DashboardService;
import com.shop.shop.util.UserAfterLogin;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class VendorController {

    private final DashboardService dashboardService;
    private final UserAfterLogin userAfterLogin;

    @GetMapping("/vendor")
    public String showDashboard(Model model) {
        // Get current user from Spring Security context
        User currentUser = userAfterLogin.getUser();
        if (currentUser == null) {
            return "redirect:/login";
        }

        // You can now use user info, for example to get shopId
        Long shopId = 1L; // Replace with actual logic to get shopId from user

        // If you have shop relationship in User entity:
        // Long shopId = currentUser != null && currentUser.getShop() != null 
        //               ? currentUser.getShop().getId() : 1L;
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
