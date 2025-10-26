package com.shop.shop.mapper;

import java.time.LocalDateTime;

import org.springframework.stereotype.Component;

import com.shop.shop.domain.Voucher;
import com.shop.shop.dto.VoucherCreateDTO;
import com.shop.shop.dto.VoucherResponseDTO;
import com.shop.shop.dto.VoucherUpdateDTO;

@Component
public class VoucherMapper {

    public VoucherResponseDTO toVoucherResponseDTO(Voucher voucher) {
        if (voucher == null) {
            return null;
        }

        VoucherResponseDTO dto = new VoucherResponseDTO();
        dto.setId(voucher.getId());
        dto.setCode(voucher.getCode());
        dto.setDiscountPercent(voucher.getDiscountPercent());
        dto.setStartDate(voucher.getStartDate());
        dto.setEndDate(voucher.getEndDate());
        dto.setStatus(voucher.getStatus());

        // Set shop information
        if (voucher.getShop() != null) {
            dto.setShopId(voucher.getShop().getId());
            dto.setShopName(voucher.getShop().getShopName());
            dto.setVoucherType("SHOP");
        } else {
            dto.setVoucherType("SYSTEM");
        }

        // Set calculated fields
        LocalDateTime now = LocalDateTime.now();
        dto.setExpired(voucher.getEndDate().isBefore(now));
        dto.setActive("Active".equals(voucher.getStatus()) &&
                voucher.getStartDate().isBefore(now) &&
                voucher.getEndDate().isAfter(now));

        // Set usage count (will be set by service layer if needed)
        dto.setUsageCount(0);

        return dto;
    }

    public Voucher toVoucherEntity(VoucherCreateDTO createDTO) {
        if (createDTO == null) {
            return null;
        }

        Voucher voucher = new Voucher();
        voucher.setCode(createDTO.getCode());
        voucher.setDiscountPercent(createDTO.getDiscountPercent());
        voucher.setStartDate(createDTO.getStartDate());
        voucher.setEndDate(createDTO.getEndDate());
        voucher.setStatus(createDTO.getStatus());
        // Shop will be set to null for system vouchers

        return voucher;
    }

    public void updateVoucherFromDTO(VoucherUpdateDTO updateDTO, Voucher voucher) {
        if (updateDTO == null || voucher == null) {
            return;
        }

        voucher.setCode(updateDTO.getCode());
        voucher.setDiscountPercent(updateDTO.getDiscountPercent());
        voucher.setStartDate(updateDTO.getStartDate());
        voucher.setEndDate(updateDTO.getEndDate());
        voucher.setStatus(updateDTO.getStatus());
    }

    public VoucherUpdateDTO toVoucherUpdateDTO(Voucher voucher) {
        if (voucher == null) {
            return null;
        }

        VoucherUpdateDTO dto = new VoucherUpdateDTO();
        dto.setId(voucher.getId());
        dto.setCode(voucher.getCode());
        dto.setDiscountPercent(voucher.getDiscountPercent());
        dto.setStartDate(voucher.getStartDate());
        dto.setEndDate(voucher.getEndDate());
        dto.setStatus(voucher.getStatus());

        return dto;
    }
}
