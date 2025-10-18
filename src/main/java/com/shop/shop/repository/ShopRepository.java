package com.shop.shop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Shop;

@Repository
public interface ShopRepository extends JpaRepository<Shop, Long> {

}
