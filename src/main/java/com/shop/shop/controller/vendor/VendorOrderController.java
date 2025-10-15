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

import com.shop.shop.DTO.OrderDetailDTO;
import com.shop.shop.domain.Order;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.service.vendor.OrderDetailService;
import com.shop.shop.service.vendor.OrderService;

@Controller
@RequestMapping("/vendor/order")
public class VendorOrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private OrderDetailService orderDetailService;

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

        // Chuyển LocalDate sang LocalDateTime để tương thích với repository
        LocalDateTime startDateTime = (fromDate != null) ? fromDate.atStartOfDay() : null;
        LocalDateTime endDateTime = (toDate != null) ? toDate.atTime(LocalTime.MAX) : null;

        List<Order> orders = orderService.filterOrdersByShop(shopId, status, startDateTime, endDateTime);

        model.addAttribute("orders", orders);
        model.addAttribute("status", status);
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("toDate", toDate);
        return "vendor/order/show";
    }

    @GetMapping("/detail/{orderId}")
    public String showOrderDetailPage(@PathVariable Long orderId, Model model) {
        Long shopId = getCurrentShopId();

        Order order = orderService.getOrderById(orderId);
        if (order == null) {
            return "redirect:/vendor/orders?error=notfound";
        }

        List<OrderDetail> details = orderDetailService.getOrderDetailsByOrderIdAndShopId(orderId, shopId);
        List<OrderDetailDTO> dtoList = new ArrayList<>();

        for (OrderDetail d : details) {
            OrderDetailDTO dto = new OrderDetailDTO();
            dto.setProductId(d.getProduct().getId());
            dto.setProductName(d.getProduct().getName());
            dto.setShopName(d.getShop().getShopName());
            dto.setQuantity(d.getQuantity());
            dto.setPrice(d.getPrice());
            dto.setImage(d.getProduct().getImage());
            dtoList.add(dto);
        }

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
}
