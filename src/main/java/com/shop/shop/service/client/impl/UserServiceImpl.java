package com.shop.shop.service.client.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.User;
import com.shop.shop.domain.UserAddress;
import com.shop.shop.repository.client.UserAddressRepository;
import com.shop.shop.service.client.UserService;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserAddressRepository userAddressRepository;

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
}
