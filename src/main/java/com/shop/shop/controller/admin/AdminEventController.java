package com.shop.shop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class AdminEventController {

    @GetMapping("/admin/event")
    public String show() {
        return "admin/event/show";
    }
    
}
