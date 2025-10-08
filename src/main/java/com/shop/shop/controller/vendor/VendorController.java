package com.shop.shop.controller.vendor;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class VendorController {
    @GetMapping("/vendor")
    public String showDashboard(){
        return "vendor/dashboard/show";
    }
}
