package com.shop.shop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.Cart;
import com.shop.shop.domain.CartDetail;
import com.shop.shop.domain.User;
import com.shop.shop.domain.UserAddress;
import com.shop.shop.service.client.CartService;
import com.shop.shop.service.client.UserService;
import com.shop.shop.util.UserAfterLogin;

@Controller
public class CartController {

    @Autowired
    private UserAfterLogin userAfterLogin;

    @Autowired
    private UserService userService;

    @Autowired
    private CartService cartService;

    @GetMapping("/cart")
    public String showCart(Model model) {
        User user = userAfterLogin.getUser();
        Cart cart = cartService.getCart(user);
        List<CartDetail> cardDetails = new ArrayList<>();
        if (cart.getCartDetails() != null) {
            cardDetails = cart.getCartDetails();
        } else {
            cart.setCartDetails(cardDetails);
        }
        model.addAttribute("cart", cart);
        return "client/cart/show";
    }

    @PostMapping("/cart")
    public String handleUpdateCart(@ModelAttribute("cart") Cart cartFromForm) {
        cartService.updateCart(cartFromForm);
        return "redirect:/checkout";
    }

    @PostMapping("/cart/delete/{id}")
    public String deleteCartDetail(@PathVariable("id") Long cartDetailId) {
        cartService.deleteCartDetail(cartDetailId);
        return "redirect:/cart";
    }

    @PostMapping("/cart/apply-voucher")
    public String handleVoucher(@RequestParam("voucherCode") String voucherCode, RedirectAttributes redirectAttributes) {
        User user = userAfterLogin.getUser();
        Cart cart = cartService.handleApplyVoucher(voucherCode, user);
        
        if (cart == null) {
            redirectAttributes.addFlashAttribute("error", "Mã voucher không hợp lệ hoặc đã hết hạn!");
        } else {
            redirectAttributes.addFlashAttribute("success", "Áp dụng mã giảm giá thành công!");
        }
        
        return "redirect:/cart";
    }

    @GetMapping("/checkout")
    public String showCheckout(Model model) {
        User user = userAfterLogin.getUser();
        Cart cart = cartService.getCart(user);
        UserAddress userAddress = userService.handlUserAddress(user);
        model.addAttribute("user", user);
        model.addAttribute("cart", cart);

        return "client/cart/checkout";
    }

    @PostMapping("/checkout")
    public String handleCheckout(@RequestParam("paymentMethod") String payment, RedirectAttributes redirectAttributes) {
        User currentUser = userAfterLogin.getUser();
        if (currentUser == null) {
            return "redirect:/login";
        }
        boolean isSuccess = cartService.handleCheckout(currentUser, payment);
        if (isSuccess) {
            return "client/cart/success";
        }
        redirectAttributes.addFlashAttribute("error", "Thanh toán không thành công, vui lòng thử lại!");
        return "redirect:/checkout";
    }

    @GetMapping("/success")
    public String success() {
        return "client/cart/success";
    }
}
