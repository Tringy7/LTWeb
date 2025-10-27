package com.shop.shop.controller.admin;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.dto.CommissionCalculationRequestDTO;
import com.shop.shop.dto.CommissionResponseDTO;
import com.shop.shop.dto.CommissionSummaryDTO;
import com.shop.shop.service.admin.CommissionService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AdminCommissionController {

    private final CommissionService commissionService;

    @GetMapping("/admin/commission")
    public String showCommissions(Model model) {
        // Get current month's commissions by default
        LocalDate now = LocalDate.now();
        LocalDate firstOfMonth = now.withDayOfMonth(1);
        LocalDate lastOfMonth = now.withDayOfMonth(now.lengthOfMonth());

        List<CommissionResponseDTO> commissions = commissionService.getCommissionsByDateRange(firstOfMonth,
                lastOfMonth);
        CommissionSummaryDTO summary = commissionService.getCommissionSummary(firstOfMonth, lastOfMonth);

        model.addAttribute("commissions", commissions);
        model.addAttribute("summary", summary);
        // Use string formatting for HTML date inputs
        model.addAttribute("fromDate", firstOfMonth.toString()); // Returns "2025-10-01" format
        model.addAttribute("toDate", lastOfMonth.toString()); // Returns "2025-10-31" format
        model.addAttribute("calculationRequest", new CommissionCalculationRequestDTO());

        return "admin/commission/show";
    }

    @PostMapping("/admin/commission/calculate")
    public String calculateCommissions(@ModelAttribute CommissionCalculationRequestDTO request,
            RedirectAttributes redirectAttributes) {
        try {
            List<CommissionResponseDTO> calculatedCommissions = commissionService.calculateCommissions(request);

            if (calculatedCommissions.isEmpty()) {
                redirectAttributes.addFlashAttribute("warningMessage",
                        "Không tìm thấy dữ liệu hoặc hoa hồng đã được tính toán cho khoảng thời gian này.");
            } else {
                redirectAttributes.addFlashAttribute("successMessage",
                        "Đã tính toán thành công hoa hồng cho " + calculatedCommissions.size() + " cửa hàng.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Có lỗi xảy ra khi tính toán hoa hồng: " + e.getMessage());
        }

        return "redirect:/admin/commission";
    }

    @PostMapping("/admin/commission/calculate-this-month")
    public String calculateThisMonthCommissions(RedirectAttributes redirectAttributes) {
        try {
            List<CommissionResponseDTO> calculatedCommissions = commissionService.calculateThisMonthCommissions();

            if (calculatedCommissions.isEmpty()) {
                redirectAttributes.addFlashAttribute("warningMessage",
                        "Không tìm thấy dữ liệu hoặc hoa hồng tháng này đã được tính toán.");
            } else {
                redirectAttributes.addFlashAttribute("successMessage",
                        "Đã tính toán thành công hoa hồng tháng này cho " + calculatedCommissions.size()
                                + " cửa hàng.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Có lỗi xảy ra khi tính toán hoa hồng: " + e.getMessage());
        }

        return "redirect:/admin/commission";
    }

    @PostMapping("/admin/commission/calculate-up-to-now")
    public String calculateCommissionsUpToNow(RedirectAttributes redirectAttributes) {
        try {
            // Create a request to calculate commissions from January 2020 to now
            LocalDate startDate = LocalDate.of(2020, 1, 1);
            LocalDate endDate = LocalDate.now();
            CommissionCalculationRequestDTO request = new CommissionCalculationRequestDTO(startDate, endDate, true);

            List<CommissionResponseDTO> calculatedCommissions = commissionService.calculateCommissions(request);

            if (calculatedCommissions.isEmpty()) {
                redirectAttributes.addFlashAttribute("warningMessage",
                        "Không tìm thấy dữ liệu mới để tính toán hoa hồng.");
            } else {
                redirectAttributes.addFlashAttribute("successMessage",
                        "Đã tính toán thành công hoa hồng cho " + calculatedCommissions.size() + " cửa hàng.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Có lỗi xảy ra khi tính toán hoa hồng: " + e.getMessage());
        }

        return "redirect:/admin/commission";
    }

    @GetMapping("/admin/commission/search")
    public String searchCommissions(@RequestParam("fromDate") String fromDateStr,
            @RequestParam("toDate") String toDateStr, Model model) {
        try {
            LocalDate fromDate = LocalDate.parse(fromDateStr);
            LocalDate toDate = LocalDate.parse(toDateStr);

            List<CommissionResponseDTO> commissions = commissionService.getCommissionsByDateRange(fromDate, toDate);
            CommissionSummaryDTO summary = commissionService.getCommissionSummary(fromDate, toDate);

            model.addAttribute("commissions", commissions);
            model.addAttribute("summary", summary);
            model.addAttribute("fromDate", fromDateStr);
            model.addAttribute("toDate", toDateStr);
            model.addAttribute("calculationRequest", new CommissionCalculationRequestDTO());

            return "admin/commission/show";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra khi tìm kiếm: " + e.getMessage());
            return "redirect:/admin/commission";
        }
    }

    @PostMapping("/admin/commission/{id}/mark-collected")
    public String markAsCollected(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            CommissionResponseDTO commission = commissionService.markAsCollected(id);
            redirectAttributes.addFlashAttribute("successMessage",
                    "Đã đánh dấu thu thập hoa hồng cho cửa hàng " + commission.getShopName());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }

        return "redirect:/admin/commission";
    }

    @GetMapping("/admin/commission/{id}")
    public String viewCommissionDetail(@PathVariable Long id, Model model) {
        try {
            CommissionResponseDTO commission = commissionService.getCommissionById(id)
                    .orElseThrow(() -> new RuntimeException("Commission not found with id: " + id));

            model.addAttribute("commission", commission);
            return "admin/commission/detail";
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
            return "redirect:/admin/commission";
        }
    }

    @PostMapping("/admin/commission/{id}/delete")
    public String deleteCommission(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            commissionService.deleteCommission(id);
            redirectAttributes.addFlashAttribute("successMessage", "Đã xóa hoa hồng thành công");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra: " + e.getMessage());
        }

        return "redirect:/admin/commission";
    }

    @GetMapping("/admin/commission/shop/{shopId}")
    public String viewShopCommissions(@PathVariable Long shopId, Model model) {
        List<CommissionResponseDTO> commissions = commissionService.getCommissionsByShop(shopId);
        model.addAttribute("commissions", commissions);
        model.addAttribute("shopId", shopId);

        return "admin/commission/shop-detail";
    }
}