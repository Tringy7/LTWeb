package com.shop.shop.service.client;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import com.shop.shop.domain.Product;

public interface ProductService {

    List<Product> getAllProduct();

    List<Product> getAllProductSoldOver10();

    Product getProductTopSold();

    Page<Product> getProductPage(Pageable pageable);

    Product getProductById(Long id);
}
