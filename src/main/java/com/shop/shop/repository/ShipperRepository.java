package com.shop.shop.repository;

import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import com.shop.shop.domain.Shipper;

public interface ShipperRepository extends JpaRepository<Shipper, Long> {
    Optional<Shipper> findByUser_Id(Long userId);

    // Find active shippers by carrier ID
    List<Shipper> findByCarrier_IdAndStatus(Long carrierId, String status);

    // Find shipper with least orders for a carrier (for load balancing)
    @Query("SELECT s FROM Shipper s WHERE s.carrier.id = :carrierId AND s.status = :status " +
            "ORDER BY (SELECT COUNT(od) FROM OrderDetail od WHERE od.shipper.id = s.id) ASC")
    List<Shipper> findShippersByCarrierOrderByWorkload(@Param("carrierId") Long carrierId,
            @Param("status") String status);
}
