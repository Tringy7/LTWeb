package com.shop.shop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;

@Repository
public interface ProductDetailRepository extends JpaRepository<ProductDetail, Long> {

    // Find all product details by product ID
    List<ProductDetail> findByProductId(Long productId);

    // Find product detail by product ID and size
    ProductDetail findByProductIdAndSize(Long productId, String size);

    // Check if product detail exists for product and size
    boolean existsByProductIdAndSize(Long productId, String size);

    // Delete all product details for a product
    void deleteByProductId(Long productId);

    // Find product details with quantity greater than 0
    List<ProductDetail> findByProductIdAndQuantityGreaterThan(Long productId, Long quantity);

    // Count product details for a product
    long countByProductId(Long productId);

    ProductDetail findByProductAndSize(Product product, String size);
}
