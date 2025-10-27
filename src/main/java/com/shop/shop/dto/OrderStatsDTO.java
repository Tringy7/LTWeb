package com.shop.shop.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderStatsDTO {
    private Long totalOrders;
    private Long newOrders;
    private Long processingOrders;
    private Long deliveredOrders;
    private Long cancelledOrders;

    // Derived properties for percentages
    public Double getNewOrdersPercent() {
        if (totalOrders == null || totalOrders == 0)
            return 0.0;
        return (newOrders != null ? newOrders.doubleValue() / totalOrders.doubleValue() * 100 : 0.0);
    }

    public Double getProcessingOrdersPercent() {
        if (totalOrders == null || totalOrders == 0)
            return 0.0;
        return (processingOrders != null ? processingOrders.doubleValue() / totalOrders.doubleValue() * 100 : 0.0);
    }

    public Double getDeliveredOrdersPercent() {
        if (totalOrders == null || totalOrders == 0)
            return 0.0;
        return (deliveredOrders != null ? deliveredOrders.doubleValue() / totalOrders.doubleValue() * 100 : 0.0);
    }

    public Double getCancelledOrdersPercent() {
        if (totalOrders == null || totalOrders == 0)
            return 0.0;
        return (cancelledOrders != null ? cancelledOrders.doubleValue() / totalOrders.doubleValue() * 100 : 0.0);
    }
}
