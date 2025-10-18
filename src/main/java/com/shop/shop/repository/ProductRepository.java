package com.shop.shop.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

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

    @Query("SELECT p FROM Product p WHERE "
            + "(p.price >= 0) AND "
            + "(:maxPrice IS NULL OR p.price <= :maxPrice) AND "
            + "(:brand IS NULL OR p.brand IN :brand) AND "
            + "(:size IS NULL OR EXISTS (SELECT pd FROM ProductDetail pd WHERE pd.product = p AND pd.size IN :size)) AND "
            + "(:color IS NULL OR p.color IN :color) AND "
            + "(:gender IS NULL OR p.gender IN :gender)")
    List<Product> filterProducts(
            @Param("maxPrice") Double maxPrice,
            @Param("brand") List<String> brand,
            @Param("size") List<String> size,
            @Param("color") List<String> color,
            @Param("gender") List<String> gender);

    List<Product> findByNameContainingIgnoreCase(String name);

}
