package com.shop.shop.service.client.impl;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Product;
import com.shop.shop.domain.ProductDetail;
import com.shop.shop.dto.FilterDTO;
import com.shop.shop.repository.ProductRepository;
import com.shop.shop.service.client.ProductService;

@Service("clientProductService")
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
    public List<Product> getProductTopSold() {
        List<Product> allProducts = productRepository.findAll();
        return allProducts.stream()
                .sorted((p1, p2) -> {
                    long sold1 = p1.getProductDetails().stream().mapToLong(ProductDetail::getSold).sum();
                    long sold2 = p2.getProductDetails().stream().mapToLong(ProductDetail::getSold).sum();
                    return Long.compare(sold2, sold1);
                })
                .limit(2)
                .toList();
    }

    @Override
    public Page<Product> getProductPage(Pageable pageable) {
        return productRepository.findAll(pageable); // Sử dụng phương thức phân trang của JPA
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

    @Override
    public List<Product> searchProductsByName(String name) {
        return productRepository.findByNameContainingIgnoreCase(name);
    }

    @Override
    public FilterDTO getBraList() {
        List<Product> products = this.getAllProduct();
        FilterDTO filter = new FilterDTO();
        Set<String> brandList = new HashSet<>();
        Set<String> sizeList = new HashSet<>();
        Set<String> colorList = new HashSet<>();
        Set<String> genderList = new HashSet<>();
        Collections.addAll(genderList, "Nam", "Nữ");
        Collections.addAll(sizeList, "S", "M", "L", "XL");

        for (Product it : products) {
            brandList.add(it.getBrand());
            colorList.add(it.getColor());
        }
        filter.setBrandList(brandList);
        filter.setSizeList(sizeList);
        filter.setColorList(colorList);
        filter.setGenderList(genderList);
        return filter;
    }

    @Override
    public List<Product> filterProducts(Double maxPrice, List<String> brand, List<String> size, List<String> color, List<String> gender) {
        return productRepository.filterProducts(maxPrice, brand, size, color, gender);
    }
}
