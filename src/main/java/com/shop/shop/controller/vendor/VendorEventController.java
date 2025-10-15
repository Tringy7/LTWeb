package com.shop.shop.controller.vendor;

import com.shop.shop.domain.ProductVoucher;
import com.shop.shop.service.vendor.ProductService;
import com.shop.shop.service.vendor.ProductVoucherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/vendor/event")
public class VendorEventController {

    @Autowired
    private ProductVoucherService voucherService;

    @Autowired
    private ProductService productService;

    // --- Giả định shopId cố định = 1 (tạm thời) ---
    private static final Long SHOP_ID = 1L;

    @GetMapping
    public String showVouchers(Model model) {
        // chỉ lấy voucher thuộc shopId = 1
        List<ProductVoucher> vouchers = voucherService.getVouchersByShopId(SHOP_ID);

        List<Map<String, Object>> voucherData = vouchers.stream().map(v -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", v.getId());
            map.put("code", v.getCode());
            map.put("productName", v.getProduct().getName());
            map.put("discount", v.getDiscountPercent());
            map.put("startDate",
                    v.getStartDate() != null ? v.getStartDate().format(DateTimeFormatter.ofPattern("dd MMM yyyy"))
                            : "");
            map.put("endDate",
                    v.getEndDate() != null ? v.getEndDate().format(DateTimeFormatter.ofPattern("dd MMM yyyy")) : "");

            LocalDateTime now = LocalDateTime.now();
            String status;
            if (v.getStartDate() != null && v.getStartDate().isAfter(now)) {
                status = "Upcoming";
            } else if (v.getEndDate() != null && v.getEndDate().isBefore(now)) {
                status = "Expired";
            } else {
                status = "Active";
            }
            map.put("status", status);

            return map;
        }).collect(Collectors.toList());

        model.addAttribute("vouchers", voucherData);
        model.addAttribute("voucher", new ProductVoucher());

        // chỉ lấy product của shop đó
        model.addAttribute("products", productService.getProductsByShopId(SHOP_ID));

        return "vendor/event/show";
    }

    @PostMapping("/add")
    public String addVoucher(@ModelAttribute("voucher") ProductVoucher voucher) {
        voucherService.saveVoucher(voucher);
        return "redirect:/vendor/event";
    }

    @GetMapping("/get/{id}")
    @ResponseBody
    public Map<String, Object> getVoucher(@PathVariable Long id) {
        ProductVoucher v = voucherService.getVoucherById(id);
        Map<String, Object> data = new HashMap<>();
        data.put("id", v.getId());
        data.put("code", v.getCode());
        data.put("discountPercent", v.getDiscountPercent());
        data.put("startDate", v.getStartDate() != null ? v.getStartDate().toString() : "");
        data.put("endDate", v.getEndDate() != null ? v.getEndDate().toString() : "");
        data.put("status", v.getStatus());

        if (v.getProduct() != null) {
            Map<String, Object> prod = new HashMap<>();
            prod.put("id", v.getProduct().getId());
            prod.put("name", v.getProduct().getName());
            data.put("product", prod);
        } else {
            data.put("product", null);
        }
        return data;
    }

    @PostMapping("/update")
    public String updateVoucher(@ModelAttribute("voucher") ProductVoucher voucher) {
        voucherService.saveVoucher(voucher);
        return "redirect:/vendor/event";
    }

    @DeleteMapping("/delete/{id}")
    @ResponseBody
    public ResponseEntity<String> deleteCoupon(@PathVariable Long id) {
        try {
            voucherService.deleteVoucher(id);
            return ResponseEntity.ok("Deleted");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("Xóa thất bại");
        }
    }
}
