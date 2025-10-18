package com.shop.shop.service.admin;

import java.util.List;
import java.util.Optional;

import com.shop.shop.domain.Shop;

/**
 * Service interface for Shop business logic
 * Follows clean architecture: Business logic abstraction
 */
public interface ShopService {

    // Get all shops
    List<Shop> getAllShops();

    // Get shop by ID
    Optional<Shop> getShopById(Long id);

    // Get shops by user ID
    List<Shop> getShopsByUserId(Long userId);

    // Search shops by keyword
    List<Shop> searchShops(String keyword);

    // Get shops by status
    List<Shop> getShopsByStatus(String status);

    // Save shop
    Shop saveShop(Shop shop);

    // Delete shop by ID
    void deleteShop(Long id);

    // Check if shop name exists
    boolean existsByShopName(String shopName);

    // Count total products for shop
    long countProductsByShopId(Long shopId);

    // Count active products for shop
    long countActiveProductsByShopId(Long shopId);
}
