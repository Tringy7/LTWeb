package com.shop.shop.service.vendor;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Order;
import com.shop.shop.domain.OrderDetail;
import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;
import com.shop.shop.dto.OrderDetailDTO;
import com.shop.shop.repository.OrderDetailRepository;
import com.shop.shop.repository.OrderRepository;
import com.shop.shop.repository.ProductDetailRepository;
import com.shop.shop.repository.ProductRepository;

import jakarta.transaction.Transactional;

@Service("vendorOrderDetailService")
public class OrderDetailService {

    private final ProductDetailRepository productDetailRepository;

    @Autowired
    private OrderDetailRepository orderDetailRepository;

    @Autowired
    private OrderRepository OrderRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private OrderStatusService orderStatusService;

    OrderDetailService(ProductDetailRepository productDetailRepository) {
        this.productDetailRepository = productDetailRepository;
    }

    public List<OrderDetail> getOrderDetailsByOrderId(Long orderId) {
        return orderDetailRepository.findByOrder_Id(orderId);
    }

    public List<OrderDetailDTO> getOrderDetailsByOrderIdAndShopId(Long orderId, Long shopId) {
        return orderDetailRepository.findOrderDetailsDTOByOrderIdAndShopId(orderId, shopId);
    }

    public List<OrderDetail> getOrderDetailsByShopId(Long shopId) {
        return orderDetailRepository.findByShop_Id(shopId);
    }

    public List<OrderDetail> getOrderDetailsByOrderIdAndShopIdAsEntities(Long orderId, Long shopId) {
        return orderDetailRepository.findByOrder_IdAndShop_Id(orderId, shopId);
    }

    public Optional<OrderDetail> findById(Long id) {
        return orderDetailRepository.findById(id);
    }

    @Transactional
    public boolean updateShopStatusForOrderDetail(Long orderDetailId, String newStatus) {
        Optional<OrderDetail> opt = orderDetailRepository.findById(orderDetailId);
        if (opt.isPresent()) {
            OrderDetail od = opt.get();
            od.setStatus(newStatus == null ? null : newStatus.toUpperCase());
            orderDetailRepository.save(od);
            return true;
        }
        return false;
    }

    @Transactional
    public int updateShopStatusForOrder(Long orderId, Long shopId, String newStatus) {
        List<OrderDetail> list = orderDetailRepository.findByOrder_IdAndShop_Id(orderId, shopId);
        for (OrderDetail od : list) {
            od.setStatus(newStatus == null ? null : newStatus.toUpperCase());
            orderDetailRepository.save(od);
        }
        return list.size();
    }

    public List<Long> getOrderIdsByShopId(Long shopId) {
        return orderDetailRepository.findDistinctOrderIdsByShopId(shopId);
    }

    public boolean updateOrderDetailStatus(Long detailId, String status) {
        return orderDetailRepository.findById(detailId)
                .map(detail -> {
                    detail.setStatus(status);
                    orderDetailRepository.save(detail);
                    return true;
                })
                .orElse(false);
    }

    @Transactional
    public void returnedOrderDTToProduct(Long orderDTId) {
        OrderDetail orderDetails = orderDetailRepository.findById(orderDTId).get();
        if (orderDetails != null) {
            String size = orderDetails.getSize();
            Long quantity = orderDetails.getQuantity();
            Product product = orderDetails.getProduct();
            List<ProductDetail> pd = product.getProductDetails();
            for (ProductDetail p : pd) {
                if (p.getSize().equals(size)) {
                    p.setQuantity(p.getQuantity() + quantity);
                    p.setSold(p.getSold() - quantity);
                    productDetailRepository.save(p);
                }
            }
            orderDetails.setQuantity(0L);
            orderDetails.setPrice(0D);
            orderDetails.setFinalPrice(0D);
            orderDetailRepository.save(orderDetails);
        }
    }

    public void returnedOrderToProduct(Long orderId) {
        Order order = OrderRepository.findById(orderId).get();
        if (order != null) {
            List<OrderDetail> orderDetails = order.getOrderDetails();
            for (OrderDetail orderDetail : orderDetails) {
                if (orderDetail.getStatus().equals("RETURNED")) {
                    order.setTotalPrice(order.getTotalPrice() - orderDetail.getFinalPrice());
                    returnedOrderDTToProduct(orderDetail.getId());
                }
            }
            OrderRepository.save(order);
        }
    }
}
