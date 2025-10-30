package com.shop.shop.service.shipper;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.OrderDetail;
import com.shop.shop.repository.OrderDetailRepository;

@Service
public class ShipperOrderDetailService {
    @Autowired
    private OrderDetailRepository orderDetailRepository;

    public Long countByStatusAndShipper(String status, Long shipperId) {
        if (shipperId == null)
            return 0L;
        return orderDetailRepository.countByStatusAndShipperId(status.toUpperCase(), shipperId);
    }

    public Optional<OrderDetail> getById(Long id) {
        return orderDetailRepository.findById(id);
    }

    public void updateStatus(Long id, String status) {
        OrderDetail detail = orderDetailRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Chi tiết đơn hàng không tồn tại"));
        detail.setStatus(status.toUpperCase());
        orderDetailRepository.save(detail);
    }

    public List<OrderDetail> getShippingOrdersByShipper(Long shipperId) {
        return orderDetailRepository.findByStatusAndShipper_Id("SHIPPING", shipperId);
    }

    public OrderDetail findById(Long id) {
        return orderDetailRepository.findById(id).orElse(null);
    }

    public Optional<OrderDetail> getOrderDetailById(Long id) {
        return orderDetailRepository.findById(id);
    }

    public void updateOrderStatus(Long id, String status) {
        OrderDetail detail = orderDetailRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Chi tiết đơn hàng không tồn tại"));
        detail.setStatus(status.toUpperCase());
        orderDetailRepository.save(detail);
    }

}
