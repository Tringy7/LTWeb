package com.shop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.shop.shop.domain.Shop;
import com.shop.shop.domain.ShopSecurityInfo;

public interface ShopSecurityInfoRepository extends JpaRepository<ShopSecurityInfo, Long> {

    ShopSecurityInfo findByShop(Shop shop);
}
