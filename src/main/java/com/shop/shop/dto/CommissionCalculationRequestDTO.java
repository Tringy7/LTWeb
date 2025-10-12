package com.shop.shop.dto;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
public class CommissionCalculationRequestDTO {
    private LocalDate fromDate;
    private LocalDate toDate;
    private Boolean calculateUpToNow = false;
}
