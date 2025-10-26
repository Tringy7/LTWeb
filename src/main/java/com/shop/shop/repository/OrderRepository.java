package com.shop.shop.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    // Find orders by user ID - Spring Data JPA auto-implementation
    List<Order> findByUser_IdOrderByCreatedAtDesc(Long userId);

    // Find orders by date range - Spring Data JPA auto-implementation
    List<Order> findByCreatedAtBetweenOrderByCreatedAtDesc(LocalDateTime fromDate, LocalDateTime toDate);

    // Find orders that contain products from a specific shop
    @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE od.shop.id = :shopId ORDER BY o.createdAt DESC")
    List<Order> findByShopIdOrderByCreatedAtDesc(@Param("shopId") Long shopId);

    // Find orders containing products from a specific shop with specific order
    // detail status in date range
    @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE od.shop.id = :shopId AND od.status = :status AND o.createdAt BETWEEN :fromDate AND :toDate")
    List<Order> findByShopIdAndOrderDetailStatusAndCreatedAtBetween(@Param("shopId") Long shopId,
            @Param("status") String status,
            @Param("fromDate") LocalDateTime fromDate, @Param("toDate") LocalDateTime toDate);

    // Find orders that have at least one order detail with specific status in date
    // range
    @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE od.status = :status AND o.createdAt BETWEEN :fromDate AND :toDate")
    List<Order> findByOrderDetailStatusAndCreatedAtBetween(@Param("status") String status,
            @Param("fromDate") LocalDateTime fromDate, @Param("toDate") LocalDateTime toDate);

    // Count orders by date range
    Long countByCreatedAtBetween(LocalDateTime fromDate, LocalDateTime toDate);

    // Count orders that have at least one order detail with specific status
    @Query("SELECT COUNT(DISTINCT o) FROM Order o JOIN o.orderDetails od WHERE od.status = :status")
    Long countByOrderDetailStatus(@Param("status") String status);

    // Find all orders with pagination ordered by creation date
    Page<Order> findAllByOrderByCreatedAtDesc(Pageable pageable);

    // Count orders containing products from a specific shop
    @Query("SELECT COUNT(DISTINCT o) FROM Order o JOIN o.orderDetails od WHERE od.shop.id = :shopId")
    Long countByShopId(@Param("shopId") Long shopId);
}
