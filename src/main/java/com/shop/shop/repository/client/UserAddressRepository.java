package com.shop.shop.repository.client;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.UserAddress;

public interface UserAddressRepository extends JpaRepository<UserAddress, Long> {

}
