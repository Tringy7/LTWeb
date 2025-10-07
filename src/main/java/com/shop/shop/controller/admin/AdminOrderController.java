package com.shop.shop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminOrderController {

    @GetMapping("/admin/order")
    public String show() {
        return "admin/order/show";
    }

}
