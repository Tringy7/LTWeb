package com.shop.shop.repository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Commission;

@Repository
public interface CommissionRepository extends JpaRepository<Commission, Long> {

    // Find commissions by shop ID - Spring Data JPA auto-implementation
    List<Commission> findByShop_IdOrderByCreatedAtDesc(Long shopId);

    // Find commissions by date range - Spring Data JPA auto-implementation
    List<Commission> findByCreatedAtBetweenOrderByCreatedAtDesc(LocalDateTime fromDateTime, LocalDateTime toDateTime);

    // Find commissions by status - Spring Data JPA auto-implementation
    List<Commission> findByStatusOrderByCreatedAtDesc(String status);

    // Simple query to check if commission exists - much safer than complex JPQL
    @Query("SELECT COUNT(c) > 0 FROM Commission c WHERE c.shop.id = :shopId AND c.periodStart = :periodStart AND c.periodEnd = :periodEnd")
    boolean existsByShopIdAndPeriodStartAndPeriodEnd(@Param("shopId") Long shopId,
            @Param("periodStart") LocalDate periodStart, @Param("periodEnd") LocalDate periodEnd);
}
