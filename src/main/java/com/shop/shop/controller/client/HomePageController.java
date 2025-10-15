package com.shop.shop.controller.client;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.shop.domain.Order;
import com.shop.shop.domain.User;
import com.shop.shop.service.client.ProductService;
import com.shop.shop.service.client.UserService;
import com.shop.shop.util.UserAfterLogin;

@Controller
public class HomePageController {

    @Autowired
    private ProductService productService;

    @Autowired
    private UserAfterLogin userAfterLogin;

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String showHomePage(Model model) {
        model.addAttribute("productTop", productService.getProductTopSold());
        model.addAttribute("productSoldOver10", productService.getAllProductSoldOver10());
        model.addAttribute("productList", productService.getAllProduct());
        return "client/homepage/show";
    }

    @GetMapping("/contact")
    @ResponseBody
    public String show() {
        return "Contact Page - Under construction";
    }

    @GetMapping("/order")
    public String showOrder(Model model) {
        User currentUser = userAfterLogin.getUser();
        if (currentUser == null) {
            return "redirect:/login";
        }
        // Lấy lại user từ DB trong một transaction để load được orders và orderDetails
        User userWithOrders = userService.findById(currentUser.getId());
        List<Order> orders = userWithOrders.getOrders();
        if (orders != null && !orders.isEmpty()) {
            // Sắp xếp đơn hàng theo ngày tạo, mới nhất lên đầu
            orders = orders.stream()
                    .sorted((o1, o2) -> o2.getCreatedAt().compareTo(o1.getCreatedAt()))
                    .collect(Collectors.toList());
        }
        model.addAttribute("orders", orders != null ? orders : Collections.emptyList());
        return "client/homepage/order";
    }

}
