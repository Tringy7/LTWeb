package com.shop.shop.repository;

import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.shop.shop.domain.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    @Query("SELECT p FROM Product p WHERE p.shop.id = :shopId")
    List<Product> findByShopId(Long shopId);

    @Query("SELECT COUNT(p) FROM Product p WHERE p.shop.id = :shopId")
    long countByShopId(Long shopId);

    @Query("SELECT p FROM Product p WHERE p.id = :id AND p.shop.id = :shopId")
    Optional<Product> findByIdAndShopId(Long id, Long shopId);

    @Query("SELECT p FROM Product p WHERE p.shop.id = :shopId AND LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Product> findByShopIdAndNameContaining(@Param("shopId") Long shopId, @Param("keyword") String keyword);

    @Query("SELECT DISTINCT p.category FROM Product p WHERE p.shop.id = :shopId")
    List<String> findDistinctCategoriesByShopId(@Param("shopId") Long shopId);

    @Query("SELECT p FROM Product p WHERE p.shop.id = :shopId AND p.category = :category")
    List<Product> findByShopIdAndCategory(@Param("shopId") Long shopId, @Param("category") String category);

    @Query("SELECT p FROM Product p WHERE p.shop.id = :shopId AND LOWER(p.name) LIKE LOWER(CONCAT('%', :keyword, '%')) AND (:category IS NULL OR p.category = :category)")
    List<Product> findByShopIdAndNameAndCategory(@Param("shopId") Long shopId, @Param("keyword") String keyword,
            @Param("category") String category);

}
