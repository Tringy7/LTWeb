package com.shop.shop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminCustomerController {

    @GetMapping("/admin/customer")
    public String show() {
        return "admin/customer/show";
    }

}
