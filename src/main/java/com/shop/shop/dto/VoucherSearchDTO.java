package com.shop.shop.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class VoucherSearchDTO {

    private String keyword;
    private String status;
    private String voucherType; // "SYSTEM", "SHOP", "ALL"

    @Override
    public String toString() {
        return "VoucherSearchDTO{" +
                "keyword='" + keyword + '\'' +
                ", status='" + status + '\'' +
                ", voucherType='" + voucherType + '\'' +
                '}';
    }
}
