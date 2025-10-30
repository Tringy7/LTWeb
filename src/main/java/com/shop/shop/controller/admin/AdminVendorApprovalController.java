package com.shop.shop.controller.admin;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.Shop;
import com.shop.shop.service.admin.VendorApprovalService;
import com.shop.shop.service.admin.VendorApprovalService.VendorStatisticsDto;

// Controller for Admin Vendor Approval Management

@Controller
@RequestMapping("/admin/vendor-approval")
public class AdminVendorApprovalController {

    private static final Logger logger = LoggerFactory.getLogger(AdminVendorApprovalController.class);

    @Autowired
    private VendorApprovalService vendorApprovalService;

    // Show vendor approval dashboard

    @GetMapping
    public String showVendorApprovalDashboard(Model model) {
        try {
            // Get statistics
            VendorStatisticsDto statistics = vendorApprovalService.getVendorStatistics();
            model.addAttribute("statistics", statistics);

            // Get pending applications
            List<Shop> pendingApplications = vendorApprovalService.getPendingVendorApplications();
            model.addAttribute("pendingApplications", pendingApplications);

            logger.info("Vendor approval dashboard accessed - pending applications: {}", pendingApplications.size());
            return "admin/vendor-approval/dashboard";

        } catch (Exception e) {
            logger.error("Error loading vendor approval dashboard", e);
            model.addAttribute("error", "Error loading vendor approval data");
            return "admin/vendor-approval/dashboard";
        }
    }

    // Show all applications

    @GetMapping("/applications")
    public String showAllApplications(Model model) {
        try {
            // Get all applications (pending + approved + rejected)
            List<Shop> pendingApplications = vendorApprovalService.getPendingVendorApplications();
            List<Shop> approvedVendors = vendorApprovalService.getApprovedVendors();
            List<Shop> rejectedApplications = vendorApprovalService.getRejectedVendorApplications();

            // Combine all applications
            List<Shop> allApplications = new java.util.ArrayList<>();
            allApplications.addAll(pendingApplications);
            allApplications.addAll(approvedVendors);
            allApplications.addAll(rejectedApplications);

            VendorStatisticsDto statistics = vendorApprovalService.getVendorStatistics();

            model.addAttribute("applications", allApplications);
            model.addAttribute("statistics", statistics);

            return "admin/vendor-approval/applications";

        } catch (Exception e) {
            logger.error("Error loading all applications", e);
            model.addAttribute("error", "Error loading applications");
            return "admin/vendor-approval/applications";
        }
    }

    // Show pending vendor applications

    @GetMapping("/pending")
    public String showPendingApplications(Model model) {
        try {
            List<Shop> pendingApplications = vendorApprovalService.getPendingVendorApplications();
            VendorStatisticsDto statistics = vendorApprovalService.getVendorStatistics();

            model.addAttribute("applications", pendingApplications);
            model.addAttribute("statistics", statistics);
            model.addAttribute("status", "pending");

            return "admin/vendor-approval/applications";

        } catch (Exception e) {
            logger.error("Error loading pending applications", e);
            model.addAttribute("error", "Error loading pending applications");
            return "admin/vendor-approval/applications";
        }
    }

    // Show approved vendors

    @GetMapping("/approved")
    public String showApprovedVendors(Model model) {
        try {
            List<Shop> approvedVendors = vendorApprovalService.getApprovedVendors();
            VendorStatisticsDto statistics = vendorApprovalService.getVendorStatistics();

            model.addAttribute("applications", approvedVendors);
            model.addAttribute("statistics", statistics);
            model.addAttribute("status", "approved");

            return "admin/vendor-approval/applications";

        } catch (Exception e) {
            logger.error("Error loading approved vendors", e);
            model.addAttribute("error", "Error loading approved vendors");
            return "admin/vendor-approval/applications";
        }
    }

    // Show rejected applications

    @GetMapping("/rejected")
    public String showRejectedApplications(Model model) {
        try {
            List<Shop> rejectedApplications = vendorApprovalService.getRejectedVendorApplications();
            VendorStatisticsDto statistics = vendorApprovalService.getVendorStatistics();

            model.addAttribute("applications", rejectedApplications);
            model.addAttribute("statistics", statistics);
            model.addAttribute("status", "rejected");

            return "admin/vendor-approval/applications";

        } catch (Exception e) {
            logger.error("Error loading rejected applications", e);
            model.addAttribute("error", "Error loading rejected applications");
            return "admin/vendor-approval/applications";
        }
    }

    // Show vendor application details

    @GetMapping("/details/{shopId}")
    public String showApplicationDetails(@PathVariable Long shopId, Model model) {
        try {
            Shop shop = vendorApprovalService.getVendorApplicationDetails(shopId);
            if (shop == null) {
                model.addAttribute("error", "Vendor application not found");
                return "redirect:/admin/vendor-approval";
            }

            model.addAttribute("shop", shop);
            return "admin/vendor-approval/details";

        } catch (Exception e) {
            logger.error("Error loading application details for shop id: {}", shopId, e);
            model.addAttribute("error", "Error loading application details");
            return "redirect:/admin/vendor-approval";
        }
    }

    // Approve vendor application

    @PostMapping("/approve/{shopId}")
    public String approveVendor(@PathVariable Long shopId, RedirectAttributes redirectAttributes) {
        try {
            boolean success = vendorApprovalService.approveVendor(shopId);

            if (success) {
                redirectAttributes.addFlashAttribute("successMessage", "Đơn đăng ký vendor đã được duyệt thành công!");
                logger.info("Vendor approved successfully for shop id: {}", shopId);
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể duyệt đơn đăng ký vendor");
                logger.error("Failed to approve vendor for shop id: {}", shopId);
            }

        } catch (Exception e) {
            logger.error("Error approving vendor for shop id: {}", shopId, e);
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi duyệt đơn đăng ký");
        }

        return "redirect:/admin/vendor-approval/pending";
    }

    // Reject vendor application

    @PostMapping("/reject/{shopId}")
    public String rejectVendor(@PathVariable Long shopId,
            @RequestParam(defaultValue = "Đơn đăng ký bị từ chối bởi quản trị viên") String rejectionReason,
            RedirectAttributes redirectAttributes) {
        try {
            boolean success = vendorApprovalService.rejectVendor(shopId, rejectionReason);

            if (success) {
                redirectAttributes.addFlashAttribute("successMessage", "Đơn đăng ký vendor đã bị từ chối!");
                logger.info("Vendor rejected successfully for shop id: {}, reason: {}", shopId, rejectionReason);
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể từ chối đơn đăng ký vendor");
                logger.error("Failed to reject vendor for shop id: {}", shopId);
            }

        } catch (Exception e) {
            logger.error("Error rejecting vendor for shop id: {}", shopId, e);
            redirectAttributes.addFlashAttribute("errorMessage", "Có lỗi xảy ra khi từ chối đơn đăng ký");
        }

        return "redirect:/admin/vendor-approval/pending";
    }

    // Bulk approve multiple vendors

    @PostMapping("/bulk-approve")
    public String bulkApproveVendors(@RequestParam("shopIds") List<Long> shopIds,
            RedirectAttributes redirectAttributes) {
        try {
            int successCount = 0;
            int failCount = 0;

            for (Long shopId : shopIds) {
                boolean success = vendorApprovalService.approveVendor(shopId);
                if (success) {
                    successCount++;
                } else {
                    failCount++;
                }
            }

            if (successCount > 0) {
                redirectAttributes.addFlashAttribute("successMessage",
                        String.format("Successfully approved %d vendor(s)", successCount));
            }

            if (failCount > 0) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        String.format("Failed to approve %d vendor(s)", failCount));
            }

            logger.info("Bulk approval completed - Success: {}, Failed: {}", successCount, failCount);

        } catch (Exception e) {
            logger.error("Error in bulk vendor approval", e);
            redirectAttributes.addFlashAttribute("errorMessage", "Error occurred during bulk approval");
        }

        return "redirect:/admin/vendor-approval/pending";
    }

    // Bulk reject multiple vendors

    @PostMapping("/bulk-reject")
    public String bulkRejectVendors(@RequestParam("shopIds") List<Long> shopIds,
            @RequestParam(defaultValue = "Bulk rejection by admin") String rejectionReason,
            RedirectAttributes redirectAttributes) {
        try {
            int successCount = 0;
            int failCount = 0;

            for (Long shopId : shopIds) {
                boolean success = vendorApprovalService.rejectVendor(shopId, rejectionReason);
                if (success) {
                    successCount++;
                } else {
                    failCount++;
                }
            }

            if (successCount > 0) {
                redirectAttributes.addFlashAttribute("successMessage",
                        String.format("Successfully rejected %d vendor application(s)", successCount));
            }

            if (failCount > 0) {
                redirectAttributes.addFlashAttribute("errorMessage",
                        String.format("Failed to reject %d vendor application(s)", failCount));
            }

            logger.info("Bulk rejection completed - Success: {}, Failed: {}", successCount, failCount);

        } catch (Exception e) {
            logger.error("Error in bulk vendor rejection", e);
            redirectAttributes.addFlashAttribute("errorMessage", "Error occurred during bulk rejection");
        }

        return "redirect:/admin/vendor-approval/pending";
    }
}
