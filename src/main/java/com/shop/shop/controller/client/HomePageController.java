package com.shop.shop.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.shop.shop.service.client.ProductService;

@Controller
public class HomePageController {

    @Autowired
    private ProductService productService;

    @GetMapping("/")
    public String showHomePage(Model model) {
        model.addAttribute("productTop", productService.getProductTopSold());
        model.addAttribute("productSoldOver10", productService.getAllProductSoldOver10());
        model.addAttribute("productList", productService.getAllProduct());
        return "client/homepage/show";
    }
}
