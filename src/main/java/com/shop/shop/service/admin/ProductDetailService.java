package com.shop.shop.service.admin;

import java.util.List;

import com.shop.shop.domain.ProductDetail;

/**
 * Service interface for ProductDetail business logic
 * Follows clean architecture: Business logic abstraction
 */
public interface ProductDetailService {

    // Get all product details for a product
    List<ProductDetail> getProductDetailsByProductId(Long productId);

    // Get product detail by product ID and size
    ProductDetail getProductDetailByProductIdAndSize(Long productId, String size);

    // Save product detail
    ProductDetail saveProductDetail(ProductDetail productDetail);

    // Delete product detail
    void deleteProductDetail(Long id);

    // Delete all product details for a product
    void deleteProductDetailsByProductId(Long productId);

    // Check if product detail exists
    boolean existsByProductIdAndSize(Long productId, String size);

    // Get available sizes for a product
    List<String> getAvailableSizesForProduct(Long productId);

    // Get product details with available stock
    List<ProductDetail> getProductDetailsWithStock(Long productId);

    // Calculate total quantity for a product
    Long calculateTotalQuantity(Long productId);

    // Calculate total sold for a product
    Long calculateTotalSold(Long productId);

    // Update stock for a product detail
    ProductDetail updateStock(Long productId, String size, Long newQuantity);

    // Add to sold quantity
    ProductDetail addToSoldQuantity(Long productId, String size, Long soldAmount);
}
