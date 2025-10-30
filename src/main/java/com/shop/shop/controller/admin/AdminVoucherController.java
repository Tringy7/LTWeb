package com.shop.shop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shop.shop.domain.Voucher;
import com.shop.shop.dto.VoucherCreateDTO;
import com.shop.shop.dto.VoucherResponseDTO;
import com.shop.shop.dto.VoucherSearchDTO;
import com.shop.shop.dto.VoucherUpdateDTO;
import com.shop.shop.mapper.VoucherMapper;
import com.shop.shop.repository.UserRepository;
import com.shop.shop.service.admin.VoucherService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

// Admin Controller for Voucher Management
// Handles system voucher creation and shop voucher moderation

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/voucher")
public class AdminVoucherController {

    private final VoucherService voucherService;
    private final VoucherMapper voucherMapper;
    private final UserRepository userRepository;

    // Display voucher management page with search functionality

    @GetMapping
    public String showVouchers(@RequestParam(defaultValue = "") String keyword,
            @RequestParam(defaultValue = "ALL") String status,
            @RequestParam(defaultValue = "SYSTEM") String voucherType,
            Model model) {
        List<Voucher> vouchers;

        // Filter based on voucher type and search criteria
        if ("SYSTEM".equals(voucherType)) {
            if (keyword.isEmpty() && "ALL".equals(status)) {
                vouchers = voucherService.getAllSystemVouchers();
            } else if (!keyword.isEmpty()) {
                vouchers = voucherService.searchSystemVouchers(keyword);
            } else {
                vouchers = voucherService.getSystemVouchersByStatus(status);
            }
        } else {
            // For ALL vouchers (system + shop)
            if (keyword.isEmpty() && "ALL".equals(status)) {
                vouchers = voucherService.getAllVouchers();
            } else if (!"ALL".equals(status)) {
                vouchers = voucherService.getVouchersByStatus(status);
            } else {
                vouchers = voucherService.getAllVouchers();
            }
        }

        // Convert to DTOs and enrich with calculated fields
        List<VoucherResponseDTO> voucherDTOs = vouchers.stream()
                .map(voucherMapper::toVoucherResponseDTO)
                .peek(voucherService::enrichVoucherResponseDTO)
                .toList();

        // Add model attributes
        model.addAttribute("vouchers", voucherDTOs);
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status);
        model.addAttribute("voucherType", voucherType);
        model.addAttribute("searchDTO", new VoucherSearchDTO());
        model.addAttribute("createDTO", new VoucherCreateDTO());

        // Statistics
        model.addAttribute("totalSystemVouchers", voucherService.getTotalSystemVouchersCount());
        model.addAttribute("activeSystemVouchers", voucherService.getActiveSystemVouchersCount());

        return "admin/voucher/show";
    }

    // Display voucher details
    @GetMapping("/{id}")
    public String showVoucherDetail(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Voucher> voucherOpt = voucherService.getVoucherById(id);
        if (voucherOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Voucher not found");
            return "redirect:/admin/voucher";
        }

        Voucher voucher = voucherOpt.get();
        VoucherResponseDTO voucherDTO = voucherMapper.toVoucherResponseDTO(voucher);
        voucherService.enrichVoucherResponseDTO(voucherDTO);

        model.addAttribute("voucher", voucherDTO);
        return "admin/voucher/detail";
    }

    // Show create voucher form
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("createDTO", new VoucherCreateDTO());
        return "admin/voucher/create";
    }

    // Create new system voucher

    @PostMapping("/create")
    public String createVoucher(@Valid @ModelAttribute("createDTO") VoucherCreateDTO createDTO,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {
        if (result.hasErrors()) {
            model.addAttribute("createDTO", createDTO);
            return "admin/voucher/create";
        }

        try {
            Voucher voucher = voucherService.createSystemVoucher(createDTO);

            // Get user count with ROLE_USER for information message
            long regularUsersCount = userRepository.countByRoleName("ROLE_USER");

            redirectAttributes.addFlashAttribute("success",
                    "System voucher '" + voucher.getCode() + "' created successfully and automatically assigned to "
                            + regularUsersCount + " regular users (ROLE_USER)!");
            return "redirect:/admin/voucher";
        } catch (IllegalArgumentException e) {
            model.addAttribute("error", e.getMessage());
            model.addAttribute("createDTO", createDTO);
            return "admin/voucher/create";
        }
    }

    // Show edit voucher form

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model, RedirectAttributes redirectAttributes) {
        Optional<Voucher> voucherOpt = voucherService.getVoucherById(id);
        if (voucherOpt.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Voucher not found");
            return "redirect:/admin/voucher";
        }

        Voucher voucher = voucherOpt.get();
        VoucherUpdateDTO updateDTO = voucherMapper.toVoucherUpdateDTO(voucher);

        model.addAttribute("updateDTO", updateDTO);
        model.addAttribute("voucher", voucher);
        return "admin/voucher/edit";
    }

    // Update voucher

    @PostMapping("/edit")
    public String updateVoucher(@Valid @ModelAttribute("updateDTO") VoucherUpdateDTO updateDTO,
            BindingResult result,
            RedirectAttributes redirectAttributes,
            Model model) {
        if (result.hasErrors()) {
            Optional<Voucher> voucherOpt = voucherService.getVoucherById(updateDTO.getId());
            if (voucherOpt.isPresent()) {
                model.addAttribute("voucher", voucherOpt.get());
            }
            model.addAttribute("updateDTO", updateDTO);
            return "admin/voucher/edit";
        }

        try {
            Voucher voucher = voucherService.updateVoucher(updateDTO);
            redirectAttributes.addFlashAttribute("success",
                    "Voucher updated successfully: " + voucher.getCode());
            return "redirect:/admin/voucher";
        } catch (IllegalArgumentException e) {
            Optional<Voucher> voucherOpt = voucherService.getVoucherById(updateDTO.getId());
            if (voucherOpt.isPresent()) {
                model.addAttribute("voucher", voucherOpt.get());
            }
            model.addAttribute("error", e.getMessage());
            model.addAttribute("updateDTO", updateDTO);
            return "admin/voucher/edit";
        }
    }

    // Delete voucher

    @PostMapping("/delete/{id}")
    public String deleteVoucher(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            voucherService.deleteVoucher(id);
            redirectAttributes.addFlashAttribute("success", "Voucher deleted successfully");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/voucher";
    }

    // Lock voucher for policy violation

    @PostMapping("/{id}/lock")
    public String lockVoucher(@PathVariable Long id,
            @RequestParam(defaultValue = "Policy violation") String reason,
            RedirectAttributes redirectAttributes) {
        try {
            voucherService.lockVoucherForViolation(id, reason);
            redirectAttributes.addFlashAttribute("success", "Voucher locked successfully");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/voucher";
    }

    // Unlock voucher

    @PostMapping("/{id}/unlock")
    public String unlockVoucher(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            voucherService.unlockVoucher(id);
            redirectAttributes.addFlashAttribute("success", "Voucher unlocked successfully");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/voucher";
    }

    // Activate voucher

    @PostMapping("/{id}/activate")
    public String activateVoucher(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            voucherService.activateVoucher(id);
            redirectAttributes.addFlashAttribute("success", "Voucher activated successfully");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/voucher";
    }

    // Deactivate voucher

    @PostMapping("/{id}/deactivate")
    public String deactivateVoucher(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            voucherService.deactivateVoucher(id);
            redirectAttributes.addFlashAttribute("success", "Voucher deactivated successfully");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/voucher";
    }

    // AJAX endpoint to check if voucher code exists

    @GetMapping("/check-code")
    @ResponseBody
    public boolean checkVoucherCode(@RequestParam String code,
            @RequestParam(required = false) Long excludeId) {
        if (excludeId != null) {
            return !voucherService.existsByCodeAndNotId(code, excludeId);
        }
        return !voucherService.existsByCode(code);
    }

    // Get vouchers for moderation (shop vouchers that may violate policies)

    @GetMapping("/moderation")
    public String showModerationVouchers(Model model) {
        List<Voucher> shopVouchers = voucherService.getShopVouchersForModeration();
        List<VoucherResponseDTO> voucherDTOs = shopVouchers.stream()
                .map(voucherMapper::toVoucherResponseDTO)
                .peek(voucherService::enrichVoucherResponseDTO)
                .toList();

        model.addAttribute("vouchers", voucherDTOs);
        return "admin/voucher/moderation";
    }

    // Manually assign a voucher to all users (for existing vouchers)

    @PostMapping("/{id}/assign-to-all")
    public String assignVoucherToAllUsers(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            Optional<Voucher> voucherOpt = voucherService.getVoucherById(id);
            if (voucherOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "Voucher not found");
                return "redirect:/admin/voucher";
            }

            Voucher voucher = voucherOpt.get();
            if (voucher.getShop() != null) {
                redirectAttributes.addFlashAttribute("error",
                        "Only system vouchers can be assigned to all users");
                return "redirect:/admin/voucher";
            }

            voucherService.assignVoucherToAllUsers(id);
            long regularUsersCount = userRepository.countByRoleName("ROLE_USER");

            redirectAttributes.addFlashAttribute("success",
                    "Voucher '" + voucher.getCode() + "' has been assigned to all " + regularUsersCount
                            + " regular users (ROLE_USER)");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/voucher";
    }
}