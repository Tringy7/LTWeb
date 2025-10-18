package com.shop.shop.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Product;

/**
 * Repository interface for Product entity
 * Follows clean architecture: Data access abstraction
 */
@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

        // Find products by shop ID
        List<Product> findByShopId(Long shopId);

        // Find products by name containing (case insensitive)
        List<Product> findByNameContainingIgnoreCase(String name);

        // Find products by brand containing (case insensitive)
        List<Product> findByBrandContainingIgnoreCase(String brand);

        // Find products by category containing (case insensitive)
        List<Product> findByCategoryContainingIgnoreCase(String category);

        // Search products by multiple criteria
        List<Product> findByNameContainingIgnoreCaseOrBrandContainingIgnoreCaseOrCategoryContainingIgnoreCase(
                        String name, String brand, String category);

        // Search products by keyword and shop - multiple field search
        List<Product> findByShopIdAndNameContainingIgnoreCase(Long shopId, String name);

        List<Product> findByShopIdAndBrandContainingIgnoreCase(Long shopId, String brand);

        List<Product> findByShopIdAndCategoryContainingIgnoreCase(Long shopId, String category);

        // Complex search for shop products by multiple criteria
        List<Product> findByShopIdAndNameContainingIgnoreCaseOrShopIdAndBrandContainingIgnoreCaseOrShopIdAndCategoryContainingIgnoreCase(
                        Long shopId1, String name, Long shopId2, String brand, Long shopId3, String category);

        // Check if product name exists in shop
        boolean existsByNameAndShopId(String name, Long shopId);

        // Count products by shop
        long countByShopId(Long shopId);

        // Find products with price range
        List<Product> findByPriceBetween(Double minPrice, Double maxPrice);

        // Find products by gender
        List<Product> findByGender(String gender);

        // Find products by shop ID ordered by ID descending
        List<Product> findByShop_IdOrderByIdDesc(Long shopId);

        // Find all products with pagination ordered by ID
        Page<Product> findAllByOrderByIdDesc(Pageable pageable);
}
