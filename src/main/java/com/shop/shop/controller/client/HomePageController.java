package com.shop.shop.controller.client;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.Order;
import com.shop.shop.domain.Shop;
import com.shop.shop.domain.User;
import com.shop.shop.domain.Voucher;
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

    @PostMapping("/order/cancel/{id}")
    public String cancelOrder(@PathVariable("id") Long orderId) {
        boolean check = userService.handleDeleteOrder(orderId);
        return "redirect:/order";
    }

    @GetMapping("/account")
    public String showAccount(Model model) {
        User currentUser = userAfterLogin.getUser();
        if (currentUser == null) {
            return "redirect:/login";
        }
        // model.addAttribute("receiver", userService.handlUserAddress(currentUser));
        model.addAttribute("user", currentUser);
        return "client/homepage/account";
    }

    @PostMapping("/account/update-info")
    public String handleUpdateAccount(@ModelAttribute User user,
            @RequestParam("avatarFile") MultipartFile avatarFile,
            RedirectAttributes redirectAttributes) {
        User userInSession = userAfterLogin.getUser();
        if (userInSession == null) {
            return "redirect:/login";
        }
        user.setId(userInSession.getId());

        // Cập nhật thông tin user
        userService.handleUpdateAccount(user, avatarFile);

        // Cập nhật địa chỉ nhận hàng
        if (user.getReceiver() != null) {
            userService.handleReceiverUser(userInSession, user.getReceiver());
        }

        userAfterLogin.updateUserInSession(user.getId());

        redirectAttributes.addFlashAttribute("successMessage", "Cập nhật thông tin thành công!");
        return "redirect:/account";
    }

    @GetMapping("/voucher")
    public String showVoucher(Model model) {
        User currentUser = userAfterLogin.getUser();
        List<Voucher> voucher = userService.getVoucherForUser(currentUser);
        model.addAttribute("vouchers", voucher);
        return "client/homepage/voucher";
    }

    @GetMapping("/about")
    public String showAbout() {
        return "client/homepage/about";
    }

    @GetMapping("/registraion-sales")
    public String showVendorRegistration(Model model) {
        User user = userAfterLogin.getUser();
        if (user == null) {
            return "redirect:/login";
        }

        Shop shop = userService.getShop(user);

        model.addAttribute("shop", shop);
        return "client/homepage/registraionSale";
    }

    @PostMapping("/registraion-sales")
    public String handleVendorRegistration(@ModelAttribute("shop") Shop shop, RedirectAttributes redirectAttributes,
            Model model) {

        User user = userAfterLogin.getUser();
        if (user == null) {
            return "redirect:/login";
        }

        // Xử lý đăng ký vendor
        try {
            userService.handleVendorRegistration(shop, user);
            redirectAttributes.addFlashAttribute("successMessage", "Đăng ký bán hàng thành công! Chúng tôi sẽ xem xét và phản hồi sớm.");
            return "redirect:/registraion-sales";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Đăng ký không thành công");
            model.addAttribute("shop", shop);
            return "client/homepage/registraionSale";
        }
    }
}
