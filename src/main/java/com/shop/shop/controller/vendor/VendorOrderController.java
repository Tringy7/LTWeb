package com.shop.shop.controller.vendor;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.shop.shop.domain.Order;
import com.shop.shop.domain.Shop;
import com.shop.shop.domain.User;
import com.shop.shop.dto.OrderDetailDTO;
import com.shop.shop.service.vendor.OrderDetailService;
import com.shop.shop.service.vendor.OrderService;
import com.shop.shop.service.vendor.ShopService;

@Controller
@RequestMapping("/vendor/order")
public class VendorOrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    private ShopService shopService;

    private Long getCurrentShopId() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof User user) {
            return shopService.getShopByUserId(user.getId())
                    .map(Shop::getId)
                    .orElseThrow(() -> new RuntimeException("Shop not found for vendor user"));
        }
        throw new RuntimeException("User not authenticated");
    }

    // --- Hiển thị danh sách đơn hàng ---
    @GetMapping
    public String getOrderList(
            @RequestParam(required = false) String status,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate fromDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate toDate,
            Model model) {

        Long shopId = getCurrentShopId();

        LocalDateTime startDateTime = (fromDate != null) ? fromDate.atStartOfDay() : null;
        LocalDateTime endDateTime = (toDate != null) ? toDate.atTime(LocalTime.MAX) : null;

        // Lọc đơn hàng theo chi tiết (vì Order không có cột status)
        List<Order> orders = orderService.getOrdersByShopThroughDetails(shopId, status, startDateTime, endDateTime);

        model.addAttribute("orders", orders);
        model.addAttribute("status", status);
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("toDate", toDate);
        model.addAttribute("shop", shopService.findById(shopId));
        return "vendor/order/show";
    }

    // --- Lọc theo trạng thái ---
    @GetMapping("/filter")
    public String filterOrders(@RequestParam(required = false) String status,
            @RequestParam("shop_id") Long shopId,
            Model model) {
        List<Order> orders;
        if (status == null || status.isEmpty()) {
            orders = orderService.findByShopId(shopId);
        } else {
            orders = orderService.findByShopIdAndStatus(shopId, status);
        }
        model.addAttribute("orders", orders);
        model.addAttribute("status", status);
        model.addAttribute("shop", shopService.findById(shopId));
        return "vendor/order/show";
    }

    // --- Trang chi tiết đơn hàng ---
    @GetMapping("/detail/{orderId}")
    public String showOrderDetailPage(@PathVariable Long orderId, Model model) {
        Long shopId = getCurrentShopId();

        Order order = orderService.getOrderById(orderId);
        if (order == null) {
            return "redirect:/vendor/order?error=notfound";
        }

        List<OrderDetailDTO> dtoList = orderDetailService.getOrderDetailsByOrderIdAndShopId(orderId, shopId);

        model.addAttribute("order", order);
        model.addAttribute("orderDetails", dtoList);

        return "vendor/order/order-detail";
    }

    // --- Xuất PDF ---
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

            // Lọc đơn qua orderDetails
            List<Order> orders = orderService.getOrdersByShopThroughDetails(shopId, status, startDateTime, endDateTime);
            String filePath = orderService.exportOrdersToPDF(orders);

            response.put("status", "success");
            response.put("message", "Đã xuất file PDF danh sách lọc tại: " + filePath);
        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Lỗi khi xuất file: " + e.getMessage());
        }
        return response;
    }

    // --- Cập nhật trạng thái đơn hàng ---
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

            // // Vì Order không có field status → ta cập nhật trạng thái qua OrderDetail
            // boolean updated = orderService.updateOrderStatusByDetails(orderId, status);

            // if (updated) {
            // response.put("status", "success");
            // response.put("message", "Cập nhật trạng thái đơn hàng thành công!");
            // } else {
            // response.put("status", "error");
            // response.put("message", "Không tìm thấy đơn hàng cần cập nhật!");
            // }

        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Lỗi: " + e.getMessage());
        }

        return response;
    }

    // --- Cập nhật trạng thái chi tiết đơn hàng ---
    @PostMapping("/order-detail/update-status")
    @ResponseBody
    public Map<String, Object> updateOrderDetailStatus(
            @RequestParam("detailId") Long detailId,
            @RequestParam("status") String status) {

        Map<String, Object> response = new HashMap<>();

        try {
            if (detailId == null || status == null || status.trim().isEmpty()) {
                response.put("status", "error");
                response.put("message", "Thiếu thông tin chi tiết đơn hoặc trạng thái!");
                return response;
            }

            boolean updated = orderDetailService.updateOrderDetailStatus(detailId, status);

            if (updated) {
                response.put("status", "success");
                response.put("message", "Cập nhật trạng thái chi tiết đơn hàng thành công!");
            } else {
                response.put("status", "error");
                response.put("message", "Không tìm thấy chi tiết đơn hàng cần cập nhật!");
            }

        } catch (Exception e) {
            response.put("status", "error");
            response.put("message", "Lỗi: " + e.getMessage());
        }

        return response;
    }

}
