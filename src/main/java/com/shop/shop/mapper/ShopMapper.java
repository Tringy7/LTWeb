package com.shop.shop.mapper;

import org.springframework.stereotype.Component;
import com.shop.shop.domain.Shop;
import com.shop.shop.dto.ShopResponseDTO;

@Component
public class ShopMapper {

    public ShopResponseDTO toShopResponseDTO(Shop shop) {
        if (shop == null) {
            return null;
        }

        ShopResponseDTO dto = new ShopResponseDTO();
        dto.setId(shop.getId());
        dto.setShopName(shop.getShopName());
        dto.setDescription(shop.getDescription());
        dto.setStatus(shop.getStatus());
        dto.setCreatedAt(shop.getCreatedAt());

        if (shop.getUser() != null) {
            dto.setUserId(shop.getUser().getId());
            dto.setOwnerName(shop.getUser().getFullName());
            dto.setOwnerEmail(shop.getUser().getEmail());
        }

        dto.setTotalProducts(0L);
        dto.setTotalActiveProducts(0L);

        return dto;
    }
}
