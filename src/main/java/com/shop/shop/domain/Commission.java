package com.shop.shop.domain;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "commissions")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Commission {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "shop_id", nullable = false)
    private Shop shop; // Quan hệ n:1 với bảng Shop

    @Column(name = "period_start", nullable = false)
    private LocalDate periodStart;

    @Column(name = "period_end", nullable = false)
    private LocalDate periodEnd;

    @Column(name = "total_revenue", precision = 15, scale = 2, nullable = false)
    private BigDecimal totalRevenue;

    @Column(name = "percent", precision = 5, scale = 2)
    private BigDecimal percent = BigDecimal.valueOf(5.00); // Mặc định 5%

    @Column(name = "amount", precision = 15, scale = 2, nullable = false)
    private BigDecimal amount; // totalRevenue * percent / 100

    @Column(name = "status", length = 50)
    private String status = "pending";

    @Column(name = "created_at")
    private LocalDateTime createdAt = LocalDateTime.now();

    // Helper methods to match the service layer expectations
    public Long getShopId() {
        return shop != null ? shop.getId() : null;
    }

    public LocalDate getCalculationDate() {
        return createdAt != null ? createdAt.toLocalDate() : null;
    }

    public LocalDate getFromDate() {
        return periodStart;
    }

    public LocalDate getToDate() {
        return periodEnd;
    }

    public BigDecimal getCommissionAmount() {
        return amount;
    }

    public BigDecimal getCommissionRate() {
        return percent != null ? percent.divide(BigDecimal.valueOf(100)) : BigDecimal.valueOf(0.05);
    }

    public LocalDateTime getUpdatedAt() {
        return createdAt; // Since there's no updatedAt field in entity
    }
}
