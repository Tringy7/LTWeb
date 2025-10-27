package com.shop.shop.service.admin.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.shop.shop.domain.Shop;
import com.shop.shop.repository.ProductRepository;
import com.shop.shop.repository.ShopRepository;
import com.shop.shop.service.admin.ShopService;

/**
 * Implementation of ShopService interface
 * Follows clean architecture: Business logic implementation
 */
@Service("adminShopService")
public class ShopServiceImpl implements ShopService {

    private final ShopRepository shopRepository;
    private final ProductRepository productRepository;

    public ShopServiceImpl(ShopRepository shopRepository, ProductRepository productRepository) {
        this.shopRepository = shopRepository;
        this.productRepository = productRepository;
    }

    @Override
    public List<Shop> getAllShops() {
        return shopRepository.findAll();
    }

    @Override
    public Optional<Shop> getShopById(Long id) {
        return shopRepository.findById(id);
    }

    @Override
    public List<Shop> getShopsByUserId(Long userId) {
        return shopRepository.findByUserId(userId);
    }

    @Override
    public List<Shop> searchShops(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllShops();
        }
        String searchKeyword = keyword.trim();
        return shopRepository.findByShopNameContainingIgnoreCaseOrDescriptionContainingIgnoreCase(
                searchKeyword, searchKeyword);
    }

    @Override
    public List<Shop> getShopsByStatus(String status) {
        return shopRepository.findByStatus(status);
    }

    @Override
    public Shop saveShop(Shop shop) {
        return shopRepository.save(shop);
    }

    @Override
    public void deleteShop(Long id) {
        shopRepository.deleteById(id);
    }

    @Override
    public boolean existsByShopName(String shopName) {
        return shopRepository.existsByShopName(shopName);
    }

    @Override
    public long countProductsByShopId(Long shopId) {
        return productRepository.countByShopId(shopId);
    }

    @Override
    public long countActiveProductsByShopId(Long shopId) {
        // For now, we consider all products as active
        // This can be extended later if Product entity has status field
        return productRepository.countByShopId(shopId);
    }

    @Override
    public void changeShopStatus(Long shopId, String status) {
        Optional<Shop> shopOpt = shopRepository.findById(shopId);
        if (shopOpt.isPresent()) {
            Shop shop = shopOpt.get();
            shop.setStatus(status);
            shopRepository.save(shop);
        }
    }
}
