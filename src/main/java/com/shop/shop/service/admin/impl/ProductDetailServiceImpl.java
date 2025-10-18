package com.shop.shop.service.admin.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shop.shop.domain.ProductDetail;
import com.shop.shop.repository.ProductDetailRepository;
import com.shop.shop.service.admin.ProductDetailService;

/**
 * Implementation of ProductDetailService interface Follows clean architecture:
 * Business logic implementation using Spring Data JPA
 */
@Service("adminProductDetailService")
@Transactional
public class ProductDetailServiceImpl implements ProductDetailService {

    private final ProductDetailRepository productDetailRepository;

    public ProductDetailServiceImpl(ProductDetailRepository productDetailRepository) {
        this.productDetailRepository = productDetailRepository;
    }

    @Override
    @Transactional(readOnly = true)
    public List<ProductDetail> getProductDetailsByProductId(Long productId) {
        return productDetailRepository.findByProductId(productId);
    }

    @Override
    @Transactional(readOnly = true)
    public ProductDetail getProductDetailByProductIdAndSize(Long productId, String size) {
        return productDetailRepository.findByProductIdAndSize(productId, size);
    }

    @Override
    public ProductDetail saveProductDetail(ProductDetail productDetail) {
        return productDetailRepository.save(productDetail);
    }

    @Override
    public void deleteProductDetail(Long id) {
        productDetailRepository.deleteById(id);
    }

    @Override
    public void deleteProductDetailsByProductId(Long productId) {
        productDetailRepository.deleteByProductId(productId);
    }

    @Override
    @Transactional(readOnly = true)
    public boolean existsByProductIdAndSize(Long productId, String size) {
        return productDetailRepository.existsByProductIdAndSize(productId, size);
    }

    @Override
    @Transactional(readOnly = true)
    public List<String> getAvailableSizesForProduct(Long productId) {
        List<ProductDetail> productDetails = productDetailRepository.findByProductId(productId);
        return productDetails.stream()
                .map(ProductDetail::getSize)
                .filter(size -> size != null && !size.trim().isEmpty())
                .distinct()
                .collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<ProductDetail> getProductDetailsWithStock(Long productId) {
        return productDetailRepository.findByProductIdAndQuantityGreaterThan(productId, 0L);
    }

    @Override
    @Transactional(readOnly = true)
    public Long calculateTotalQuantity(Long productId) {
        List<ProductDetail> productDetails = productDetailRepository.findByProductId(productId);
        return productDetails.stream()
                .mapToLong(detail -> detail.getQuantity() != null ? detail.getQuantity() : 0L)
                .sum();
    }

    @Override
    @Transactional(readOnly = true)
    public Long calculateTotalSold(Long productId) {
        List<ProductDetail> productDetails = productDetailRepository.findByProductId(productId);
        return productDetails.stream()
                .mapToLong(detail -> detail.getSold() != null ? detail.getSold() : 0L)
                .sum();
    }

    @Override
    public ProductDetail updateStock(Long productId, String size, Long newQuantity) {
        ProductDetail productDetail = productDetailRepository.findByProductIdAndSize(productId, size);
        if (productDetail != null) {
            productDetail.setQuantity(newQuantity);
            return productDetailRepository.save(productDetail);
        }
        return null;
    }

    @Override
    public ProductDetail addToSoldQuantity(Long productId, String size, Long soldAmount) {
        ProductDetail productDetail = productDetailRepository.findByProductIdAndSize(productId, size);
        if (productDetail != null) {
            Long currentSold = productDetail.getSold() != null ? productDetail.getSold() : 0L;
            Long currentQuantity = productDetail.getQuantity() != null ? productDetail.getQuantity() : 0L;

            // Update sold quantity
            productDetail.setSold(currentSold + soldAmount);

            // Reduce available quantity
            productDetail.setQuantity(Math.max(0L, currentQuantity - soldAmount));

            return productDetailRepository.save(productDetail);
        }
        return null;
    }
}
