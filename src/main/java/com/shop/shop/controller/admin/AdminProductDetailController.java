package com.shop.shop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminProductDetailController {

    @GetMapping("/admin/product/detail")
    public String getMethodName() {
        return "admin/product/detail";
    }

}
