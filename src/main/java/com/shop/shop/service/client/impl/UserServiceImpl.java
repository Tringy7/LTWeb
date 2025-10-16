package com.shop.shop.service.client.impl;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.shop.shop.domain.User;
import com.shop.shop.domain.UserAddress;
import com.shop.shop.repository.UserAddressRepository;
import com.shop.shop.repository.UserRepository;
import com.shop.shop.service.client.UserService;

import jakarta.servlet.ServletContext;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserAddressRepository userAddressRepository;

    // Giả sử bạn đã có UserRepository, hãy inject nó
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ServletContext servletContext;

    @Override
    public UserAddress handlUserAddress(User user) {
        UserAddress userAddress = user.getReceiver();
        if (userAddress == null) {
            userAddress = new UserAddress();
            userAddress.setUser(user);
            userAddress.setIsDefault(true);
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
}
