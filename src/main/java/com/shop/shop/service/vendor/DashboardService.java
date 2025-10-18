package com.shop.shop.service.vendor;

import org.springframework.stereotype.Service;
import com.shop.shop.repository.*;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DashboardService {

    private final ProductRepository productRepository;
    private final VoucherRepository productVoucherRepository;
    private final OrderRepository orderRepository;

    public long getTotalProducts(Long shopId) {
        return productRepository.countByShopId(shopId);
    }

    public long getTotalVouchers(Long shopId) {
        return 20;
    }

    public long getTotalOrders(Long shopId) {
        return orderRepository.countByShopId(shopId);
    }

    public Double getTotalRevenue(Long shopId) {
        return orderRepository.getTotalRevenueByShop(shopId);
    }
}
