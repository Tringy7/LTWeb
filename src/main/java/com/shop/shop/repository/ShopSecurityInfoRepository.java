package com.shop.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Shop;
import com.shop.shop.domain.ShopSecurityInfo;

/**
 * Repository interface for ShopSecurityInfo entity
 */
@Repository
public interface ShopSecurityInfoRepository extends JpaRepository<ShopSecurityInfo, Long> {

    // Find by shop ID
    ShopSecurityInfo findByShopId(Long shopId);

    // Find by verification status
    List<ShopSecurityInfo> findByVerificationStatus(String verificationStatus);

    // Count by verification status
    long countByVerificationStatus(String verificationStatus);

    // Find by business type
    List<ShopSecurityInfo> findByBusinessType(String businessType);

    // Check if shop security info exists for shop
    boolean existsByShopId(Long shopId);

    ShopSecurityInfo findByShop(Shop shop);

}
