package com.shop.shop.service.admin.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;
import com.shop.shop.dto.ProductResponseDTO;
import com.shop.shop.repository.ProductDetailRepository;
import com.shop.shop.repository.ProductRepository;
import com.shop.shop.service.admin.ProductService;

/**
 * Implementation of ProductService interface
 * Follows clean architecture: Business logic implementation
 */
@Service("adminProductService")
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;
    private final ProductDetailRepository productDetailRepository;

    public ProductServiceImpl(ProductRepository productRepository,
            ProductDetailRepository productDetailRepository) {
        this.productRepository = productRepository;
        this.productDetailRepository = productDetailRepository;
    }

    @Override
    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    @Override
    public Optional<Product> getProductById(Long id) {
        return productRepository.findById(id);
    }

    @Override
    public List<Product> getProductsByShopId(Long shopId) {
        return productRepository.findByShopId(shopId);
    }

    @Override
    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllProducts();
        }
        String searchKeyword = keyword.trim();
        return productRepository
                .findByNameContainingIgnoreCaseOrBrandContainingIgnoreCaseOrCategoryContainingIgnoreCase(
                        searchKeyword, searchKeyword, searchKeyword);
    }

    @Override
    public List<Product> searchProductsByKeywordAndShop(String keyword, Long shopId) {
        if (keyword == null || keyword.trim().isEmpty()) {
            if (shopId != null) {
                return productRepository.findByShopId(shopId);
            }
            return getAllProducts();
        }

        String searchKeyword = keyword.trim();
        if (shopId == null) {
            return searchProducts(searchKeyword);
        }

        // Search by name, brand, or category for the specific shop
        return productRepository
                .findByShopIdAndNameContainingIgnoreCaseOrShopIdAndBrandContainingIgnoreCaseOrShopIdAndCategoryContainingIgnoreCase(
                        shopId, searchKeyword, shopId, searchKeyword, shopId, searchKeyword);
    }

    @Override
    public List<Product> getProductsByCategory(String category) {
        return productRepository.findByCategoryContainingIgnoreCase(category);
    }

    @Override
    public List<Product> getProductsByBrand(String brand) {
        return productRepository.findByBrandContainingIgnoreCase(brand);
    }

    @Override
    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }

    @Override
    public void deleteProduct(Long id) {
        productRepository.deleteById(id);
    }

    @Override
    public boolean existsByNameAndShopId(String name, Long shopId) {
        return productRepository.existsByNameAndShopId(name, shopId);
    }

    @Override
    public long countProductsByShopId(Long shopId) {
        return productRepository.countByShopId(shopId);
    }

    @Override
    public Long getTotalQuantityForProduct(Long productId) {
        List<ProductDetail> productDetails = productDetailRepository.findByProductId(productId);
        return productDetails.stream()
                .mapToLong(detail -> detail.getQuantity() != null ? detail.getQuantity() : 0L)
                .sum();
    }

    @Override
    public Long getTotalSoldForProduct(Long productId) {
        List<ProductDetail> productDetails = productDetailRepository.findByProductId(productId);
        return productDetails.stream()
                .mapToLong(detail -> detail.getSold() != null ? detail.getSold() : 0L)
                .sum();
    }

    @Override
    public void enrichProductResponseDTO(ProductResponseDTO dto) {
        if (dto != null && dto.getId() != null) {
            // Calculate and set total quantity
            dto.setTotalQuantity(getTotalQuantityForProduct(dto.getId()));

            // Calculate and set total sold
            dto.setTotalSold(getTotalSoldForProduct(dto.getId()));

            // Check if product has vouchers (implement when needed)
            dto.setHasVoucher(false); // Default for now
        }
    }

    @Override
    public void hideProductForViolation(Long productId, String violationType, String adminNotes) {
        Optional<Product> productOpt = productRepository.findById(productId);
        if (productOpt.isPresent()) {
            Product product = productOpt.get();
            product.setStatus("HIDDEN");
            product.setViolationType(violationType);
            product.setAdminNotes(adminNotes);
            product.setLastModifiedByAdmin(java.time.LocalDateTime.now());
            productRepository.save(product);
        }
    }

    @Override
    public void lockProductForViolation(Long productId, String violationType, String adminNotes) {
        Optional<Product> productOpt = productRepository.findById(productId);
        if (productOpt.isPresent()) {
            Product product = productOpt.get();
            product.setStatus("LOCKED");
            product.setViolationType(violationType);
            product.setAdminNotes(adminNotes);
            product.setLastModifiedByAdmin(java.time.LocalDateTime.now());
            productRepository.save(product);
        }
    }

    @Override
    public void activateProduct(Long productId) {
        Optional<Product> productOpt = productRepository.findById(productId);
        if (productOpt.isPresent()) {
            Product product = productOpt.get();
            product.setStatus("ACTIVE");
            product.setViolationType(null);
            product.setAdminNotes(null);
            product.setLastModifiedByAdmin(java.time.LocalDateTime.now());
            productRepository.save(product);
        }
    }
}
