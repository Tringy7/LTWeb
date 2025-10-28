package com.shop.shop.service.shipper;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.repository.OrderDetailRepository;

@Service
public class ShipperOrderService {

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    public List<OrderDetail> getOrdersByShipperId(Long shipperId) {
        return orderDetailRepository.findByShipper_Id(shipperId);
    }

    public void updateOrderStatus(Long id, String status) {
        OrderDetail detail = orderDetailRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Chi tiết đơn hàng không tồn tại"));
        detail.setStatus(status.toUpperCase());
        orderDetailRepository.save(detail);
    }

    public Optional<OrderDetail> getOrderDetailById(Long id) {
        return orderDetailRepository.findById(id);
    }

}
