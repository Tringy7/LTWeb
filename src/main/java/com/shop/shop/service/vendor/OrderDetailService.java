package com.shop.shop.service.vendor;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.OrderDetail;
import com.shop.shop.dto.OrderDetailDTO;
import com.shop.shop.repository.OrderDetailRepository;

@Service("vendorOrderDetailService")
public class OrderDetailService {

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    public List<OrderDetail> getOrderDetailsByOrderId(Long orderId) {
        return orderDetailRepository.findByOrder_Id(orderId);
    }

    public List<OrderDetailDTO> getOrderDetailsByOrderIdAndShopId(Long orderId, Long shopId) {
        return orderDetailRepository.findOrderDetailsDTOByOrderIdAndShopId(orderId, shopId);
    }

}
