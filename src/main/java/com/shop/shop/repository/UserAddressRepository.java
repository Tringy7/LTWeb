package com.shop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.User;
import com.shop.shop.domain.UserAddress;

public interface UserAddressRepository extends JpaRepository<UserAddress, Long> {

    UserAddress findByUser(User user);
}
