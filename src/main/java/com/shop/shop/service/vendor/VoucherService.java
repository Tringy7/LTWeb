package com.shop.shop.service.vendor;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.shop.domain.Shop;
import com.shop.shop.domain.User;
import com.shop.shop.domain.UserVoucher;
import com.shop.shop.domain.Voucher;
import com.shop.shop.repository.ShopRepository;
import com.shop.shop.repository.UserRepository;
import com.shop.shop.repository.UserVoucherRepository;
import com.shop.shop.repository.VoucherRepository;

@Service("vendorVoucherService")
public class VoucherService {

    @Autowired
    private VoucherRepository voucherRepository;

    @Autowired
    private ShopRepository shopRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserVoucherRepository userVoucherRepository;

    public List<Voucher> getVouchersByShopId(Long shopId) {
        return voucherRepository.findByShop_Id(shopId);
    }

    public Voucher getVoucherById(Long id) {
        return voucherRepository.findById(id).orElse(null);
    }

    @Transactional
    public void saveVoucher(Voucher voucher, Long shopId) {
        Shop shop = shopRepository.findById(shopId)
                .orElseThrow(() -> new RuntimeException("Shop not found"));

        voucher.setShop(shop);

        // Nếu ngày bắt đầu trống thì gán mặc định là thời điểm hiện tại
        if (voucher.getStartDate() == null) {
            voucher.setStartDate(LocalDateTime.now());
        }

        // Xét trạng thái voucher giống controller
        LocalDateTime now = LocalDateTime.now();
        if (voucher.getStartDate() != null && voucher.getStartDate().isAfter(now)) {
            voucher.setStatus("Upcoming");
        } else if (voucher.getEndDate() != null && voucher.getEndDate().isBefore(now)) {
            voucher.setStatus("Expired");
        } else {
            voucher.setStatus("Active");
        }

        boolean isNew = (voucher.getId() == null); // true nếu là thêm mới

        Voucher savedVoucher = voucherRepository.save(voucher);

        // 🔹 Chỉ thêm user_voucher khi là voucher mới và status = "Active"
        if (isNew && "Active".equalsIgnoreCase(savedVoucher.getStatus())) {
            List<User> allUsers = userRepository.findAll();
            for (User user : allUsers) {
                UserVoucher uv = UserVoucher.builder()
                        .user(user)
                        .voucher(savedVoucher)
                        .status(true) // hoặc 1 nếu là kiểu int
                        .build();
                userVoucherRepository.save(uv);
            }
        }
    }

    public void deleteVoucher(Long id) {
        voucherRepository.deleteById(id);
    }
}
