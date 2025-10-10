package com.shop.shop.service.client;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.shop.shop.domain.Product;
import com.shop.shop.dto.FilterDTO;

public interface ProductService {

    List<Product> getAllProduct();

    List<Product> getAllProductSoldOver10();

    List<Product> getProductTopSold();

    Page<Product> getProductPage(Pageable pageable);

    Product getProductById(Long id);

    List<Product> searchProductsByName(String name);

    FilterDTO getBraList();

    List<Product> filterProducts(Double maxPrice, List<String> brand, List<String> size, List<String> color, List<String> gender);
}
