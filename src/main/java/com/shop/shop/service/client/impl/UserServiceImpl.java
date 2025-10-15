package com.shop.shop.service.client.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.shop.domain.User;
import com.shop.shop.domain.UserAddress;
import com.shop.shop.repository.client.UserAddressRepository;
import com.shop.shop.repository.client.UserRepository;
import com.shop.shop.service.client.UserService;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserAddressRepository userAddressRepository;

    // Giả sử bạn đã có UserRepository, hãy inject nó
    @Autowired
    private UserRepository userRepository;

    @Override
    public UserAddress handlUserAddress(User user) {
        UserAddress userAddress = user.getAddress();
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
}
