package com.shop.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.shop.shop.domain.Product;

public interface ProductRepository extends JpaRepository<Product, Long> {

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
