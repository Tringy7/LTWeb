package com.shop.shop.controller.shipper;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.OrderDetail;
import com.shop.shop.domain.Shipper;
import com.shop.shop.domain.User;
import com.shop.shop.service.shipper.ShipperOrderDetailService;
import com.shop.shop.service.shipper.ShipperService;
import com.shop.shop.service.vendor.OrderDetailService;

@Controller
public class ShipperShippingController {

    @Autowired
    private ShipperOrderDetailService orderDetailService;

    @Autowired
    private ShipperService shipperService;

    private Long getCurrentShipperId() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof User user) {
            return shipperService.getShipperByUserId(user.getId())
                    .map(Shipper::getId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy Shipper cho user hiện tại"));
        }
        throw new RuntimeException("User chưa đăng nhập");
    }

    @GetMapping("/shipper/shipping")
    public String show(@RequestParam(value = "selectedId", required = false) Long selectedId, Model model) {
        Long shipperId = getCurrentShipperId();
        List<OrderDetail> shippingOrders = orderDetailService.getShippingOrdersByShipper(shipperId);
        model.addAttribute("orders", shippingOrders);
        model.addAttribute("today", LocalDate.now());

        if (selectedId != null) {
            orderDetailService.getOrderDetailById(selectedId)
                    .ifPresent(selectedOrder -> model.addAttribute("selectedOrder", selectedOrder));
        }

        // Dữ liệu bản đồ (cố định tạm)
        model.addAttribute("origin", "106.765547,10.849995");
        model.addAttribute("destination", "01 Đ. Võ Văn Ngân, Linh Chiểu, Thủ Đức, TP. Hồ Chí Minh, Việt Nam");

        return "/shipper/shipping/show";
    }

    @GetMapping("/shipper/shipping/detail/{id}")
    public String showOrderDetail(@PathVariable Long id, Model model) {
        Long shipperId = getCurrentShipperId();
        List<OrderDetail> shippingOrders = orderDetailService.getShippingOrdersByShipper(shipperId);
        OrderDetail selectedOrder = orderDetailService.getOrderDetailById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng"));

        model.addAttribute("orders", shippingOrders);
        model.addAttribute("selectedOrder", selectedOrder);
        model.addAttribute("today", LocalDate.now());

        // Dữ liệu bản đồ — có thể cập nhật theo địa chỉ của đơn hàng
        String origin = "Đ. số 10, Dĩ An, TP. Hồ Chí Minh";
        String destination = selectedOrder.getAddress().getReceiverAddress();
        model.addAttribute("origin", origin);
        model.addAttribute("destination", destination);

        return "/shipper/shipping/show";
    }

    @GetMapping("/shipper/shipping/complete/{id}")
    public String completeOrder(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        orderDetailService.updateOrderStatus(id, "DELIVERED");
        redirectAttributes.addFlashAttribute("success", "Giao hàng thành công!");
        return "redirect:/shipper/shipping";
    }

}
