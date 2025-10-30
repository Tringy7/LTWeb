package com.shop.shop.service.client.impl;

import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.shop.shop.domain.Product;
import com.shop.shop.dto.FilterDTO;
import com.shop.shop.repository.ProductRepository;
import com.shop.shop.service.client.ProductService;

@Service("clientProductService")
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductRepository productRepository;

    private boolean isProductAndShopActive(Product p) {
        if (p == null) {
            return false;
        }
        String prodStatus = p.getStatus();
        if (prodStatus == null || !"ACTIVE".equalsIgnoreCase(prodStatus) || !"Active".equalsIgnoreCase(prodStatus)) {
            return false;
        }
        if (p.getShop() == null) {
            return false;
        }
        String shopStatus = p.getShop().getStatus();
        if (shopStatus == null) {
            return false;
        }
        return "Active".equalsIgnoreCase(shopStatus) || "ACTIVE".equalsIgnoreCase(shopStatus);
    }

    @Override
    public List<Product> getAllProduct() {
        return productRepository.findAll().stream()
                .filter(this::isProductAndShopActive)
                .toList();
    }

    @Override
    public List<Product> getAllProductSoldOver10() {
        List<Product> allProducts = productRepository.findAll();
        return allProducts.stream()
                .filter(this::isProductAndShopActive)
                .filter(product -> {
                    long totalSold = 0L;
                    if (product.getProductDetails() != null) {
                        totalSold = product.getProductDetails().stream().mapToLong(pd -> pd.getSold() == null ? 0L : pd.getSold()).sum();
                    }
                    return totalSold > 10;
                })
                .toList();
    }

    @Override
    public List<Product> getProductTopSold() {
        List<Product> allProducts = productRepository.findAll().stream().filter(this::isProductAndShopActive).toList();
        return allProducts.stream()
                .sorted((p1, p2) -> {
                    long sold1 = 0L;
                    long sold2 = 0L;
                    if (p1.getProductDetails() != null) {
                        sold1 = p1.getProductDetails().stream().mapToLong(pd -> pd.getSold() == null ? 0L : pd.getSold()).sum();
                    }
                    if (p2.getProductDetails() != null) {
                        sold2 = p2.getProductDetails().stream().mapToLong(pd -> pd.getSold() == null ? 0L : pd.getSold()).sum();
                    }
                    return Long.compare(sold2, sold1);
                })
                .limit(2)
                .toList();
    }

    @Override
    public Page<Product> getProductPage(Pageable pageable) {
        Page<Product> page = productRepository.findAll(pageable);
        List<Product> filtered = page.getContent().stream().filter(this::isProductAndShopActive).toList();
        return new PageImpl<>(filtered, pageable, filtered.size());
    }

    @Override
    public Product getProductById(Long id) {
        Optional<Product> check = productRepository.findById(id);
        if (check.isPresent()) {
            Product product = check.get();
            return isProductAndShopActive(product) ? product : null;
        }
        return null;
    }

    @Override
    public List<Product> searchProductsByName(String name) {
        return productRepository.findByNameContainingIgnoreCase(name).stream()
                .filter(this::isProductAndShopActive)
                .toList();
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
        return productRepository.filterProducts(maxPrice, brand, size, color, gender).stream()
                .filter(this::isProductAndShopActive)
                .toList();
    }
}
