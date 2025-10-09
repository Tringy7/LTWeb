package com.shop.shop.service.client.impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;
import com.shop.shop.repository.client.ProductRepository;
import com.shop.shop.service.client.ProductService;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;

    @Override
    public List<Product> getAllProduct() {
        return productRepository.findAll();
    }

    @Override
    public List<Product> getAllProductSoldOver10() {
        List<Product> allProducts = productRepository.findAll();
        return allProducts.stream()
                .filter(product -> {
                    long totalSold = product.getProductDetails().stream()
                            .mapToLong(ProductDetail::getSold)
                            .sum();
                    return totalSold > 10;
                })
                .toList();
    }

    @Override
    public Product getProductTopSold() {
        List<Product> allProducts = productRepository.findAll();
        return allProducts.stream()
                .max((p1, p2) -> {
                    long sold1 = p1.getProductDetails().stream().mapToLong(ProductDetail::getSold).sum();
                    long sold2 = p2.getProductDetails().stream().mapToLong(ProductDetail::getSold).sum();
                    return Long.compare(sold1, sold2);
                })
                .orElse(null);
    }

    @Override
    public Page<Product> getProductPage(Pageable pageable) {
        return productRepository.findAll(pageable);
    }

    @Override
    public Product getProductById(Long id) {
        Optional<Product> check = productRepository.findById(id);
        if (check.isPresent()) {
            Product product = check.get();
            return product;
        }
        return null;
    }
}
