package com.shop.shop.service.client;

import org.springframework.web.multipart.MultipartFile;

import com.shop.shop.domain.User;
import com.shop.shop.domain.UserAddress;

public interface UserService {

    UserAddress handlUserAddress(User user);

    User findById(Long id);

    void handleUpdateAccount(User user, MultipartFile avatarFile);
}
