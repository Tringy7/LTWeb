package com.shop.shop.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Order;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

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
}
