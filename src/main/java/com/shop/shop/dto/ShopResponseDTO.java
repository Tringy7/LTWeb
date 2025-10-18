package com.shop.shop.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// DTO for displaying shop information safely to clients

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ShopResponseDTO {

    private Long id;
    private String shopName;
    private String description;
    private String status;
    private LocalDateTime createdAt;

    // Owner information
    private Long userId;
    private String ownerName;
    private String ownerEmail;

    // Statistics
    private Long totalProducts;
    private Long totalActiveProducts;

    @Override
    public String toString() {
        return "ShopResponseDTO{" +
                "id=" + id +
                ", shopName='" + shopName + '\'' +
                ", ownerName='" + ownerName + '\'' +
                ", totalProducts=" + totalProducts +
                '}';
    }
}
