package com.shop.shop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminOrderDetail {
    @GetMapping("admin/order/detail")
    public String showOrderDetail() {
        return "admin/order/detail";
    }
}
