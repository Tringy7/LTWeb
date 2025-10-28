package com.shop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Carrier;

@Repository
public interface CarrierRepository extends JpaRepository<Carrier, Long> {

}
