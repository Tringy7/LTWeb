package com.shop.shop.controller.shipper;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ShipperShippingController {
    @GetMapping("/shipper/shipping")
    public String show(Model model) {
        // Địa chỉ kho mặc định
        String origin = "106.765547,10.849995"; // Tọa độ: Long,Lat

        // Địa chỉ người nhận (ví dụ dữ liệu mẫu)
        String destination = "Milton St 104, Edinburgh";

        model.addAttribute("origin", origin);
        model.addAttribute("destination", destination);
        return "/shipper/shipping/show";
    }
}
