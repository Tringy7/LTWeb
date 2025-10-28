package com.shop.shop.controller.shipper;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.shop.shop.domain.Shipper;
import com.shop.shop.domain.User;
import com.shop.shop.service.shipper.ShipperProfileService;
import com.shop.shop.service.shipper.ShipperService;

@Controller
public class ShipperInformationController {
    @Autowired
    private ShipperProfileService profileService;

    @Autowired
    private ShipperService shipperService;

    private Long getCurrentUserId() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof User user)
            return user.getId();
        throw new RuntimeException("User chưa đăng nhập");
    }

    @GetMapping("/shipper/information")
    public String showProfile(Model model) {
        Long userId = getCurrentUserId();
        Shipper shipper = profileService.getMergedShipperInfo(userId);

        model.addAttribute("shipper", shipper);
        model.addAttribute("user", shipper.getUser());
        return "shipper/information/show";
    }

    @PostMapping("shipper/update")
    public String updateShipper(
            @RequestParam Long shipperId,
            @RequestParam String name,
            @RequestParam String phone,
            @RequestParam String email,
            @RequestParam(required = false) String vehicleNumber,
            @RequestParam(required = false) String address,
            @RequestParam String status,
            @RequestParam(required = false) MultipartFile image) throws IOException {

        Shipper shipper = shipperService.getById(shipperId);
        shipper.setName(name);
        shipper.setPhone(phone);
        shipper.setVehicleNumber(vehicleNumber);
        shipper.setStatus(status);

        User user = shipper.getUser();
        user.setEmail(email);
        user.setAddress(address);

        if (image != null && !image.isEmpty()) {
            String fileName = image.getOriginalFilename();
            File saveFile = new File("path/to/images/folder/" + fileName);
            image.transferTo(saveFile);
            user.setImage(fileName);
        }

        shipperService.save(shipper);

        return "redirect:/shipper/information";
    }

    @GetMapping("/shipper/update")
    public String getUpdateForm() {
        return "redirect:/shipper/information";
    }
}
