package com.shop.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Carrier;

@Repository
public interface CarrierRepository extends JpaRepository<Carrier, Long> {

    /**
     * Search carriers by name, status, and area
     */
    @Query("SELECT c FROM Carrier c WHERE " +
            "(:searchTerm IS NULL OR :searchTerm = '' OR " +
            "LOWER(c.name) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
            "LOWER(c.email) LIKE LOWER(CONCAT('%', :searchTerm, '%')) OR " +
            "c.contactPhone LIKE CONCAT('%', :searchTerm, '%')) AND " +
            "(:status IS NULL OR :status = '' OR c.status = :status) AND " +
            "(:area IS NULL OR :area = '' OR LOWER(c.area) LIKE LOWER(CONCAT('%', :area, '%')))")
    List<Carrier> searchCarriers(@Param("searchTerm") String searchTerm,
            @Param("status") String status,
            @Param("area") String area);

    /**
     * Get all unique areas from carriers
     */
    @Query("SELECT DISTINCT c.area FROM Carrier c WHERE c.area IS NOT NULL AND c.area != '' ORDER BY c.area")
    List<String> findAllDistinctAreas();

    /**
     * Find carriers by status
     */
    List<Carrier> findByStatus(String status);

    /**
     * Find carriers by area
     */
    List<Carrier> findByAreaContainingIgnoreCase(String area);
}
