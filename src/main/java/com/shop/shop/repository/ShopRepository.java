package com.shop.shop.repository;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Shop;
import com.shop.shop.domain.User;

/**
 * Repository interface for Shop entity Follows clean architecture: Data access
 * abstraction
 */
@Repository
public interface ShopRepository extends JpaRepository<Shop, Long> {

    // Find shops by user ID
    List<Shop> findByUserId(Long userId);

    // Find shops by shop name containing (case insensitive)
    List<Shop> findByShopNameContainingIgnoreCase(String shopName);

    // Find shops by description containing (case insensitive)
    List<Shop> findByDescriptionContainingIgnoreCase(String description);

    // Find shops by status
    List<Shop> findByStatus(String status);

    // Search shops by multiple criteria
    List<Shop> findByShopNameContainingIgnoreCaseOrDescriptionContainingIgnoreCase(
            String shopName, String description);

    // Check if shop name exists
    boolean existsByShopName(String shopName);

    // Find shops by user email
    @Query("SELECT s FROM Shop s WHERE s.user.email = :email")
    List<Shop> findByUserEmail(@Param("email") String email);

    // Find shops by user full name
    @Query("SELECT s FROM Shop s WHERE s.user.fullName LIKE %:fullName%")
    List<Shop> findByUserFullNameContaining(@Param("fullName") String fullName);

    // Count active shops
    long countByStatus(String status);

    // Find shops created between dates
    @Query("SELECT s FROM Shop s WHERE s.createdAt BETWEEN :startDate AND :endDate")
    List<Shop> findByCreatedAtBetween(
            @Param("startDate") java.time.LocalDateTime startDate,
            @Param("endDate") java.time.LocalDateTime endDate);

    // Count shops by date range
    Long countByCreatedAtBetween(LocalDateTime fromDate, LocalDateTime toDate);

    Optional<Shop> findFirstByUserId(Long userId);

    Shop findByUser(User user);
}
