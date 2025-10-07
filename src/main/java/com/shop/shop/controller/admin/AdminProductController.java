package com.shop.shop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminProductController {

    @GetMapping("/admin/product")
    public String showProduct() {
        return "admin/product/show";
    }

}
