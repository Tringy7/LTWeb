package com.shop.shop.service.client.impl;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.shop.shop.domain.Shop;
import com.shop.shop.domain.ShopSecurityInfo;
import com.shop.shop.domain.User;
import com.shop.shop.domain.UserAddress;
import com.shop.shop.domain.UserVoucher;
import com.shop.shop.domain.Voucher;
import com.shop.shop.repository.ShopRepository;
import com.shop.shop.repository.ShopSecurityInfoRepository;
import com.shop.shop.repository.UserAddressRepository;
import com.shop.shop.repository.UserRepository;
import com.shop.shop.repository.UserVoucherRepository;
import com.shop.shop.service.client.UserService;

import jakarta.servlet.ServletContext;

@Service("clientUserService")
public class UserServiceImpl implements UserService {

    @Autowired
    private UserAddressRepository userAddressRepository;

    // Giả sử bạn đã có UserRepository, hãy inject nó
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private UserVoucherRepository userVoucherRepository;

    @Autowired
    private ShopRepository shopRepository;

    @Autowired
    private ShopSecurityInfoRepository shopSecurityInfoRepository;

    @Override
    public UserAddress handlUserAddress(User user) {
        UserAddress userAddress = user.getReceiver();
        if (userAddress == null) {
            userAddress = new UserAddress();
            userAddress.setUser(user);
            userAddressRepository.save(userAddress);
        }
        return userAddress;
    }

    @Override
    @Transactional(readOnly = true)
    public User findById(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            // Khởi tạo collection 'orders' (mặc dù đã là EAGER, nhưng để cho chắc chắn)
            user.getOrders().size();
            // Khởi tạo collection 'orderDetails' bên trong mỗi order
            user.getOrders().forEach(order -> order.getOrderDetails().size());
        }
        return user;
    }

    @Override
    @Transactional
    public void handleUpdateAccount(User user, MultipartFile avatarFile) {
        User userInDB = userRepository.findById(user.getId()).orElse(null);
        if (userInDB == null) {
            return;
        }

        userInDB.setFullName(user.getFullName());
        userInDB.setPhone(user.getPhone());
        userInDB.setAddress(user.getAddress());

        if (avatarFile != null && !avatarFile.isEmpty()) {
            try {
                // Lấy đường dẫn thực tới thư mục trong webapp
                String relativePath = "/resources/admin/images/user"; // tương ứng webapp/resources/admin/images/user
                String realPath = servletContext.getRealPath(relativePath);
                if (realPath == null) {
                    // trường hợp chạy trong executable jar, getRealPath có thể trả về null
                    throw new IOException("Không thể lấy realPath cho " + relativePath + ". Chạy dưới jar không hỗ trợ getRealPath.");
                }

                Path uploadPath = Paths.get(realPath);

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                // sanitize và avoid name collision
                String original = avatarFile.getOriginalFilename();
                String cleanName = original == null ? "avatar" : Paths.get(original).getFileName().toString();
                String ext = "";
                int i = cleanName.lastIndexOf('.');
                if (i > 0) {
                    ext = cleanName.substring(i); // bao gồm dấu chấm

                }
                String fileName = UUID.randomUUID().toString() + ext;

                // Lưu file
                Path filePath = uploadPath.resolve(fileName);
                avatarFile.transferTo(filePath.toFile());

                // lưu tên file vào DB (chỉ lưu fileName, hiển thị bằng URL /admin/images/user/{fileName})
                userInDB.setImage(fileName);
            } catch (IOException e) {
                throw new RuntimeException("Lỗi khi lưu hình ảnh: " + e.getMessage(), e);
            }
        }

        userRepository.save(userInDB);
    }

    @Override
    public List<Voucher> getVoucherForUser(User user) {
        if (user == null) {
            return new ArrayList<>();
        }

        List<UserVoucher> userVouchers = userVoucherRepository.findByUserAndStatus(user, true);

        if (userVouchers == null || userVouchers.isEmpty()) {
            return new ArrayList<>();
        }

        // Chuyển đổi từ UserVoucher sang Voucher
        return userVouchers.stream()
                .map(com.shop.shop.domain.UserVoucher::getVoucher)
                .collect(Collectors.toList());
    }

    @Override
    @Transactional
    public void handleReceiverUser(User user, UserAddress receiver) {
        UserAddress userAddress = userAddressRepository.findByUser(user);
        if (userAddress != null) {
            userAddress.setReceiverAddress(receiver.getReceiverAddress());
            userAddress.setReceiverName(receiver.getReceiverName());
            userAddress.setReceiverPhone(receiver.getReceiverPhone());
            userAddress.setNote(receiver.getNote());
            userAddressRepository.save(userAddress);
        } else {
            receiver.setUser(user);
            userAddressRepository.save(receiver);
        }
    }

    @Override
    @Transactional
    public Shop getShop(User user) {
        Shop shop = shopRepository.findByUser(user);
        if (shop == null) {
            shop = new Shop();
            shop.setUser(user);
            // Lưu shop trước để có ID
            shopRepository.save(shop);

            // Sau đó tạo ShopSecurityInfo
            ShopSecurityInfo securityInfo = new ShopSecurityInfo();
            securityInfo.setShop(shop);
            securityInfo.setVerificationStatus("NOT REGISTERED");
            shopSecurityInfoRepository.save(securityInfo);

            // Set lại securityInfo cho shop
            shop.setSecurityInfo(securityInfo);
        }
        return shop;
    }

    @Override
    @Transactional
    public void handleVendorRegistration(Shop shop, User user) {
        // Kiểm tra xem user đã có shop chưa
        Shop existingShop = shopRepository.findByUser(user);
        ShopSecurityInfo securityInfo = shopSecurityInfoRepository.findByShop(existingShop);

        // Cập nhật shop hiện có
        existingShop.setShopName(shop.getShopName());
        existingShop.setDescription(shop.getDescription());

        securityInfo.setBusinessType(shop.getSecurityInfo().getBusinessType());
        securityInfo.setTaxCode(shop.getSecurityInfo().getTaxCode());
        securityInfo.setBankName(shop.getSecurityInfo().getBankName());
        securityInfo.setBankAccount(shop.getSecurityInfo().getBankAccount());
        securityInfo.setBankAccountName(shop.getSecurityInfo().getBankAccountName());
        securityInfo.setBankBranch(shop.getSecurityInfo().getBankBranch());
        securityInfo.setVerificationStatus("PENDING");
        // Lưu shop và securityInfo
        shopRepository.save(existingShop);
        shopSecurityInfoRepository.save(securityInfo);
    }
}
