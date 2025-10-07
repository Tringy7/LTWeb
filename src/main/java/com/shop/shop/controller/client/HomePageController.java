package com.shop.shop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomePageController {
    
    @GetMapping("/")
    public String showHomePage() {
        return "client/homepage/show";
    }
}
