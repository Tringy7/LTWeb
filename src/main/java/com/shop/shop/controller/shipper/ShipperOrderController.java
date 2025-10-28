package com.shop.shop.controller.shipper;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.Order;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.domain.Shipper;
import com.shop.shop.domain.User;
import com.shop.shop.repository.OrderRepository;
import com.shop.shop.service.shipper.ShipperOrderService;
import com.shop.shop.service.shipper.ShipperService;

@Controller
public class ShipperOrderController {

    @Autowired
    private ShipperOrderService shipperOrderService;

    @Autowired
    private ShipperService shipperService;

    @Autowired
    private OrderRepository orderRepository;

    @GetMapping("/shipper/order")
    public String showDashboard(Model model) {
        Long shipperId = getCurrentShipperId();
        List<OrderDetail> orders = shipperOrderService.getOrdersByShipperId(shipperId);
        model.addAttribute("orders", orders);
        return "shipper/order/show";
    }

    private Long getCurrentShipperId() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof User user) {
            return shipperService.getShipperByUserId(user.getId())
                    .map(Shipper::getId)
                    .orElseThrow(() -> new RuntimeException("Không tìm thấy Shipper cho user hiện tại"));
        }
        throw new RuntimeException("User chưa đăng nhập");
    }

    @GetMapping("/shipper/order/detail/{id}")
    public String viewOrderDetail(@PathVariable("id") Long id, Model model) {
        Order order = orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy đơn hàng có ID = " + id));

        model.addAttribute("order", order);
        model.addAttribute("orderDetails", order.getOrderDetails());
        return "shipper/order/order-detail";
    }

    @GetMapping("/shipper/order/start/{id}")
    public String startShipping(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        shipperOrderService.updateOrderStatus(id, "SHIPPING");
        redirectAttributes.addFlashAttribute("success", "Bắt đầu giao hàng thành công!");
        return "redirect:/shipper/order";
    }

    @GetMapping("/shipper/order/complete/{id}")
    public String completeOrder(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        shipperOrderService.updateOrderStatus(id, "DELIVERED");
        redirectAttributes.addFlashAttribute("success", "Giao hàng thành công!");
        return "redirect:/shipper/order";
    }

    @GetMapping("/shipper/order/finish/{id}")
    public String finishOrder(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        shipperOrderService.updateOrderStatus(id, "RETURNED");
        redirectAttributes.addFlashAttribute("success", "Đơn hàng đã hoàn tất!");
        return "redirect:/shipper/order";
    }

    @GetMapping("/shipper/order/return-reason/{id}")
    public String showReturnReason(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        // Ở đây có thể redirect sang trang chi tiết hoặc modal lý do trả hàng
        return "redirect:/shipper/order/detail/" + id;
    }
}
