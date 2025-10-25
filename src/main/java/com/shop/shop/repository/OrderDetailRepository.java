package com.shop.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.OrderDetail;
import com.shop.shop.dto.OrderDetailDTO;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    List<OrderDetail> findByOrder_Id(Long orderId);

    @Query("SELECT new com.shop.shop.dto.OrderDetailDTO("
            + "od.id, od.product.id, od.product.name, od.shop.shopName, od.quantity, od.price, od.product.image, od.status) "
            + "FROM OrderDetail od "
            + "WHERE od.order.id = :orderId AND od.shop.id = :shopId")
    List<OrderDetailDTO> findOrderDetailsDTOByOrderIdAndShopId(@Param("orderId") Long orderId,
            @Param("shopId") Long shopId);

    List<OrderDetail> findByShop_Id(Long shopId);

    // Lấy tất cả orderDetail thuộc 1 order và 1 shop (thường dùng khi xem detail
    // của 1 order)
    List<OrderDetail> findByOrder_IdAndShop_Id(Long orderId, Long shopId);

    @Query("SELECT od FROM OrderDetail od WHERE od.order.id = :orderId AND od.shop.id = :shopId AND (:status IS NULL OR UPPER(od.status) = UPPER(:status))")
    List<OrderDetail> findByOrderAndShopAndStatus(@Param("orderId") Long orderId,
            @Param("shopId") Long shopId,
            @Param("status") String status);

    @Query("SELECT DISTINCT od.order.id FROM OrderDetail od WHERE od.shop.id = :shopId")
    List<Long> findDistinctOrderIdsByShopId(@Param("shopId") Long shopId);

}
