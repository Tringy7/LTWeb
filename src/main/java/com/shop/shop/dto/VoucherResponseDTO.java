package com.shop.shop.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class VoucherResponseDTO {

    private Long id;
    private String code;
    private Double discountPercent;
    private LocalDateTime startDate;
    private LocalDateTime endDate;
    private String status;
    private String shopName;
    private Long shopId;
    private String voucherType; // "SYSTEM" or "SHOP"
    private boolean isExpired;
    private boolean isActive;
    private int usageCount;

    @Override
    public String toString() {
        return "VoucherResponseDTO{" +
                "id=" + id +
                ", code='" + code + '\'' +
                ", discountPercent=" + discountPercent +
                ", startDate=" + startDate +
                ", endDate=" + endDate +
                ", status='" + status + '\'' +
                ", shopName='" + shopName + '\'' +
                ", voucherType='" + voucherType + '\'' +
                ", isExpired=" + isExpired +
                ", isActive=" + isActive +
                ", usageCount=" + usageCount +
                '}';
    }
}
