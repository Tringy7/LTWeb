package com.shop.shop.mapper;

import org.springframework.stereotype.Component;

import com.shop.shop.domain.Product;
import com.shop.shop.dto.ProductResponseDTO;
import com.shop.shop.dto.ProductUpdateDTO;

/**
 * Mapper utility for Product entity and DTOs
 * Follows clean architecture: Handles conversion between Domain and DTO layers
 */
@Component
public class ProductMapper {

    /**
     * Convert Product entity to ProductResponseDTO
     * 
     * @param product The Product entity to convert
     * @return ProductResponseDTO for safe data exposure
     */
    public ProductResponseDTO toProductResponseDTO(Product product) {
        if (product == null) {
            return null;
        }

        ProductResponseDTO dto = new ProductResponseDTO();
        dto.setId(product.getId());
        dto.setName(product.getName());
        dto.setBrand(product.getBrand());
        dto.setColor(product.getColor());
        dto.setDetailDesc(product.getDetailDesc());
        dto.setImage(product.getImage());
        dto.setPrice(product.getPrice());
        dto.setCategory(product.getCategory());
        dto.setGender(product.getGender());

        // Set shop information
        if (product.getShop() != null) {
            dto.setShopId(product.getShop().getId());
            dto.setShopName(product.getShop().getShopName());
        }

        // Set default values - will be populated by service layer
        dto.setTotalQuantity(0L);
        dto.setTotalSold(0L);
        dto.setHasVoucher(false);

        return dto;
    }

    public Product updateProductFromDTO(Product product, ProductUpdateDTO updateDTO) {
        if (product == null || updateDTO == null) {
            return product;
        }

        product.setName(updateDTO.getName());
        product.setBrand(updateDTO.getBrand());
        product.setColor(updateDTO.getColor());
        product.setDetailDesc(updateDTO.getDetailDesc());
        product.setImage(updateDTO.getImage());
        product.setPrice(updateDTO.getPrice());
        product.setCategory(updateDTO.getCategory());
        product.setGender(updateDTO.getGender());

        return product;
    }
}
