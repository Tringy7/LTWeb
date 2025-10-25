package com.shop.shop.controller.client;

import java.util.ArrayList;

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
import com.shop.shop.domain.Order;
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
        if (cart.getCartDetails() == null) {
            cart.setCartDetails(new ArrayList<>());
        }

        model.addAttribute("cart", cart);
        return "client/cart/show";
    }

    @PostMapping("/cart")
    public String handleUpdateCart(@ModelAttribute("cart") Cart cartFromForm) {
        Long orderId = cartService.updateCart(cartFromForm);
        return "redirect:/checkout?orderId=" + orderId;
    }

    @PostMapping("/cart/delete/{id}")
    public String deleteCartDetail(@PathVariable("id") Long cartDetailId) {
        cartService.deleteCartDetail(cartDetailId);
        return "redirect:/cart";
    }

    @PostMapping("/checkout/apply-voucher")
    public String handleVoucher(@RequestParam("voucherCode") String voucherCode, RedirectAttributes redirectAttributes) {
        User user = userAfterLogin.getUser();
        Order order = cartService.handleApplyVoucherToOrder(voucherCode, user);
        if (order == null) {
            // Mã voucher không hợp lệ hoặc không có order - hủy voucher trên order (best-effort)
            cartService.handleRemoveVoucherFromOrder(user);
            redirectAttributes.addFlashAttribute("error", "Mã voucher không hợp lệ hoặc đã hết hạn!");
            return "redirect:/cart";
        } else {
            // Voucher is stored on the Order; read discountPercent from order.voucher
            Double discountPercent = null;
            if (order.getVoucher() != null && voucherCode.equals(order.getVoucher().getCode())) {
                discountPercent = order.getVoucher().getDiscountPercent();
            }

            redirectAttributes.addFlashAttribute("success", "Áp dụng mã giảm giá thành công!");
            redirectAttributes.addFlashAttribute("voucherCodeApplied", voucherCode);
            if (discountPercent != null) {
                redirectAttributes.addFlashAttribute("discountPercent", discountPercent);
            }
            return "redirect:/checkout?orderId=" + order.getId();
        }
    }

    @PostMapping("/checkout/remove-voucher")
    public String handleRemoveVoucher(RedirectAttributes redirectAttributes) {
        User user = userAfterLogin.getUser();
        Order order = cartService.handleRemoveVoucherFromOrder(user);
        if (order != null) {
            redirectAttributes.addFlashAttribute("success", "Đã hủy mã giảm giá thành công!");
            return "redirect:/checkout?orderId=" + order.getId();
        } else {
            redirectAttributes.addFlashAttribute("error", "Không thể hủy mã giảm giá!");
            return "redirect:/cart";
        }
    }

    @GetMapping("/checkout")
    public String showCheckout(@RequestParam(value = "orderId", required = false) Long orderId, Model model) {
        User user = userAfterLogin.getUser();

        // Kiểm tra xem orderId có tồn tại không
        if (orderId == null) {
            return "redirect:/cart";
        }

        Order order = userService.getOrderById(orderId);
        if (order == null) {
            return "redirect:/cart";
        }

        model.addAttribute("order", order);
        model.addAttribute("user", user);

        // Kiểm tra xem đơn hàng đã thanh toán chưa
        if (order.getPaymentStatus()) {
            model.addAttribute("isPaid", true);
        }

        return "client/cart/checkout";
    }

    @PostMapping("/checkout")
    public String handleCheckout(@RequestParam("paymentMethod") String payment, RedirectAttributes redirectAttributes, @ModelAttribute("user") User user) {
        User currentUser = userAfterLogin.getUser();
        if (currentUser == null) {
            return "redirect:/login";
        }
        boolean isSuccess = cartService.handleCheckout(currentUser, payment);
        UserAddress receicer = user.getReceiver();
        userService.handleReceiverUser(currentUser, receicer);
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
