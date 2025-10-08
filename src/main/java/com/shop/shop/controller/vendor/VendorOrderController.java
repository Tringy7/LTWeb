package com.shop.shop.controller.vendor;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class VendorOrderController {

    @GetMapping("/vendor/order")
    public String show() {
        return "vendor/order/show";
    }

}
