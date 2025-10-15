package com.shop.shop.service.vendor;

import com.shop.shop.domain.OrderDetail;
import com.shop.shop.repository.OrderDetailRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderDetailService {

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    public List<OrderDetail> getOrderDetailsByOrderId(Long orderId) {
        return orderDetailRepository.findByOrder_Id(orderId);
    }

    public List<OrderDetail> getOrderDetailsByOrderIdAndShopId(Long orderId, Long shopId) {
        return orderDetailRepository.findByOrderIdAndShopId(orderId, shopId);
    }

    
}
