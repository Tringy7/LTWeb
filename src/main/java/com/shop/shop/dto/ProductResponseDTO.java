package com.shop.shop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

// DTO for displaying product information safely to clients

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProductResponseDTO {

    private Long id;
    private String name;
    private String brand;
    private String color;
    private String detailDesc;
    private String image;
    private Double price;
    private String category;
    private String gender;

    // Shop information
    private Long shopId;
    private String shopName;

    // Calculated fields
    private Long totalQuantity;
    private Long totalSold;
    private Boolean hasVoucher;

    // Admin control fields
    private String status; // ACTIVE, HIDDEN, LOCKED
    private String violationType; // COPYRIGHT, PROHIBITED, MISLEADING, etc.
    private String adminNotes; // Admin notes about violations or actions
    private java.time.LocalDateTime lastModifiedByAdmin;

    @Override
    public String toString() {
        return "ProductResponseDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", brand='" + brand + '\'' +
                ", price=" + price +
                ", shopName='" + shopName + '\'' +
                '}';
    }
}
