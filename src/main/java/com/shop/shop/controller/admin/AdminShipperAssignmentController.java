package com.shop.shop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.Carrier;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.domain.Shipper;
import com.shop.shop.service.admin.ShipperAssignmentService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/shipper-assignment")
@RequiredArgsConstructor
public class AdminShipperAssignmentController {

    private final ShipperAssignmentService shipperAssignmentService;

    @GetMapping
    public String showShipperAssignmentPage(Model model) {
        try {
            // Get all carriers with their statistics
            List<Carrier> carriers = shipperAssignmentService.getAllCarriersWithStats();
            model.addAttribute("carriers", carriers);

            // Get order details that need assignment
            List<OrderDetail> unassignedOrders = shipperAssignmentService
                    .getOrderDetailsNeedingAssignment("CONFIRMED");
            model.addAttribute("unassignedOrders", unassignedOrders);

            // Group unassigned orders by carrier for display
            model.addAttribute("hasUnassignedOrders", !unassignedOrders.isEmpty());

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi khi tải dữ liệu: " + e.getMessage());
        }

        return "admin/shipper/assignment";
    }

    @GetMapping("/carrier")
    public String showCarrierDetails(@RequestParam("carrierId") Long carrierId, Model model) {
        try {
            // Get available shippers for this carrier
            List<Shipper> availableShippers = shipperAssignmentService
                    .getAvailableShippersForCarrier(carrierId);
            model.addAttribute("availableShippers", availableShippers);

            // Get unassigned order details for this carrier
            List<OrderDetail> unassignedOrders = shipperAssignmentService
                    .getUnassignedOrderDetailsForCarrier(carrierId);
            model.addAttribute("unassignedOrders", unassignedOrders);

            model.addAttribute("carrierId", carrierId);

        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi khi tải dữ liệu carrier: " + e.getMessage());
        }

        return "admin/shipper/carrier-details";
    }

    @PostMapping("/assign")
    public String assignShipperToOrder(
            @RequestParam("orderDetailId") Long orderDetailId,
            @RequestParam("shipperId") Long shipperId,
            @RequestParam(value = "carrierId", required = false) Long carrierId,
            RedirectAttributes redirectAttributes) {

        try {
            OrderDetail assignedOrder = shipperAssignmentService
                    .assignShipperToOrderDetail(orderDetailId, shipperId);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Đã phân công shipper thành công cho đơn hàng #" + assignedOrder.getId());

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Có lỗi khi phân công shipper: " + e.getMessage());
        }

        if (carrierId != null) {
            return "redirect:/admin/shipper-assignment/carrier?carrierId=" + carrierId;
        }
        return "redirect:/admin/shipper-assignment";
    }

    @PostMapping("/auto-assign/carrier")
    public String autoAssignForCarrier(
            @RequestParam("carrierId") Long carrierId,
            RedirectAttributes redirectAttributes) {

        try {
            List<OrderDetail> assignedOrders = shipperAssignmentService
                    .autoAssignShippersForCarrier(carrierId);

            redirectAttributes.addFlashAttribute("successMessage",
                    "Đã tự động phân công " + assignedOrders.size() + " đơn hàng cho carrier");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Có lỗi khi tự động phân công: " + e.getMessage());
        }

        return "redirect:/admin/shipper-assignment/carrier?carrierId=" + carrierId;
    }

    @PostMapping("/auto-assign/all")
    public String autoAssignAllOrders(RedirectAttributes redirectAttributes) {
        try {
            shipperAssignmentService.autoAssignAllUnassignedOrders();

            redirectAttributes.addFlashAttribute("successMessage",
                    "Đã tự động phân công tất cả đơn hàng chưa có shipper");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Có lỗi khi tự động phân công tất cả: " + e.getMessage());
        }

        return "redirect:/admin/shipper-assignment";
    }
}
