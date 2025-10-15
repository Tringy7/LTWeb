package com.shop.shop.service.client;

import com.shop.shop.domain.User;
import com.shop.shop.domain.UserAddress;

public interface UserService {

    UserAddress handlUserAddress(User user);

    User findById(Long id);
}
