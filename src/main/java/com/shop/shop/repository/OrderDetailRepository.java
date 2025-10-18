package com.shop.shop.repository;

import com.shop.shop.DTO.OrderDetailDTO;
import com.shop.shop.domain.OrderDetail;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
        List<OrderDetail> findByOrder_Id(Long orderId);

        @Query("SELECT new com.shop.shop.DTO.OrderDetailDTO(" +
                        "od.product.id, od.product.name, od.shop.shopName, od.quantity, od.price, od.product.image) " +
                        "FROM OrderDetail od " +
                        "WHERE od.order.id = :orderId AND od.shop.id = :shopId")
        List<OrderDetailDTO> findOrderDetailsDTOByOrderIdAndShopId(@Param("orderId") Long orderId,
                        @Param("shopId") Long shopId);

}
