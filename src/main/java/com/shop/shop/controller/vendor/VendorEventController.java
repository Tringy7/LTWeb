package com.shop.shop.controller.vendor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shop.shop.domain.Shop;
import com.shop.shop.domain.User;
import com.shop.shop.domain.Voucher;
import com.shop.shop.service.vendor.ProductService;
import com.shop.shop.service.vendor.ShopService;
import com.shop.shop.service.vendor.VoucherService;

@Controller
@RequestMapping("/vendor/event")
public class VendorEventController {

    @Autowired
    private VoucherService voucherService;

    @Autowired
    private ProductService productService;

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

    @GetMapping
    public String showVouchers(Model model) {
        Long SHOP_ID = getCurrentShopId();
        List<Voucher> vouchers = voucherService.getVouchersByShopId(SHOP_ID);

        List<Map<String, Object>> voucherData = vouchers.stream().map(v -> {
            Map<String, Object> map = new HashMap<>();
            map.put("id", v.getId());
            map.put("code", v.getCode());
            map.put("discount", v.getDiscountPercent());
            map.put("startDate",
                    v.getStartDate() != null ? v.getStartDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "");
            map.put("endDate",
                    v.getEndDate() != null ? v.getEndDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "");

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
        model.addAttribute("voucher", new Voucher());
        model.addAttribute("products", productService.getProductsByShopId(SHOP_ID));

        return "vendor/event/show";
    }

    @PostMapping("/add")
    public String addVoucher(@ModelAttribute("voucher") Voucher voucher) {
        Long SHOP_ID = getCurrentShopId();
        voucherService.saveVoucher(voucher, SHOP_ID);
        return "redirect:/vendor/event";
    }

    @GetMapping("/get/{id}")
    @ResponseBody
    public Map<String, Object> getVoucher(@PathVariable Long id) {
        Voucher v = voucherService.getVoucherById(id);
        Map<String, Object> data = new HashMap<>();
        data.put("id", v.getId());
        data.put("code", v.getCode());
        data.put("discountPercent", v.getDiscountPercent());
        data.put("startDate", v.getStartDate() != null ? v.getStartDate().toString() : "");
        data.put("endDate", v.getEndDate() != null ? v.getEndDate().toString() : "");
        data.put("status", v.getStatus());
        return data;
    }

    @PostMapping("/update")
    public String updateVoucher(@ModelAttribute("voucher") Voucher voucher) {
        Long SHOP_ID = getCurrentShopId();
        voucherService.saveVoucher(voucher, SHOP_ID);
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
