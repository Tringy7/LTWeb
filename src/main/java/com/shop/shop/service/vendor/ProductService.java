package com.shop.shop.service.vendor;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.shop.shop.domain.Product;
import com.shop.shop.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }

    public List<Product> getProductsByShopId(Long shopId) {
        return productRepository.findByShopId(shopId);
    }

    public Optional<Product> getProductById(Long id) {
        return productRepository.findById(id);
    }

    public Product save(Product p) {
        return productRepository.save(p);
    }

    public void deleteProductById(Long id) {
        productRepository.deleteById(id);
    }

    public Optional<Product> getProductByIdAndShopId(Long id, Long shopId) {
        return productRepository.findByIdAndShopId(id, shopId);
    }

    public List<Product> searchProductsByName(Long shopId, String keyword) {
        return productRepository.findByShopIdAndNameContaining(shopId, keyword);
    }

    public List<String> getCategoriesByShopId(Long shopId) {
        return productRepository.findDistinctCategoriesByShopId(shopId);
    }

    public List<Product> getProductsByShopIdAndCategory(Long shopId, String category) {
        return productRepository.findByShopIdAndCategory(shopId, category);
    }

    public List<Product> searchProductsByNameAndCategory(Long shopId, String keyword, String category) {
        return productRepository.findByShopIdAndNameAndCategory(shopId, keyword, category);
    }

}
