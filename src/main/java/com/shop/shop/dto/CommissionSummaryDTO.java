package com.shop.shop.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CommissionSummaryDTO {

    private Integer totalShops;
    private BigDecimal totalRevenue;
    private BigDecimal totalCommissionAmount;
    private BigDecimal averageCommissionPerShop;
    private BigDecimal commissionPercent;
    private LocalDate summaryDate;
    private String periodType; // "MONTHLY", "YEARLY", "CUSTOM"
    private LocalDate periodStart;
    private LocalDate periodEnd;

    // Calculated fields
    private Integer collectedCommissions;
    private Integer pendingCommissions;
    private BigDecimal collectedAmount;
    private BigDecimal pendingAmount;

    // Helper methods for JSP compatibility
    public String getFormattedTotalRevenue() {
        return totalRevenue != null ? String.format("%,.0f", totalRevenue) : "0";
    }

    public String getFormattedTotalCommissionAmount() {
        return totalCommissionAmount != null ? String.format("%,.0f", totalCommissionAmount) : "0";
    }

    public String getFormattedAverageCommissionPerShop() {
        return averageCommissionPerShop != null ? String.format("%,.0f", averageCommissionPerShop) : "0";
    }

    public String getFormattedCollectedAmount() {
        return collectedAmount != null ? String.format("%,.0f", collectedAmount) : "0";
    }

    public String getFormattedPendingAmount() {
        return pendingAmount != null ? String.format("%,.0f", pendingAmount) : "0";
    }

    public String getFormattedSummaryDate() {
        return summaryDate != null ? summaryDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
    }

    public String getFormattedPeriodStart() {
        return periodStart != null ? periodStart.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
    }

    public String getFormattedPeriodEnd() {
        return periodEnd != null ? periodEnd.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : "";
    }

    public String getFormattedPeriodRange() {
        if (periodStart != null && periodEnd != null) {
            return getFormattedPeriodStart() + " - " + getFormattedPeriodEnd();
        }
        return "";
    }

    // Calculate completion percentage
    public Double getCompletionPercentage() {
        if (totalShops != null && totalShops > 0 && collectedCommissions != null) {
            return (collectedCommissions.doubleValue() / totalShops.doubleValue()) * 100;
        }
        return 0.0;
    }

    public String getFormattedCompletionPercentage() {
        return String.format("%.1f%%", getCompletionPercentage());
    }
}