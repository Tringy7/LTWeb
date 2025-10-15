package com.shop.shop.repository;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.shop.shop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    @Query("SELECT p FROM Product p WHERE p.shop.id = :shopId")
    List<Product> findByShopId(Long shopId);

    @Query("SELECT COUNT(p) FROM Product p WHERE p.shop.id = :shopId")
    long countByShopId(Long shopId);

    @Query("SELECT p FROM Product p WHERE p.id = :id AND p.shop.id = :shopId")
    Optional<Product> findByIdAndShopId(Long id, Long shopId);
}
