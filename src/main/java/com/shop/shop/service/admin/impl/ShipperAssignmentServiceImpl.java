package com.shop.shop.service.admin.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.shop.domain.Carrier;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.domain.Shipper;
import com.shop.shop.repository.CarrierRepository;
import com.shop.shop.repository.OrderDetailRepository;
import com.shop.shop.repository.ShipperRepository;
import com.shop.shop.service.admin.ShipperAssignmentService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class ShipperAssignmentServiceImpl implements ShipperAssignmentService {

    private final OrderDetailRepository orderDetailRepository;
    private final ShipperRepository shipperRepository;
    private final CarrierRepository carrierRepository;

    @Override
    public OrderDetail assignShipperToOrderDetail(Long orderDetailId, Long shipperId) {
        Optional<OrderDetail> orderDetailOpt = orderDetailRepository.findById(orderDetailId);
        Optional<Shipper> shipperOpt = shipperRepository.findById(shipperId);

        if (orderDetailOpt.isEmpty()) {
            throw new RuntimeException("Order detail not found with ID: " + orderDetailId);
        }

        if (shipperOpt.isEmpty()) {
            throw new RuntimeException("Shipper not found with ID: " + shipperId);
        }

        OrderDetail orderDetail = orderDetailOpt.get();
        Shipper shipper = shipperOpt.get();

        // Validate that shipper belongs to the same carrier as the order detail
        if (orderDetail.getCarrier() != null &&
                !orderDetail.getCarrier().getId().equals(shipper.getCarrier().getId())) {
            throw new RuntimeException("Shipper does not belong to the same carrier as the order detail");
        }

        // Assign shipper to order detail
        orderDetail.setShipper(shipper);

        return orderDetailRepository.save(orderDetail);
    }

    @Override
    public List<OrderDetail> autoAssignShippersForCarrier(Long carrierId) {
        // Get unassigned order details for this carrier with status CONFIRMED
        List<OrderDetail> unassignedOrders = orderDetailRepository
                .findUnassignedOrderDetailsByCarrierAndStatus(carrierId, "CONFIRMED");

        for (OrderDetail orderDetail : unassignedOrders) {
            Shipper optimalShipper = getOptimalShipperForCarrier(carrierId);
            if (optimalShipper != null) {
                orderDetail.setShipper(optimalShipper);
            }
        }

        return orderDetailRepository.saveAll(unassignedOrders);
    }

    @Override
    public List<OrderDetail> autoAssignAllUnassignedOrders() {
        List<Carrier> carriers = carrierRepository.findAll();
        List<OrderDetail> allAssignedOrders = new java.util.ArrayList<>();

        for (Carrier carrier : carriers) {
            if ("ACTIVE".equals(carrier.getStatus())) {
                List<OrderDetail> assignedOrders = autoAssignShippersForCarrier(carrier.getId());
                allAssignedOrders.addAll(assignedOrders);
            }
        }

        return allAssignedOrders;
    }

    @Override
    public List<Shipper> getAvailableShippersForCarrier(Long carrierId) {
        return shipperRepository.findByCarrier_IdAndStatus(carrierId, "ACTIVE");
    }

    @Override
    public List<OrderDetail> getUnassignedOrderDetailsForCarrier(Long carrierId) {
        return orderDetailRepository.findByCarrier_IdAndShipperIsNull(carrierId);
    }

    @Override
    public List<Carrier> getAllCarriersWithStats() {
        return carrierRepository.findAll();
    }

    @Override
    public Shipper getOptimalShipperForCarrier(Long carrierId) {
        List<Shipper> shippers = shipperRepository
                .findShippersByCarrierOrderByWorkload(carrierId, "ACTIVE");

        return shippers.isEmpty() ? null : shippers.get(0);
    }

    @Override
    public List<OrderDetail> getOrderDetailsNeedingAssignment(String status) {
        final String finalStatus = (status == null || status.trim().isEmpty()) ? "CONFIRMED" : status;

        return orderDetailRepository.findUnassignedOrderDetailsByStatus(finalStatus);
    }

    @Override
    public Carrier getCarrierById(Long carrierId) {
        Optional<Carrier> carrierOpt = carrierRepository.findById(carrierId);
        if (carrierOpt.isEmpty()) {
            throw new RuntimeException("Carrier not found with ID: " + carrierId);
        }
        return carrierOpt.get();
    }

    @Override
    public Carrier updateCarrierDeliveryFee(Long carrierId, Double deliveryFee) {
        if (deliveryFee == null || deliveryFee < 0) {
            throw new RuntimeException("Delivery fee must be a positive number");
        }

        Optional<Carrier> carrierOpt = carrierRepository.findById(carrierId);
        if (carrierOpt.isEmpty()) {
            throw new RuntimeException("Carrier not found with ID: " + carrierId);
        }

        Carrier carrier = carrierOpt.get();
        carrier.setDeliveryFee(deliveryFee);
        return carrierRepository.save(carrier);
    }

    @Override
    public List<Carrier> searchCarriers(String searchTerm, String status, String area) {
        return carrierRepository.searchCarriers(searchTerm, status, area);
    }

    @Override
    public List<String> getAllCarrierAreas() {
        return carrierRepository.findAllDistinctAreas();
    }
}
