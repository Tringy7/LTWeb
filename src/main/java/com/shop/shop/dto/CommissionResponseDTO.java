package com.shop.shop.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommissionResponseDTO {
    private Long id;
    private Long shopId;
    private String shopName;
    private BigDecimal totalRevenue;
    private BigDecimal commissionRate;
    private BigDecimal commissionAmount;
    private LocalDate calculationDate;
    private LocalDate fromDate;
    private LocalDate toDate;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // Helper methods for JSP compatibility
    public Date getCalculationDateAsDate() {
        return calculationDate != null ? Date.from(calculationDate.atStartOfDay(ZoneId.systemDefault()).toInstant())
                : null;
    }

    public Date getFromDateAsDate() {
        return fromDate != null ? Date.from(fromDate.atStartOfDay(ZoneId.systemDefault()).toInstant()) : null;
    }

    public Date getToDateAsDate() {
        return toDate != null ? Date.from(toDate.atStartOfDay(ZoneId.systemDefault()).toInstant()) : null;
    }

    public Date getCreatedAtAsDate() {
        return createdAt != null ? Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }

    public Date getUpdatedAtAsDate() {
        return updatedAt != null ? Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }

    // Add these helper methods for simple string formatting:
    public String getFormattedCalculationDate() {
        return calculationDate != null
                ? calculationDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy"))
                : "";
    }

    public String getFormattedFromDate() {
        return fromDate != null ? fromDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM")) : "";
    }

    public String getFormattedToDate() {
        return toDate != null ? toDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
    }

    public String getFormattedDateRange() {
        if (fromDate != null && toDate != null) {
            return getFormattedFromDate() + " - " + getFormattedToDate();
        }
        return "";
    }
}