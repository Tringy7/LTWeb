package com.shop.shop.service.vendor;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.shop.shop.domain.Shop;
import com.shop.shop.repository.ShopRepository;

@Service
public class ShopService {
    private final ShopRepository shopRepository;

    public ShopService(ShopRepository shopRepository) {
        this.shopRepository = shopRepository;
    }

    public Optional<Shop> getShopByUserId(Long userId) {
        return shopRepository.findFirstByUserId(userId);
    }

    public Shop findById(Long id) {
        Optional<Shop> shop = shopRepository.findById(id);
        return shop.orElse(null);
    }
}
