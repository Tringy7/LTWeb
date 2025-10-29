package com.shop.shop.controller.shipper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.shop.domain.Shipper;
import com.shop.shop.domain.User;
import com.shop.shop.service.shipper.ShipperOrderDetailService;
import com.shop.shop.service.shipper.ShipperService;
import com.shop.shop.service.vendor.OrderDetailService;

@Controller
public class ShipperController {

    @Autowired
    private ShipperOrderDetailService orderDetailService;

    @Autowired
    private ShipperService shipperService;

    @GetMapping("/shipper")
    public String showDashboard(Model model) {
        Long shipperId = getCurrentShipperId();

        Long confirmedCount = orderDetailService.countByStatusAndShipper("CONFIRMED", shipperId);
        Long shippingCount = orderDetailService.countByStatusAndShipper("SHIPPING", shipperId);
        Long deliveredCount = orderDetailService.countByStatusAndShipper("DELIVERED", shipperId);
        Long returnedCount = orderDetailService.countByStatusAndShipper("RETURNED", shipperId);

        model.addAttribute("failedCount", confirmedCount); // "Chờ xác nhận"
        model.addAttribute("shippingCount", shippingCount);
        model.addAttribute("deliveredCount", deliveredCount);
        model.addAttribute("returnedCount", returnedCount);

        return "shipper/dashboard/show";
    }

    private Long getCurrentShipperId() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof User user) {
            return shipperService.getShipperByUserId(user.getId())
                    .map(Shipper::getId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy Shipper cho user hiện tại"));
        }
        throw new RuntimeException("User chưa đăng nhập");
    }
}
