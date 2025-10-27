package com.shop.shop.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.OrderDetail;
import com.shop.shop.dto.OrderDetailDTO;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

        /**
         * Find order details by shop ID
         */
        List<OrderDetail> findByShopId(Long shopId);

        /**
         * Find order details by status (now in OrderDetail table) within a date
         * range
         */
        @Query("SELECT od FROM OrderDetail od WHERE od.status = ?1 AND od.order.createdAt BETWEEN ?2 AND ?3")
        List<OrderDetail> findByStatusAndOrderCreatedAtBetween(
                        String status,
                        LocalDateTime fromDateTime,
                        LocalDateTime toDateTime);

        /**
         * Find order details by shop and status within date range
         */
        @Query("SELECT od FROM OrderDetail od WHERE od.shop.id = ?1 AND od.status = ?2 AND od.order.createdAt BETWEEN ?3 AND ?4")
        List<OrderDetail> findByShopIdAndStatusAndOrderCreatedAtBetween(
                        Long shopId,
                        String status,
                        LocalDateTime fromDateTime,
                        LocalDateTime toDateTime);

        /**
         * Find order details by order ID
         */
        List<OrderDetail> findByOrderId(Long orderId);

        /**
         * Find order details by product ID
         */
        List<OrderDetail> findByProductId(Long productId);

        /**
         * Get total revenue for a shop within a date range (for delivered order
         * details)
         */
        @Query("SELECT COALESCE(SUM(od.finalPrice), 0) FROM OrderDetail od WHERE od.shop.id = ?1 AND od.status = 'DELIVERED' AND od.order.createdAt BETWEEN ?2 AND ?3")
        Double getTotalRevenueByShopAndDateRange(
                        Long shopId,
                        LocalDateTime fromDateTime,
                        LocalDateTime toDateTime);

        /**
         * Count order details by shop within date range (for delivered order
         * details)
         */
        @Query("SELECT COUNT(od) FROM OrderDetail od WHERE od.shop.id = ?1 AND od.status = 'DELIVERED' AND od.order.createdAt BETWEEN ?2 AND ?3")
        Long countByShopAndDateRange(
                        Long shopId,
                        LocalDateTime fromDateTime,
                        LocalDateTime toDateTime);

        /**
         * Get total revenue across all shops for delivered order details within
         * date range
         */
        @Query("SELECT COALESCE(SUM(od.finalPrice), 0) FROM OrderDetail od WHERE od.status = 'DELIVERED' AND od.order.createdAt BETWEEN ?1 AND ?2")
        Double getTotalRevenueByDateRange(
                        LocalDateTime fromDateTime,
                        LocalDateTime toDateTime);

        /**
         * Count orders that have at least one order detail with specific status
         */
        @Query("SELECT COUNT(DISTINCT od.order) FROM OrderDetail od WHERE od.status = ?1")
        Long countDistinctOrdersByStatus(String status);

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

        @Query("SELECT DISTINCT od.order.id FROM OrderDetail od WHERE od.shop.id = :shopId AND od.status = :status")
        List<Long> findDistinctOrderIdsByShopIdAndStatus(@Param("shopId") Long shopId, @Param("status") String status);

}
