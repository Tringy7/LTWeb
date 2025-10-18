package com.shop.shop.service.vendor;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.shop.shop.domain.ProductDetail;
import com.shop.shop.repository.ProductDetailRepository;

@Service("vendorProductDetailService")
public class ProductDetailService {
    private final ProductDetailRepository productDetailRepository;

    public ProductDetailService(ProductDetailRepository productDetailRepository) {
        this.productDetailRepository = productDetailRepository;
    }

    public List<ProductDetail> getByProductId(Long productId) {
        return productDetailRepository.findByProductId(productId);
    }

    public void save(ProductDetail d) {
        productDetailRepository.save(d);
    }

    public List<ProductDetail> getDetailsByProductId(Long productId) {
        return productDetailRepository.findByProductId(productId);
    }

    public void saveAll(List<ProductDetail> details) {
        productDetailRepository.saveAll(details);
    }

    public void deleteByProductId(Long productId) {
        productDetailRepository.deleteById(productId);
    }

    public ProductDetail getById(Long id) {
        Optional<ProductDetail> optional = productDetailRepository.findById(id);
        return optional.orElse(null);
    }

}
