package com.shop.shop.controller.vendor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.shop.domain.Shop;
import com.shop.shop.domain.User;
import com.shop.shop.service.vendor.DashboardService;
import com.shop.shop.service.vendor.ShopService;
import com.shop.shop.util.UserAfterLogin;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class VendorController {

    @Autowired
    private ShopService shopService;

    private final DashboardService dashboardService;
    private final UserAfterLogin userAfterLogin;

    private Long getCurrentShopId() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof User user) {
            return shopService.getShopByUserId(user.getId())
                    .map(Shop::getId)
                    .orElseThrow(() -> new RuntimeException("Shop not found for vendor user"));
        }
        throw new RuntimeException("User not authenticated");
    }

    @GetMapping("/vendor")
    public String showDashboard(Model model) {
        // Get current user from Spring Security context
        User currentUser = userAfterLogin.getUser();
        if (currentUser == null) {
            return "redirect:/login";
        }
        Long shopId = getCurrentShopId();
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
