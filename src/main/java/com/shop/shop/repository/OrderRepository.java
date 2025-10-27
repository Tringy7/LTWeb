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

    // // Lấy orders chỉ theo shop (không filter)
    // @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE
    // od.shop.id = :shopId ORDER BY o.createdAt DESC")
    // List<Order> findByShopId(@Param("shopId") Long shopId);
    // Nếu cần lấy theo shop + order status tổng thể (không bắt buộc, hiếm dùng)
    @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE od.shop.id = :shopId AND (:orderStatus IS NULL OR UPPER(o.status) = UPPER(:orderStatus)) ORDER BY o.createdAt DESC")
    List<Order> findByShopIdAndOrderStatus(@Param("shopId") Long shopId, @Param("orderStatus") String orderStatus);

    Optional<Order> findByTxnRef(String txnRef);

    // Find the most recent order by user and status
    Order findTopByUserAndStatusOrderByCreatedAtDesc(User user, String status);

    // Find the most recent order by user where any orderDetail has the given status
    @Query("SELECT DISTINCT o FROM Order o JOIN o.orderDetails od WHERE o.user = :user AND UPPER(od.status) = UPPER(:detailStatus) ORDER BY o.createdAt DESC")
    Order findTopByUserAndOrderDetailStatusOrderByCreatedAtDesc(@Param("user") User user, @Param("detailStatus") String detailStatus);

    // Find the most recent order by user and paymentStatus (e.g., pending payment = false)
    Order findTopByUserAndPaymentStatusOrderByCreatedAtDesc(User user, Boolean paymentStatus);

    // Delete order using native query for better performance
    @org.springframework.data.jpa.repository.Modifying
    @Query(value = "DELETE FROM order_details WHERE order_id = :orderId", nativeQuery = true)
    void deleteOrderDetailsByOrderId(@Param("orderId") Long orderId);
}
