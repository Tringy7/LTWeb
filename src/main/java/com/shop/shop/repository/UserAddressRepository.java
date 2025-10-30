package com.shop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.User;
import com.shop.shop.domain.UserAddress;

public interface UserAddressRepository extends JpaRepository<UserAddress, Long> {

    // keep a way to fetch all addresses for a user if needed
    java.util.List<UserAddress> findByUser(User user);

    // fetch the latest address (highest id) for the given user
    UserAddress findTopByUserOrderByIdDesc(User user);
}
