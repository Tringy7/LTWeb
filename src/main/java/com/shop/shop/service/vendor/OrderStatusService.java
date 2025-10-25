package com.shop.shop.service.vendor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Order;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.repository.OrderDetailRepository;
import com.shop.shop.repository.OrderRepository;

import jakarta.transaction.Transactional;

@Service
public class OrderStatusService {
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Transactional
    public void updateOrderStatusFromDetails(Long orderId) {
        List<OrderDetail> details = orderDetailRepository.findByOrder_Id(orderId);
        if (details == null || details.isEmpty())
            return;

        boolean allReturned = details.stream().allMatch(d -> "RETURNED".equals(d.getStatus()));
        boolean allCancelled = details.stream().allMatch(d -> "CANCELLED".equals(d.getStatus()));
        boolean allDelivered = details.stream().allMatch(d -> "DELIVERED".equals(d.getStatus()));
        boolean anyShipping = details.stream().anyMatch(d -> "SHIPPING".equals(d.getStatus()));
        boolean anyConfirmed = details.stream().anyMatch(d -> "CONFIRMED".equals(d.getStatus()));
        boolean anyPending = details.stream().anyMatch(d -> "PENDING".equals(d.getStatus()));

        String newStatus;
        if (allReturned)
            newStatus = "RETURNED";
        else if (allCancelled)
            newStatus = "CANCELLED";
        else if (allDelivered)
            newStatus = "DELIVERED";
        else if (anyShipping)
            newStatus = "SHIPPING";
        else if (anyConfirmed)
            newStatus = "CONFIRMED";
        else
            newStatus = "PENDING";

        Order order = orderRepository.findById(orderId).orElse(null);
        if (order != null && !newStatus.equals(order.getStatus())) {
            order.setStatus(newStatus);
            orderRepository.save(order);
        }
    }
}
