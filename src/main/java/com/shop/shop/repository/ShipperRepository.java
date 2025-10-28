package com.shop.shop.repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import com.shop.shop.domain.Shipper;

public interface ShipperRepository extends JpaRepository<Shipper, Long> {
    Optional<Shipper> findByUser_Id(Long userId);
}
