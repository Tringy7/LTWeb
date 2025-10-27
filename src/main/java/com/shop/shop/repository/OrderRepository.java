package com.shop.shop.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Order;
import com.shop.shop.domain.User;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

        List<Order> findByUser_IdOrderByCreatedAtDesc(Long userId);

        List<Order> findByCreatedAtBetweenOrderByCreatedAtDesc(LocalDateTime fromDate, LocalDateTime toDate);

        @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE od.shop.id = :shopId ORDER BY o.createdAt DESC")
        List<Order> findByShopIdOrderByCreatedAtDesc(@Param("shopId") Long shopId);

        @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE od.shop.id = :shopId AND od.status = :status AND o.createdAt BETWEEN :fromDate AND :toDate")
        List<Order> findByShopIdAndOrderDetailStatusAndCreatedAtBetween(@Param("shopId") Long shopId,
                        @Param("status") String status,
                        @Param("fromDate") LocalDateTime fromDate, @Param("toDate") LocalDateTime toDate);

        @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE od.status = :status AND o.createdAt BETWEEN :fromDate AND :toDate")
        List<Order> findByOrderDetailStatusAndCreatedAtBetween(@Param("status") String status,
                        @Param("fromDate") LocalDateTime fromDate, @Param("toDate") LocalDateTime toDate);

        Long countByCreatedAtBetween(LocalDateTime fromDate, LocalDateTime toDate);

        @Query("SELECT COUNT(DISTINCT o) FROM Order o JOIN o.orderDetails od WHERE od.status = :status")
        Long countByOrderDetailStatus(@Param("status") String status);

        Page<Order> findAllByOrderByCreatedAtDesc(Pageable pageable);

        @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od "
                        + "WHERE od.shop.id = :shopId "
                        + "AND (:status IS NULL OR UPPER(od.status) = UPPER(:status)) "
                        + "AND (:start IS NULL OR o.createdAt >= :start) "
                        + "AND (:end IS NULL OR o.createdAt <= :end) "
                        + "ORDER BY o.createdAt DESC")
        List<Order> findOrdersByShop(
                        @Param("shopId") Long shopId,
                        @Param("status") String status,
                        @Param("start") LocalDateTime start,
                        @Param("end") LocalDateTime end);

        @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE od.shop.id = :shopId ORDER BY o.createdAt DESC")
        List<Order> findByShopIdAndOrderStatus(@Param("shopId") Long shopId, @Param("orderStatus") String orderStatus);

        Optional<Order> findByTxnRef(String txnRef);

        Order findTopByUserAndPaymentStatusOrderByCreatedAtDesc(User user, Boolean paymentStatus);

        @org.springframework.data.jpa.repository.Modifying
        @Query(value = "DELETE FROM order_details WHERE order_id = :orderId", nativeQuery = true)
        void deleteOrderDetailsByOrderId(@Param("orderId") Long orderId);

        @Query("SELECT o FROM Order o WHERE "
                        + "(:fromDate IS NULL OR o.createdAt >= :fromDate) "
                        + "AND (:toDate IS NULL OR o.createdAt <= :toDate)")
        List<Order> filterOrders(
                        @Param("fromDate") LocalDateTime fromDate,
                        @Param("toDate") LocalDateTime toDate);

        @Query("SELECT COUNT(o) FROM Order o JOIN o.orderDetails od WHERE od.shop.id = :shopId")
        long countByShopId(@Param("shopId") Long shopId);

        @Query("SELECT COALESCE(SUM(o.totalPrice), 0) FROM Order o JOIN o.orderDetails od WHERE od.shop.id = :shopId")
        Double getTotalRevenueByShop(@Param("shopId") Long shopId);

        @Query("SELECT o FROM Order o JOIN o.orderDetails od WHERE "
                        + "(:shopId IS NULL OR od.shop.id = :shopId) "
                        + "AND (:startDate IS NULL OR o.createdAt >= :startDate) "
                        + "AND (:endDate IS NULL OR o.createdAt <= :endDate)")
        List<Order> filterOrdersByShop(
                        @Param("shopId") Long shopId,
                        @Param("startDate") LocalDateTime startDate,
                        @Param("endDate") LocalDateTime endDate);

        @Query("SELECT DISTINCT o FROM Order o JOIN FETCH o.orderDetails WHERE o.id IN :ids")
        List<Order> findAllWithDetailsByIdIn(@Param("ids") List<Long> ids);

        @Query("""
                            SELECT DISTINCT o FROM Order o
                            JOIN o.orderDetails d
                            WHERE o.shop.id = :shopId
                            AND UPPER(TRIM(d.status)) = UPPER(:status)
                        """)
        List<Order> findByShopIdAndDetailStatus(@Param("shopId") Long shopId, @Param("status") String status);

        @Query("SELECT o FROM Order o WHERE o.shop.id = :shopId ORDER BY o.id ASC")
        List<Order> findByShopId(@Param("shopId") Long shopId);

}
