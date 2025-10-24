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

    @Query("SELECT o FROM Order o WHERE "
            + "(:shopId IS NULL OR o.shop.id = :shopId) AND "
            + "(:status IS NULL OR o.status = :status) AND "
            + "(:startDate IS NULL OR o.createdAt >= :startDate) AND "
            + "(:endDate IS NULL OR o.createdAt <= :endDate)")
    List<Order> filterOrdersByShop(
            @Param("shopId") Long shopId,
            @Param("status") String status,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate);

    List<Order> findByShopId(Long shopId);

    // @Modifying(clearAutomatically = true, flushAutomatically = true)
    // @Query("UPDATE Order o SET o.status = :status WHERE o.id = :orderId")
    // void updateStatus(@Param("orderId") Long orderId, @Param("status") String
    // status);
    List<Order> findByStatus(String status);

    // Lọc đơn hàng theo shop + trạng thái
    List<Order> findByShopIdAndStatus(Long shopId, String status);

    // Find orders by shop ID - Spring Data JPA auto-implementation
    List<Order> findByShop_IdOrderByCreatedAtDesc(Long shopId);

    // Find orders by status - Spring Data JPA auto-implementation
    List<Order> findByStatusOrderByCreatedAtDesc(String status);

    // Find orders by date range - Spring Data JPA auto-implementation
    List<Order> findByCreatedAtBetweenOrderByCreatedAtDesc(LocalDateTime fromDate, LocalDateTime toDate);

    // Find delivered orders by shop and date range - Spring Data JPA
    // auto-implementation
    List<Order> findByShop_IdAndStatusAndCreatedAtBetween(Long shopId, String status,
            LocalDateTime fromDate, LocalDateTime toDate);

    // Find delivered orders in date range - Spring Data JPA auto-implementation
    List<Order> findByStatusAndCreatedAtBetween(String status, LocalDateTime fromDate, LocalDateTime toDate);

    // Count orders by date range
    Long countByCreatedAtBetween(LocalDateTime fromDate, LocalDateTime toDate);

    // Count orders by status
    Long countByStatus(String status);

    // Find all orders with pagination ordered by creation date
    Page<Order> findAllByOrderByCreatedAtDesc(Pageable pageable);

    Optional<Order> findByTxnRef(String txnRef);

    // Find the most recent order by user and status
    Order findTopByUserAndStatusOrderByCreatedAtDesc(User user, String status);
}
