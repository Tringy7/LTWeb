package com.shop.shop.repository;

import com.shop.shop.domain.Order;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

     @Query("SELECT o FROM Order o WHERE "
               + "(:status IS NULL OR :status = '' OR o.status = :status) "
               + "AND (:fromDate IS NULL OR o.createdAt >= :fromDate) "
               + "AND (:toDate IS NULL OR o.createdAt <= :toDate)")
     List<Order> filterOrders(
               @Param("status") String status,
               @Param("fromDate") LocalDateTime fromDate,
               @Param("toDate") LocalDateTime toDate);

     @Query("SELECT COUNT(o) FROM Order o WHERE o.shop.id = :shopId")
     long countByShopId(Long shopId);

     @Query("SELECT COALESCE(SUM(o.totalPrice), 0) FROM Order o WHERE o.shop.id = :shopId AND o.status = 'Đã giao'")
     Double getTotalRevenueByShop(Long shopId);

     @Query("SELECT o FROM Order o WHERE " +
               "(:shopId IS NULL OR o.shop.id = :shopId) AND " +
               "(:status IS NULL OR o.status = :status) AND " +
               "(:startDate IS NULL OR o.createdAt >= :startDate) AND " +
               "(:endDate IS NULL OR o.createdAt <= :endDate)")
     List<Order> filterOrdersByShop(
               @Param("shopId") Long shopId,
               @Param("status") String status,
               @Param("startDate") LocalDateTime startDate,
               @Param("endDate") LocalDateTime endDate);
}
