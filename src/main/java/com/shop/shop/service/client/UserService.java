package com.shop.shop.service.client;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.shop.shop.domain.Shop;
import com.shop.shop.domain.User;
import com.shop.shop.domain.UserAddress;
import com.shop.shop.domain.Voucher;

public interface UserService {

    UserAddress handlUserAddress(User user);

    User findById(Long id);

    void handleUpdateAccount(User user, MultipartFile avatarFile);

    List<Voucher> getVoucherForUser(User user);

    void handleReceiverUser(User user, UserAddress receiver);

    Shop getShop(User user);

    void handleVendorRegistration(Shop shop, User user);
}
