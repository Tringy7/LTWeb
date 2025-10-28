package com.shop.shop.service.shipper;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.shop.domain.Shipper;
import com.shop.shop.domain.User;
import com.shop.shop.repository.ShipperRepository;
import com.shop.shop.repository.UserRepository;

@Service
public class ShipperProfileService {

    @Autowired
    private ShipperRepository shipperRepository;

    @Autowired
    private UserRepository userRepository;

    public Optional<Shipper> getShipperByUserId(Long userId) {
        return shipperRepository.findByUser_Id(userId);
    }

    public Optional<User> getUserById(Long userId) {
        return userRepository.findById(userId);
    }

    /**
     * Trả về Shipper (đã merge thông tin fallback từ User)
     */
    public Shipper getMergedShipperInfo(Long userId) {
        Shipper shipper = getShipperByUserId(userId).orElse(null);
        User user = getUserById(userId).orElse(null);

        if (shipper == null || user == null)
            throw new RuntimeException("Không tìm thấy Shipper hoặc User");

        // Ưu tiên thông tin từ Shipper, nếu null thì lấy từ User
        if (shipper.getName() == null)
            shipper.setName(user.getFullName());
        if (shipper.getPhone() == null)
            shipper.setPhone(user.getPhone());
        if (shipper.getCarrier() == null)
            shipper.setCarrier(null);
        if (shipper.getUser() == null)
            shipper.setUser(user);

        // Thông tin phụ từ User
        if (user.getEmail() != null)
            shipper.getUser().setEmail(user.getEmail());
        if (user.getAddress() != null)
            shipper.getUser().setAddress(user.getAddress());
        if (user.getImage() != null)
            shipper.getUser().setImage(user.getImage());

        return shipper;
    }
}
