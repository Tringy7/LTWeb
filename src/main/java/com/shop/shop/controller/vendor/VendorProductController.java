package com.shop.shop.controller.vendor;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class VendorProductController {

    @GetMapping("/vendor/product")
    public String showProduct() {
        return "vendor/product/show";
    }

}
