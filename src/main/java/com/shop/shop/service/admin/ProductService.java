package com.shop.shop.service.admin;

import java.util.List;
import java.util.Optional;

import com.shop.shop.domain.Product;

/**
 * Service interface for Product business logic
 * Follows clean architecture: Business logic abstraction
 */
public interface ProductService {

    // Get all products
    List<Product> getAllProducts();

    // Get product by ID
    Optional<Product> getProductById(Long id);

    // Get products by shop ID
    List<Product> getProductsByShopId(Long shopId);

    // Search products by keyword
    List<Product> searchProducts(String keyword);

    // Search products by keyword and shop
    List<Product> searchProductsByKeywordAndShop(String keyword, Long shopId);

    // Search products by category
    List<Product> getProductsByCategory(String category);

    // Search products by brand
    List<Product> getProductsByBrand(String brand);

    // Save product
    Product saveProduct(Product product);

    // Delete product by ID
    void deleteProduct(Long id);

    // Check if product name exists in shop
    boolean existsByNameAndShopId(String name, Long shopId);

    // Count products by shop
    long countProductsByShopId(Long shopId);

    // Get total quantity for product
    Long getTotalQuantityForProduct(Long productId);

    // Get total sold for product
    Long getTotalSoldForProduct(Long productId);

    // Enrich ProductResponseDTO with calculated fields
    void enrichProductResponseDTO(com.shop.shop.dto.ProductResponseDTO dto);
}
