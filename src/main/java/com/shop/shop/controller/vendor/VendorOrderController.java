package com.shop.shop.controller.vendor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.shop.shop.domain.Order;
import com.shop.shop.dto.OrderDetailDTO;
import com.shop.shop.service.vendor.OrderDetailService;
import com.shop.shop.service.vendor.OrderService;

@Controller
@RequestMapping("/vendor/order")
public class VendorOrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderDetailService orderDetailService;

    // Tạm thời giả lập shop đang đăng nhập
    private Long getCurrentShopId() {
        return 1L;
    }

    @GetMapping
    public String getOrderList(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate,
            Model model) {

        Long shopId = getCurrentShopId();

        LocalDateTime startDateTime = (fromDate != null) ? fromDate.atStartOfDay() : null;
        LocalDateTime endDateTime = (toDate != null) ? toDate.atTime(LocalTime.MAX) : null;

        List<Order> orders = orderService.filterOrdersByShop(shopId, status, startDateTime, endDateTime);

        model.addAttribute("orders", orders);
        model.addAttribute("status", status);
        model.addAttribute("toDate", toDate);
        return "vendor/order/show";
    }

    @GetMapping("/filter")
    public String filterOrdersByStatus(
            @RequestParam(value = "status", required = false) String status,
            Model model) {

        Long shopId = getCurrentShopId();
        List<Order> orders;

        if (status == null || status.isEmpty()) {
            orders = orderService.getOrdersByShopId(shopId);
        } else {
            orders = orderService.getOrdersByShopIdAndStatus(shopId, status.toUpperCase());
        }

        model.addAttribute("orders", orders);
        model.addAttribute("status", status);
        return "vendor/order/show";
    }

    @GetMapping("/detail/{orderId}")
    public String showOrderDetailPage(@PathVariable Long orderId, Model model) {
        Long shopId = getCurrentShopId();

        Order order = orderService.getOrderById(orderId);
        if (order == null) {
            return "redirect:/vendor/orders?error=notfound";
        }

        List<OrderDetailDTO> dtoList = orderDetailService.getOrderDetailsByOrderIdAndShopId(orderId, shopId);

        model.addAttribute("order", order);
        model.addAttribute("orderDetails", dtoList);

        return "vendor/order/order-detail";
    }

    @GetMapping("/export")
    @ResponseBody
    public Map<String, String> exportFilteredOrdersToPDF(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate) {

        Map<String, String> response = new HashMap<>();
        Long shopId = getCurrentShopId();

        try {
            LocalDateTime startDateTime = (fromDate != null) ? fromDate.atStartOfDay() : null;
            LocalDateTime endDateTime = (toDate != null) ? toDate.atTime(LocalTime.MAX) : null;

            List<Order> orders = orderService.filterOrdersByShop(shopId, status, startDateTime, endDateTime);
            String filePath = orderService.exportOrdersToPDF(orders);

            response.put("status", "success");
            response.put("message", "Đã xuất file PDF danh sách lọc tại: " + filePath);
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Lỗi khi xuất file: " + e.getMessage());
        }
        return response;
    }

    @PostMapping("/update-status")
    @ResponseBody
    public Map<String, Object> updateOrderStatus(
            @RequestParam("orderId") Long orderId,
            @RequestParam("status") String status) {

        Map<String, Object> response = new HashMap<>();

        try {
            if (orderId == null || status == null || status.trim().isEmpty()) {
                response.put("status", "error");
                response.put("message", "Thiếu thông tin orderId hoặc status!");
                return response;
            }

            boolean updated = orderService.updateOrderStatus(orderId, status);

            if (updated) {
                response.put("status", "success");
                response.put("message", "Cập nhật trạng thái thành công!");
            } else {
                response.put("status", "error");
                response.put("message", "Không tìm thấy đơn hàng cần cập nhật!");
            }

        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Lỗi: " + e.getMessage());
        }

        return response;
    }

}
