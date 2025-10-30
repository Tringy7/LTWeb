package com.shop.shop.mapper;

import org.springframework.stereotype.Component;

import com.shop.shop.domain.Commission;
import com.shop.shop.dto.CommissionResponseDTO;

@Component
public class CommissionMapper {

    public CommissionResponseDTO toResponseDTO(Commission commission) {
        if (commission == null) {
            return null;
        }

        return new CommissionResponseDTO(
                commission.getId(),
                commission.getShopId(),
                null,
                commission.getTotalRevenue(),
                commission.getCommissionRate(),
                commission.getCommissionAmount(),
                commission.getCalculationDate(),
                commission.getFromDate(),
                commission.getToDate(),
                commission.getStatus(),
                commission.getCreatedAt(),
                commission.getUpdatedAt());
    }
}
