package com.shop.shop.service.shipper;

import java.util.List;
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

    public void updateOrderStatus(Long orderDetailId, String newStatus) {
        OrderDetail orderDetail = orderDetailRepository.findById(orderDetailId)
                .orElseThrow(() -> new RuntimeException("Không tìm thấy OrderDetail với ID: " + orderDetailId));
        orderDetail.setStatus(newStatus);
        orderDetailRepository.save(orderDetail);
    }

}
