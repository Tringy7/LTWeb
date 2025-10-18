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
                commission.getShopId(), // Uses helper method
                null, // shopName will be set by service
                commission.getTotalRevenue(),
                commission.getCommissionRate(), // Uses helper method
                commission.getCommissionAmount(), // Uses helper method
                commission.getCalculationDate(), // Uses helper method
                commission.getFromDate(), // Uses helper method
                commission.getToDate(), // Uses helper method
                commission.getStatus(),
                commission.getCreatedAt(),
                commission.getUpdatedAt()); // Uses helper method
    }
}
