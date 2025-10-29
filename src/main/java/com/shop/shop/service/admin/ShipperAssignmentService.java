package com.shop.shop.service.admin;

import java.util.List;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.domain.Shipper;
import com.shop.shop.domain.Carrier;

public interface ShipperAssignmentService {

    /**
     * Assign a shipper to an order detail
     */
    OrderDetail assignShipperToOrderDetail(Long orderDetailId, Long shipperId);

    /**
     * Auto-assign shippers to all unassigned order details for a specific carrier
     */
    List<OrderDetail> autoAssignShippersForCarrier(Long carrierId);

    /**
     * Auto-assign shippers to all unassigned order details across all carriers
     */
    List<OrderDetail> autoAssignAllUnassignedOrders();

    /**
     * Get available shippers for a specific carrier
     */
    List<Shipper> getAvailableShippersForCarrier(Long carrierId);

    /**
     * Get unassigned order details for a specific carrier
     */
    List<OrderDetail> getUnassignedOrderDetailsForCarrier(Long carrierId);

    /**
     * Get all carriers with their statistics
     */
    List<Carrier> getAllCarriersWithStats();

    /**
     * Get optimal shipper for a carrier (least workload)
     */
    Shipper getOptimalShipperForCarrier(Long carrierId);

    /**
     * Get order details that need shipper assignment by status
     */
    List<OrderDetail> getOrderDetailsNeedingAssignment(String status);
}
