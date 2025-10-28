package com.shop.shop.service.shipper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
    
}
