package com.shop.shop.controller.vendor;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;


@Controller
public class VendorEventController {

    @GetMapping("/vendor/event")
    public String show() {
        return "vendor/event/show";
    }
    
}