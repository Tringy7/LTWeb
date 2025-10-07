package com.shop.shop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class AdminUserController {
    @GetMapping("/admin/user")
    public String show() {
        return "admin/user/show";
    }
    
    
}
